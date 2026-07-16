import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/game_object_template_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectTemplateDetailViewModel
    with
        ViewModelValidationMixin,
        GameObjectTemplateValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<GameObjectTemplateRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  late final nameController = registerController(StringFieldController());
  late final castBarCaptionController = registerController(
    StringFieldController(),
  );
  late final iconNameController = registerController(StringFieldController());
  late final typeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final unk1Controller = registerController(StringFieldController());
  late final aiNameController = registerController(StringFieldController());
  late final scriptNameController = registerController(StringFieldController());

  late final entryController = registerController(IntFieldController());
  late final displayIdController = registerController(IntFieldController());
  late final sizeController = registerController(DoubleFieldController());
  late final data0Controller = registerController(IntFieldController());
  late final data1Controller = registerController(IntFieldController());
  late final data2Controller = registerController(IntFieldController());
  late final data3Controller = registerController(IntFieldController());
  late final data4Controller = registerController(IntFieldController());
  late final data5Controller = registerController(IntFieldController());
  late final data6Controller = registerController(IntFieldController());
  late final data7Controller = registerController(IntFieldController());
  late final data8Controller = registerController(IntFieldController());
  late final data9Controller = registerController(IntFieldController());
  late final data10Controller = registerController(IntFieldController());
  late final data11Controller = registerController(IntFieldController());
  late final data12Controller = registerController(IntFieldController());
  late final data13Controller = registerController(IntFieldController());
  late final data14Controller = registerController(IntFieldController());
  late final data15Controller = registerController(IntFieldController());
  late final data16Controller = registerController(IntFieldController());
  late final data17Controller = registerController(IntFieldController());
  late final data18Controller = registerController(IntFieldController());
  late final data19Controller = registerController(IntFieldController());
  late final data20Controller = registerController(IntFieldController());
  late final data21Controller = registerController(IntFieldController());
  late final data22Controller = registerController(IntFieldController());
  late final data23Controller = registerController(IntFieldController());

  late final verifiedBuildController = registerController(IntFieldController());

  final template = signal(GameObjectTemplateEntity());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? entry}) async {
    try {
      if (entry == null || entry <= 0) {
        final blank = await _repository.createGameObjectTemplate();
        template.value = blank;
        _initControllers(blank);
        return;
      }
      final result = await _repository.getGameObjectTemplate(entry);
      if (result == null) return;
      template.value = result;
      _initControllers(result);
    } catch (e) {
      LoggerUtil.instance.e('加载游戏对象详情失败: $e');
      DialogUtil.instance.error('加载游戏对象详情失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<int?> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      validateGameObjectTemplateFields(t);
      final existed = await _repository.getGameObjectTemplate(t.entry);
      if (existed == null) {
        final id = await _repository.storeGameObjectTemplate(t);
        entryController.init(id);
        template.value = t.copyWith(entry: id);
        _logActivity(ActivityActionType.create, template.value);
      } else {
        await _repository.updateGameObjectTemplate(t);
        template.value = t;
        _logActivity(ActivityActionType.update, t);
      }
      if (!context.mounted) return template.value.entry;
      var toast = ShadToast(description: Text('模板数据已保存'));
      ShadSonner.of(context).show(toast);
      return template.value.entry;
    } catch (e) {
      if (!context.mounted) return null;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
      return null;
    }
  }

  GameObjectTemplateEntity _collectFromControllers() {
    return GameObjectTemplateEntity(
      entry: entryController.collect(),
      name: nameController.collect(),
      castBarCaption: castBarCaptionController.collect(),
      iconName: iconNameController.collect(),
      type: typeController.collect(),
      displayId: displayIdController.collect(),
      size: sizeController.collect(),
      unk1: unk1Controller.collect(),
      data0: data0Controller.collect(),
      data1: data1Controller.collect(),
      data2: data2Controller.collect(),
      data3: data3Controller.collect(),
      data4: data4Controller.collect(),
      data5: data5Controller.collect(),
      data6: data6Controller.collect(),
      data7: data7Controller.collect(),
      data8: data8Controller.collect(),
      data9: data9Controller.collect(),
      data10: data10Controller.collect(),
      data11: data11Controller.collect(),
      data12: data12Controller.collect(),
      data13: data13Controller.collect(),
      data14: data14Controller.collect(),
      data15: data15Controller.collect(),
      data16: data16Controller.collect(),
      data17: data17Controller.collect(),
      data18: data18Controller.collect(),
      data19: data19Controller.collect(),
      data20: data20Controller.collect(),
      data21: data21Controller.collect(),
      data22: data22Controller.collect(),
      data23: data23Controller.collect(),
      aiName: aiNameController.collect(),
      scriptName: scriptNameController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _initControllers(GameObjectTemplateEntity template) {
    entryController.init(template.entry);
    nameController.init(template.name);
    castBarCaptionController.init(template.castBarCaption);
    iconNameController.init(template.iconName);
    typeController.init(template.type);
    displayIdController.init(template.displayId);
    sizeController.init(template.size);
    unk1Controller.init(template.unk1);
    data0Controller.init(template.data0);
    data1Controller.init(template.data1);
    data2Controller.init(template.data2);
    data3Controller.init(template.data3);
    data4Controller.init(template.data4);
    data5Controller.init(template.data5);
    data6Controller.init(template.data6);
    data7Controller.init(template.data7);
    data8Controller.init(template.data8);
    data9Controller.init(template.data9);
    data10Controller.init(template.data10);
    data11Controller.init(template.data11);
    data12Controller.init(template.data12);
    data13Controller.init(template.data13);
    data14Controller.init(template.data14);
    data15Controller.init(template.data15);
    data16Controller.init(template.data16);
    data17Controller.init(template.data17);
    data18Controller.init(template.data18);
    data19Controller.init(template.data19);
    data20Controller.init(template.data20);
    data21Controller.init(template.data21);
    data22Controller.init(template.data22);
    data23Controller.init(template.data23);
    aiNameController.init(template.aiName);
    scriptNameController.init(template.scriptName);
    verifiedBuildController.init(template.verifiedBuild);
  }

  void _logActivity(ActivityActionType action, GameObjectTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'gameobject_template',
      actionType: action,
      entityId: t.entry,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
