import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectTemplateDetailViewModel {
  final _repository = GetIt.instance.get<GameObjectTemplateRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final nameController = StringFieldController();
  final castBarCaptionController = StringFieldController();
  final iconNameController = StringFieldController();
  final typeController = SelectFieldController<int>(fallback: 0);
  final unk1Controller = StringFieldController();
  final aiNameController = StringFieldController();
  final scriptNameController = StringFieldController();

  final entryController = IntFieldController();
  final displayIdController = IntFieldController();
  final sizeController = DoubleFieldController();
  final dataControllers = List.generate(24, (_) => IntFieldController());
  final verifiedBuildController = IntFieldController();

  late final _controllers = <FieldController>[
    nameController,
    castBarCaptionController,
    iconNameController,
    typeController,
    unk1Controller,
    aiNameController,
    scriptNameController,
    entryController,
    displayIdController,
    sizeController,
    ...dataControllers,
    verifiedBuildController,
  ];

  final template = signal(GameObjectTemplateEntity());

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
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
      entry: entryController.collect(),
      name: nameController.collect(),
      castBarCaption: castBarCaptionController.collect(),
      iconName: iconNameController.collect(),
      type: typeController.collect(),
      displayId: displayIdController.collect(),
      size: sizeController.collect(),
      unk1: unk1Controller.collect(),
      data0: dataControllers[0].collect(),
      data1: dataControllers[1].collect(),
      data2: dataControllers[2].collect(),
      data3: dataControllers[3].collect(),
      data4: dataControllers[4].collect(),
      data5: dataControllers[5].collect(),
      data6: dataControllers[6].collect(),
      data7: dataControllers[7].collect(),
      data8: dataControllers[8].collect(),
      data9: dataControllers[9].collect(),
      data10: dataControllers[10].collect(),
      data11: dataControllers[11].collect(),
      data12: dataControllers[12].collect(),
      data13: dataControllers[13].collect(),
      data14: dataControllers[14].collect(),
      data15: dataControllers[15].collect(),
      data16: dataControllers[16].collect(),
      data17: dataControllers[17].collect(),
      data18: dataControllers[18].collect(),
      data19: dataControllers[19].collect(),
      data20: dataControllers[20].collect(),
      data21: dataControllers[21].collect(),
      data22: dataControllers[22].collect(),
      data23: dataControllers[23].collect(),
      aiName: aiNameController.collect(),
      scriptName: scriptNameController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
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

  void _initControllers(GameObjectTemplateEntity template) {
    entryController.init(template.entry);
    nameController.init(template.name);
    castBarCaptionController.init(template.castBarCaption);
    iconNameController.init(template.iconName);
    typeController.init(template.type);
    displayIdController.init(template.displayId);
    sizeController.init(template.size);
    unk1Controller.init(template.unk1);
    dataControllers[0].init(template.data0);
    dataControllers[1].init(template.data1);
    dataControllers[2].init(template.data2);
    dataControllers[3].init(template.data3);
    dataControllers[4].init(template.data4);
    dataControllers[5].init(template.data5);
    dataControllers[6].init(template.data6);
    dataControllers[7].init(template.data7);
    dataControllers[8].init(template.data8);
    dataControllers[9].init(template.data9);
    dataControllers[10].init(template.data10);
    dataControllers[11].init(template.data11);
    dataControllers[12].init(template.data12);
    dataControllers[13].init(template.data13);
    dataControllers[14].init(template.data14);
    dataControllers[15].init(template.data15);
    dataControllers[16].init(template.data16);
    dataControllers[17].init(template.data17);
    dataControllers[18].init(template.data18);
    dataControllers[19].init(template.data19);
    dataControllers[20].init(template.data20);
    dataControllers[21].init(template.data21);
    dataControllers[22].init(template.data22);
    dataControllers[23].init(template.data23);
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
