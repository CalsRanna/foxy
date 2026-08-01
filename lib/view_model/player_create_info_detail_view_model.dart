import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'player_create_info_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: PlayerCreateInfoEntity, selects: {'class_': 0, 'race': 0})
class PlayerCreateInfoDetailViewModel
    with
        FieldControllerMixin, _PlayerCreateInfoDetailViewModelMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<PlayerCreateInfoEntity?>(null);
  final persistedKey = signal<PlayerCreateInfoKey?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({PlayerCreateInfoKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createPlayerCreateInfo();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getPlayerCreateInfo(key);
      if (result == null) {
        throw StateError('原出生信息记录不存在，可能已被其他操作修改或删除');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storePlayerCreateInfo(candidate);
      } else {
        await _repository.updatePlayerCreateInfo(originalKey, candidate);
      }
      persistedKey.value = PlayerCreateInfoKey.fromEntity(candidate);
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _logActivity(ActivityActionType action, PlayerCreateInfoEntity t) {
    final log = ActivityLogEntity(
      module: 'player_create_info',
      actionType: action,
      entityName: 'PlayerCreateInfo ${t.race}/${t.class_}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
