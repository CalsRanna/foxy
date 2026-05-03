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

  final nameController = TextEditingController();
  final castBarCaptionController = TextEditingController();
  final iconNameController = TextEditingController();
  final typeController = ShadSelectController<int>();
  final unk1Controller = TextEditingController();
  final aiNameController = TextEditingController();
  final scriptNameController = TextEditingController();

  final entry = signal<int>(0);
  final displayId = signal<int>(0);
  final size = signal<double>(0.0);
  final data0 = signal<int>(0);
  final data1 = signal<int>(0);
  final data2 = signal<int>(0);
  final data3 = signal<int>(0);
  final data4 = signal<int>(0);
  final data5 = signal<int>(0);
  final data6 = signal<int>(0);
  final data7 = signal<int>(0);
  final data8 = signal<int>(0);
  final data9 = signal<int>(0);
  final data10 = signal<int>(0);
  final data11 = signal<int>(0);
  final data12 = signal<int>(0);
  final data13 = signal<int>(0);
  final data14 = signal<int>(0);
  final data15 = signal<int>(0);
  final data16 = signal<int>(0);
  final data17 = signal<int>(0);
  final data18 = signal<int>(0);
  final data19 = signal<int>(0);
  final data20 = signal<int>(0);
  final data21 = signal<int>(0);
  final data22 = signal<int>(0);
  final data23 = signal<int>(0);
  final verifiedBuild = signal<int>(0);

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
      entry: entry.value,
      name: nameController.text,
      castBarCaption: castBarCaptionController.text,
      iconName: iconNameController.text,
      type: _getSelectValue(typeController),
      displayId: displayId.value,
      size: size.value,
      unk1: unk1Controller.text,
      data0: data0.value,
      data1: data1.value,
      data2: data2.value,
      data3: data3.value,
      data4: data4.value,
      data5: data5.value,
      data6: data6.value,
      data7: data7.value,
      data8: data8.value,
      data9: data9.value,
      data10: data10.value,
      data11: data11.value,
      data12: data12.value,
      data13: data13.value,
      data14: data14.value,
      data15: data15.value,
      data16: data16.value,
      data17: data17.value,
      data18: data18.value,
      data19: data19.value,
      data20: data20.value,
      data21: data21.value,
      data22: data22.value,
      data23: data23.value,
      aiName: aiNameController.text,
      scriptName: scriptNameController.text,
      verifiedBuild: verifiedBuild.value,
    );
  }

  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  void dispose() {
    nameController.dispose();
    castBarCaptionController.dispose();
    iconNameController.dispose();
    unk1Controller.dispose();
    aiNameController.dispose();
    scriptNameController.dispose();
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
    entry.value = template.entry;
    nameController.text = template.name;
    castBarCaptionController.text = template.castBarCaption;
    iconNameController.text = template.iconName;
    displayId.value = template.displayId;
    size.value = template.size;
    unk1Controller.text = template.unk1;
    data0.value = template.data0;
    data1.value = template.data1;
    data2.value = template.data2;
    data3.value = template.data3;
    data4.value = template.data4;
    data5.value = template.data5;
    data6.value = template.data6;
    data7.value = template.data7;
    data8.value = template.data8;
    data9.value = template.data9;
    data10.value = template.data10;
    data11.value = template.data11;
    data12.value = template.data12;
    data13.value = template.data13;
    data14.value = template.data14;
    data15.value = template.data15;
    data16.value = template.data16;
    data17.value = template.data17;
    data18.value = template.data18;
    data19.value = template.data19;
    data20.value = template.data20;
    data21.value = template.data21;
    data22.value = template.data22;
    data23.value = template.data23;
    aiNameController.text = template.aiName;
    scriptNameController.text = template.scriptName;
    verifiedBuild.value = template.verifiedBuild;
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
