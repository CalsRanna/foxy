import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/page/emote_text/emote_text_validation_mixin.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class EmoteTextDetailViewModel
    with
        FieldControllerMixin,
        ViewModelValidationMixin,
        EmoteTextValidationMixin {
  final _repository = GetIt.instance.get<EmoteTextRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<EmoteTextEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Basic
  late final idController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final emoteIdController = registerController(IntFieldController());

  /// EmoteText
  late final emoteText0Controller = registerController(IntFieldController());
  late final emoteText1Controller = registerController(IntFieldController());
  late final emoteText2Controller = registerController(IntFieldController());
  late final emoteText3Controller = registerController(IntFieldController());
  late final emoteText4Controller = registerController(IntFieldController());
  late final emoteText5Controller = registerController(IntFieldController());
  late final emoteText6Controller = registerController(IntFieldController());
  late final emoteText7Controller = registerController(IntFieldController());
  late final emoteText8Controller = registerController(IntFieldController());
  late final emoteText9Controller = registerController(IntFieldController());
  late final emoteText10Controller = registerController(IntFieldController());
  late final emoteText11Controller = registerController(IntFieldController());
  late final emoteText12Controller = registerController(IntFieldController());
  late final emoteText13Controller = registerController(IntFieldController());
  late final emoteText14Controller = registerController(IntFieldController());
  late final emoteText15Controller = registerController(IntFieldController());

  /// 从所有 Controller 收集数据构建 EmoteText

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createEmoteText();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getEmoteText(key);
      if (result == null) {
        throw StateError('原表情文本不存在，可能已被其他操作修改或删除');
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
      validateEmoteTextFields(candidate);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeEmoteText(candidate);
      } else {
        await _repository.updateEmoteText(originalKey, candidate);
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

  EmoteTextEntity _collectCandidate() {
    return EmoteTextEntity(
      id: idController.collect(),
      name: nameController.collect(),
      emoteId: emoteIdController.collect(),
      emoteText0: emoteText0Controller.collect(),
      emoteText1: emoteText1Controller.collect(),
      emoteText2: emoteText2Controller.collect(),
      emoteText3: emoteText3Controller.collect(),
      emoteText4: emoteText4Controller.collect(),
      emoteText5: emoteText5Controller.collect(),
      emoteText6: emoteText6Controller.collect(),
      emoteText7: emoteText7Controller.collect(),
      emoteText8: emoteText8Controller.collect(),
      emoteText9: emoteText9Controller.collect(),
      emoteText10: emoteText10Controller.collect(),
      emoteText11: emoteText11Controller.collect(),
      emoteText12: emoteText12Controller.collect(),
      emoteText13: emoteText13Controller.collect(),
      emoteText14: emoteText14Controller.collect(),
      emoteText15: emoteText15Controller.collect(),
    );
  }

  void _applyCandidate(EmoteTextEntity emoteText) {
    idController.init(emoteText.id);
    nameController.init(emoteText.name);
    emoteIdController.init(emoteText.emoteId);
    emoteText0Controller.init(emoteText.emoteText0);
    emoteText1Controller.init(emoteText.emoteText1);
    emoteText2Controller.init(emoteText.emoteText2);
    emoteText3Controller.init(emoteText.emoteText3);
    emoteText4Controller.init(emoteText.emoteText4);
    emoteText5Controller.init(emoteText.emoteText5);
    emoteText6Controller.init(emoteText.emoteText6);
    emoteText7Controller.init(emoteText.emoteText7);
    emoteText8Controller.init(emoteText.emoteText8);
    emoteText9Controller.init(emoteText.emoteText9);
    emoteText10Controller.init(emoteText.emoteText10);
    emoteText11Controller.init(emoteText.emoteText11);
    emoteText12Controller.init(emoteText.emoteText12);
    emoteText13Controller.init(emoteText.emoteText13);
    emoteText14Controller.init(emoteText.emoteText14);
    emoteText15Controller.init(emoteText.emoteText15);
  }

  void _logActivity(ActivityActionType action, EmoteTextEntity t) {
    final log = ActivityLogEntity(
      module: 'emote_text',
      actionType: action,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
