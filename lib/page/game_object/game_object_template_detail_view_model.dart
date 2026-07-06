import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
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
  final _repository = GetIt.instance.get<GameObjectTemplateRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final nameController = TextEditingController();
  final castBarCaptionController = TextEditingController();
  final iconNameController = TextEditingController();
  final typeController = ShadSelectController<int>();
  final unk1Controller = TextEditingController();
  final aiNameController = TextEditingController();
  final scriptNameController = TextEditingController();

  final entryController = TextEditingController();
  final displayIdController = TextEditingController();
  final sizeController = TextEditingController();
  final dataControllers = List.generate(24, (_) => TextEditingController());
  final verifiedBuildController = TextEditingController();

  final template = signal(GameObjectTemplateEntity());

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;
  double _pd(String t) => double.tryParse(t) ?? 0.0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final isNew = t.entry == 0;
      if (isNew) {
        await _repository.storeGameObjectTemplate(t);
      } else {
        await _repository.updateGameObjectTemplate(t);
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
      entry: _pi(entryController.text),
      name: nameController.text,
      castBarCaption: castBarCaptionController.text,
      iconName: iconNameController.text,
      type: _getSelectValue(typeController),
      displayId: _pi(displayIdController.text),
      size: _pd(sizeController.text),
      unk1: unk1Controller.text,
      data0: _pi(dataControllers[0].text),
      data1: _pi(dataControllers[1].text),
      data2: _pi(dataControllers[2].text),
      data3: _pi(dataControllers[3].text),
      data4: _pi(dataControllers[4].text),
      data5: _pi(dataControllers[5].text),
      data6: _pi(dataControllers[6].text),
      data7: _pi(dataControllers[7].text),
      data8: _pi(dataControllers[8].text),
      data9: _pi(dataControllers[9].text),
      data10: _pi(dataControllers[10].text),
      data11: _pi(dataControllers[11].text),
      data12: _pi(dataControllers[12].text),
      data13: _pi(dataControllers[13].text),
      data14: _pi(dataControllers[14].text),
      data15: _pi(dataControllers[15].text),
      data16: _pi(dataControllers[16].text),
      data17: _pi(dataControllers[17].text),
      data18: _pi(dataControllers[18].text),
      data19: _pi(dataControllers[19].text),
      data20: _pi(dataControllers[20].text),
      data21: _pi(dataControllers[21].text),
      data22: _pi(dataControllers[22].text),
      data23: _pi(dataControllers[23].text),
      aiName: aiNameController.text,
      scriptName: scriptNameController.text,
      verifiedBuild: _pi(verifiedBuildController.text),
    );
  }

  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  void dispose() {
    aiNameController.dispose();
    castBarCaptionController.dispose();
    displayIdController.dispose();
    entryController.dispose();
    iconNameController.dispose();
    nameController.dispose();
    scriptNameController.dispose();
    sizeController.dispose();
    unk1Controller.dispose();
    verifiedBuildController.dispose();
    for (final c in dataControllers) {
      c.dispose();
    }
  }

  Future<void> initSignals({int? entry}) async {
    if (entry == null) return;
    try {
      template.value = await _repository.getGameObjectTemplate(entry);
      _initControllers(template.value);
    } catch (e) {
      LoggerUtil.instance.e('加载游戏对象详情失败: $e');
      DialogUtil.instance.error('加载游戏对象详情失败: $e');
    }
  }

  void _initControllers(GameObjectTemplateEntity template) {
    entryController.text = _fmt(template.entry);
    nameController.text = template.name;
    castBarCaptionController.text = template.castBarCaption;
    iconNameController.text = template.iconName;
    displayIdController.text = _fmt(template.displayId);
    sizeController.text = _fmt(template.size);
    unk1Controller.text = template.unk1;
    dataControllers[0].text = _fmt(template.data0);
    dataControllers[1].text = _fmt(template.data1);
    dataControllers[2].text = _fmt(template.data2);
    dataControllers[3].text = _fmt(template.data3);
    dataControllers[4].text = _fmt(template.data4);
    dataControllers[5].text = _fmt(template.data5);
    dataControllers[6].text = _fmt(template.data6);
    dataControllers[7].text = _fmt(template.data7);
    dataControllers[8].text = _fmt(template.data8);
    dataControllers[9].text = _fmt(template.data9);
    dataControllers[10].text = _fmt(template.data10);
    dataControllers[11].text = _fmt(template.data11);
    dataControllers[12].text = _fmt(template.data12);
    dataControllers[13].text = _fmt(template.data13);
    dataControllers[14].text = _fmt(template.data14);
    dataControllers[15].text = _fmt(template.data15);
    dataControllers[16].text = _fmt(template.data16);
    dataControllers[17].text = _fmt(template.data17);
    dataControllers[18].text = _fmt(template.data18);
    dataControllers[19].text = _fmt(template.data19);
    dataControllers[20].text = _fmt(template.data20);
    dataControllers[21].text = _fmt(template.data21);
    dataControllers[22].text = _fmt(template.data22);
    dataControllers[23].text = _fmt(template.data23);
    aiNameController.text = template.aiName;
    scriptNameController.text = template.scriptName;
    verifiedBuildController.text = _fmt(template.verifiedBuild);
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
