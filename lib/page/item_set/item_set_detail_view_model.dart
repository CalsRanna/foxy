import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';

part 'item_set_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: ItemSetEntity)
class ItemSetDetailViewModel
    with
        FieldControllerMixin, _ItemSetDetailViewModelMixin {
  final _repository = GetIt.instance.get<ItemSetRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<ItemSetEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);
  final nameLangFlags = signal<int>(0);

  /// 从所有 Controller 收集数据构建 ItemSetEntity

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createItemSet();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getItemSet(key);
      if (result == null) {
        throw StateError('原套装不存在，可能已被其他操作修改或删除');
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

  /// 退出页面
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
        await _repository.storeItemSet(candidate);
      } else {
        await _repository.updateItemSet(originalKey, candidate);
      }
      persistedKey.value = candidate.id;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void applyNameLocales(List<DbcLocaleFieldValue> values) {
    nameLangEnUSController.init(values.valueOf('enUS'));
    nameLangKoKRController.init(values.valueOf('koKR'));
    nameLangFrFRController.init(values.valueOf('frFR'));
    nameLangDeDEController.init(values.valueOf('deDE'));
    nameLangZhCNController.init(values.valueOf('zhCN'));
    nameLangZhTWController.init(values.valueOf('zhTW'));
    nameLangEsESController.init(values.valueOf('esES'));
    nameLangEsMXController.init(values.valueOf('esMX'));
    nameLangRuRUController.init(values.valueOf('ruRU'));
    nameLangJaJPController.init(values.valueOf('jaJP'));
    nameLangPtPTController.init(values.valueOf('ptPT'));
    nameLangPtBRController.init(values.valueOf('ptBR'));
    nameLangItITController.init(values.valueOf('itIT'));
    nameLangUnk1Controller.init(values.valueOf('unk1'));
    nameLangUnk2Controller.init(values.valueOf('unk2'));
    nameLangUnk3Controller.init(values.valueOf('unk3'));
    entity.value = _collectCandidate();
  }

  void _logActivity(ActivityActionType action, ItemSetEntity t) {
    final log = ActivityLogEntity(
      module: 'item_set',
      actionType: action,
      entityName: 'ItemSet ${t.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
