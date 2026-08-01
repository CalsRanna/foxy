import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'glyph_property_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: GlyphPropertyEntity, selects: {'glyphSlotFlags': 0})
class GlyphPropertyDetailViewModel
    with
        FieldControllerMixin, _GlyphPropertyDetailViewModelMixin {
  final _repository = GetIt.instance.get<GlyphPropertyRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<GlyphPropertyEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  void dispose() {
    disposeControllers();
  }

  /// 从所有 Controller 收集数据构建 GlyphProperty

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createGlyphProperty();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getGlyphProperty(key);
      if (result == null) {
        throw StateError('原雕文属性不存在，可能已被其他操作修改或删除');
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
        await _repository.storeGlyphProperty(candidate);
      } else {
        await _repository.updateGlyphProperty(originalKey, candidate);
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

  void _logActivity(ActivityActionType action, GlyphPropertyEntity t) {
    final log = ActivityLogEntity(
      module: 'glyph_property',
      actionType: action,
      entityName: 'GlyphProperty ${t.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
