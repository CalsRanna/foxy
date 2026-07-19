import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/page/emote_text/emote_text_validation_mixin.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class EmoteTextDetailViewModel
    with
        FieldControllerMixin,
        ViewModelValidationMixin,
        EmoteTextValidationMixin {
  final _repository = GetIt.instance.get<EmoteTextRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

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

  final emote = signal(EmoteTextEntity());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createEmoteText();
        emote.value = blank;
        _initControllers(blank);
        return;
      }
      emote.value = (await _repository.getEmoteText(id))!;
      _initControllers(emote.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载表情文本(id=$id)失败', error: e, stackTrace: s);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      validateEmoteTextFields(t);
      final isCreate = await _repository.getEmoteText(t.id) == null;
      if (isCreate) {
        final id = await _repository.storeEmoteText(t);
        t = t.copyWith(id: id);
        idController.init(id);
      } else {
        await _repository.updateEmoteText(t);
      }
      emote.value = t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('表情文本数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 从所有 Controller 收集数据构建 EmoteText
  EmoteTextEntity _collectFromControllers() {
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

  void _initControllers(EmoteTextEntity emoteText) {
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
