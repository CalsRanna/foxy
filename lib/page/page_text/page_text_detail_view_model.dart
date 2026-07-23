import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/page_text_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class PageTextDetailViewModel
    with
        ViewModelValidationMixin,
        PageTextValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<PageTextRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<PageTextEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final textController = registerController(StringFieldController());
  late final nextPageIdController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createPageText();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getPageText(key);
      if (result == null) {
        throw StateError('原页面文本不存在，可能已被其他操作修改或删除');
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
      final data = _collectCandidate();
      validatePageTextFields(data);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storePageText(data);
      } else {
        await _repository.updatePageText(originalKey, data);
      }
      final newKey = data.id;
      persistedKey.value = newKey;
      entity.value = data;
      _logActivity(action, data);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  PageTextEntity _collectCandidate() {
    return PageTextEntity(
      id: idController.collect(),
      text: textController.collect(),
      nextPageId: nextPageIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _applyCandidate(PageTextEntity pt) {
    idController.init(pt.id);
    textController.init(pt.text);
    nextPageIdController.init(pt.nextPageId);
    verifiedBuildController.init(pt.verifiedBuild);
  }

  void _logActivity(ActivityActionType action, PageTextEntity t) {
    final log = ActivityLogEntity(
      module: 'page_text',
      actionType: action,
      entityName: t.text,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
