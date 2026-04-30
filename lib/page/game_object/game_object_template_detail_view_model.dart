import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectTemplateDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final castBarCaptionController = TextEditingController();
  final iconNameController = TextEditingController();
  final typeController = ShadSelectController<int>();
  final displayIdController = TextEditingController();
  final sizeController = TextEditingController();
  final unk1Controller = TextEditingController();
  final data0Controller = TextEditingController();
  final data1Controller = TextEditingController();
  final data2Controller = TextEditingController();
  final data3Controller = TextEditingController();
  final data4Controller = TextEditingController();
  final data5Controller = TextEditingController();
  final data6Controller = TextEditingController();
  final data7Controller = TextEditingController();
  final data8Controller = TextEditingController();
  final data9Controller = TextEditingController();
  final data10Controller = TextEditingController();
  final data11Controller = TextEditingController();
  final data12Controller = TextEditingController();
  final data13Controller = TextEditingController();
  final data14Controller = TextEditingController();
  final data15Controller = TextEditingController();
  final data16Controller = TextEditingController();
  final data17Controller = TextEditingController();
  final data18Controller = TextEditingController();
  final data19Controller = TextEditingController();
  final data20Controller = TextEditingController();
  final data21Controller = TextEditingController();
  final data22Controller = TextEditingController();
  final data23Controller = TextEditingController();
  final aiNameController = TextEditingController();
  final scriptNameController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final entry = signal(0);
  final template = signal(GameObjectTemplateEntity());

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = GameObjectTemplateRepository();
      final isNew = t.entry == 0;
      if (isNew) {
        await repository.storeGameObjectTemplate(t);
      } else {
        await repository.updateGameObjectTemplate(t);
      }
      template.value = t;
      _logActivity(
        isNew ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  GameObjectTemplateEntity _collectFromControllers() {
    return GameObjectTemplateEntity(
      entry: _parseInt(entryController.text),
      name: nameController.text,
      castBarCaption: castBarCaptionController.text,
      iconName: iconNameController.text,
      type: _getSelectValue(typeController),
      displayId: _parseInt(displayIdController.text),
      size: _parseDouble(sizeController.text),
      unk1: unk1Controller.text,
      data0: _parseInt(data0Controller.text),
      data1: _parseInt(data1Controller.text),
      data2: _parseInt(data2Controller.text),
      data3: _parseInt(data3Controller.text),
      data4: _parseInt(data4Controller.text),
      data5: _parseInt(data5Controller.text),
      data6: _parseInt(data6Controller.text),
      data7: _parseInt(data7Controller.text),
      data8: _parseInt(data8Controller.text),
      data9: _parseInt(data9Controller.text),
      data10: _parseInt(data10Controller.text),
      data11: _parseInt(data11Controller.text),
      data12: _parseInt(data12Controller.text),
      data13: _parseInt(data13Controller.text),
      data14: _parseInt(data14Controller.text),
      data15: _parseInt(data15Controller.text),
      data16: _parseInt(data16Controller.text),
      data17: _parseInt(data17Controller.text),
      data18: _parseInt(data18Controller.text),
      data19: _parseInt(data19Controller.text),
      data20: _parseInt(data20Controller.text),
      data21: _parseInt(data21Controller.text),
      data22: _parseInt(data22Controller.text),
      data23: _parseInt(data23Controller.text),
      aiName: aiNameController.text,
      scriptName: scriptNameController.text,
      verifiedBuild: _parseInt(verifiedBuildController.text),
    );
  }

  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;
  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  double _parseDouble(String text) {
    if (text.isEmpty) return 0.0;
    final value = double.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
    castBarCaptionController.dispose();
    iconNameController.dispose();
    displayIdController.dispose();
    sizeController.dispose();
    unk1Controller.dispose();
    data0Controller.dispose();
    data1Controller.dispose();
    data2Controller.dispose();
    data3Controller.dispose();
    data4Controller.dispose();
    data5Controller.dispose();
    data6Controller.dispose();
    data7Controller.dispose();
    data8Controller.dispose();
    data9Controller.dispose();
    data10Controller.dispose();
    data11Controller.dispose();
    data12Controller.dispose();
    data13Controller.dispose();
    data14Controller.dispose();
    data15Controller.dispose();
    data16Controller.dispose();
    data17Controller.dispose();
    data18Controller.dispose();
    data19Controller.dispose();
    data20Controller.dispose();
    data21Controller.dispose();
    data22Controller.dispose();
    data23Controller.dispose();
    aiNameController.dispose();
    scriptNameController.dispose();
    verifiedBuildController.dispose();
  }

  Future<void> initSignals({int? entry}) async {
    if (entry == null) return;
    try {
      template.value = await GameObjectTemplateRepository().getGameObjectTemplate(
        entry,
      );
      _initControllers(template.value);
    } catch (e) {
      LoggerUtil.instance.e('加载游戏对象详情失败: $e');
      DialogUtil.instance.error('加载游戏对象详情失败: $e');
    }
  }

  void _initControllers(GameObjectTemplateEntity template) {
    entryController.text = template.entry.toString();
    nameController.text = template.name;
    castBarCaptionController.text = template.castBarCaption;
    iconNameController.text = template.iconName;
    displayIdController.text = template.displayId.toString();
    sizeController.text = template.size.toString();
    unk1Controller.text = template.unk1;
    data0Controller.text = template.data0.toString();
    data1Controller.text = template.data1.toString();
    data2Controller.text = template.data2.toString();
    data3Controller.text = template.data3.toString();
    data4Controller.text = template.data4.toString();
    data5Controller.text = template.data5.toString();
    data6Controller.text = template.data6.toString();
    data7Controller.text = template.data7.toString();
    data8Controller.text = template.data8.toString();
    data9Controller.text = template.data9.toString();
    data10Controller.text = template.data10.toString();
    data11Controller.text = template.data11.toString();
    data12Controller.text = template.data12.toString();
    data13Controller.text = template.data13.toString();
    data14Controller.text = template.data14.toString();
    data15Controller.text = template.data15.toString();
    data16Controller.text = template.data16.toString();
    data17Controller.text = template.data17.toString();
    data18Controller.text = template.data18.toString();
    data19Controller.text = template.data19.toString();
    data20Controller.text = template.data20.toString();
    data21Controller.text = template.data21.toString();
    data22Controller.text = template.data22.toString();
    data23Controller.text = template.data23.toString();
    aiNameController.text = template.aiName;
    scriptNameController.text = template.scriptName;
    verifiedBuildController.text = template.verifiedBuild.toString();
  }

  void _logActivity(ActivityActionType action, GameObjectTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'gameobject_template',
      actionType: action,
      entityId: t.entry,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
