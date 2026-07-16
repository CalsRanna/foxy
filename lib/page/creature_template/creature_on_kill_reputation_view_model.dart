import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_on_kill_reputation_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureOnKillReputationViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<CreatureOnKillReputationRepository>();
  late final creatureIdController = registerController(IntFieldController());
  final routerFacade = GetIt.instance.get<RouterFacade>();

  late final rewOnKillRepFaction1Controller = registerController(
    IntFieldController(),
  );
  late final rewOnKillRepFaction2Controller = registerController(
    IntFieldController(),
  );
  late final maxStanding1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final maxStanding2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final isTeamAward1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final isTeamAward2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final rewOnKillRepValue1Controller = registerController(
    DoubleFieldController(),
  );
  late final rewOnKillRepValue2Controller = registerController(
    DoubleFieldController(),
  );
  late final teamDependentController = registerController(
    SelectFieldController<int>(fallback: 0),
  );

  final reputation = signal(CreatureOnKillReputationEntity());

  /// 清理资源
  void dispose() {
    disposeControllers();
  }

  /// 初始化 Controller 的值
  void initControllers(CreatureOnKillReputationEntity data) {
    rewOnKillRepFaction1Controller.init(data.rewOnKillRepFaction1);
    rewOnKillRepFaction2Controller.init(data.rewOnKillRepFaction2);
    maxStanding1Controller.init(data.maxStanding1);
    maxStanding2Controller.init(data.maxStanding2);
    isTeamAward1Controller.init(data.isTeamAward1 ? 1 : 0);
    isTeamAward2Controller.init(data.isTeamAward2 ? 1 : 0);
    rewOnKillRepValue1Controller.init(data.rewOnKillRepValue1);
    rewOnKillRepValue2Controller.init(data.rewOnKillRepValue2);
    teamDependentController.init(data.teamDependent);
  }

  /// 初始化 ViewModel
  Future<void> initSignals({required int creatureId}) async {
    try {
      creatureIdController.init(creatureId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化击杀声望失败: $e');
      DialogUtil.instance.error('初始化击杀声望失败: $e');
    }
  }

  /// 从数据库加载数据

  Future<void> load() async {
    final data = await _repository.getCreatureOnKillReputation(
      creatureIdController.collect(),
    );
    if (data != null) {
      reputation.value = data;
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 保存数据到数据库
  Future<void> save(BuildContext context) async {
    try {
      final repData = _collectFromControllers();
      await _repository.saveCreatureOnKillReputation(repData);
      reputation.value = repData;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('击杀声望数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 从 Controller 收集数据构建 CreatureOnKillReputation
  CreatureOnKillReputationEntity _collectFromControllers() {
    return CreatureOnKillReputationEntity(
      creatureID: creatureIdController.collect(),
      rewOnKillRepFaction1: rewOnKillRepFaction1Controller.collect(),
      rewOnKillRepFaction2: rewOnKillRepFaction2Controller.collect(),
      maxStanding1: maxStanding1Controller.collect(),
      maxStanding2: maxStanding2Controller.collect(),
      isTeamAward1: isTeamAward1Controller.collect() == 1,
      isTeamAward2: isTeamAward2Controller.collect() == 1,
      rewOnKillRepValue1: rewOnKillRepValue1Controller.collect(),
      rewOnKillRepValue2: rewOnKillRepValue2Controller.collect(),
      teamDependent: teamDependentController.collect(),
    );
  }
}
