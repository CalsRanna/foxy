import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_onkill_reputation_entity.dart';
import 'package:foxy/repository/creature_on_kill_reputation_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureOnKillReputationViewModel {
  final creatureId = signal(0);
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final rewOnKillRepFaction1 = signal<int>(0);
  final rewOnKillRepFaction2 = signal<int>(0);
  final maxStanding1Controller = ShadSelectController<int>();
  final maxStanding2Controller = ShadSelectController<int>();
  final isTeamAward1Controller = ShadSelectController<int>();
  final isTeamAward2Controller = ShadSelectController<int>();
  final rewOnKillRepValue1 = signal<double>(0.0);
  final rewOnKillRepValue2 = signal<double>(0.0);
  final teamDependent = signal<int>(0);

  final reputation = signal(CreatureOnKillReputationEntity());

  /// 从数据库加载数据
  Future<void> load() async {
    final repository = CreatureOnKillReputationRepository();
    final data = await repository.getCreatureOnKillReputation(
      creatureId.value,
    );
    if (data != null) {
      reputation.value = data;
    }
  }

  /// 保存数据到数据库
  Future<void> save(BuildContext context) async {
    try {
      final repData = _collectFromControllers();
      final repository = CreatureOnKillReputationRepository();
      await repository.saveCreatureOnKillReputation(repData);
      reputation.value = repData;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('击杀声望数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从 Controller 收集数据构建 CreatureOnKillReputation
  CreatureOnKillReputationEntity _collectFromControllers() {
    return CreatureOnKillReputationEntity(
      creatureID: creatureId.value,
      rewOnKillRepFaction1: rewOnKillRepFaction1.value,
      rewOnKillRepFaction2: rewOnKillRepFaction2.value,
      maxStanding1: _getControllerValue(maxStanding1Controller),
      maxStanding2: _getControllerValue(maxStanding2Controller),
      isTeamAward1: _getControllerValue(isTeamAward1Controller) == 1,
      isTeamAward2: _getControllerValue(isTeamAward2Controller) == 1,
      rewOnKillRepValue1: rewOnKillRepValue1.value,
      rewOnKillRepValue2: rewOnKillRepValue2.value,
      teamDependent: teamDependent.value,
    );
  }

  int _getControllerValue(ShadSelectController<int> controller) {
    final value = controller.value;
    if (value.isNotEmpty) {
      return value.first;
    }
    return 0;
  }

  /// 初始化 Controller 的值
  void initControllers(CreatureOnKillReputationEntity data) {
    rewOnKillRepFaction1.value = data.rewOnKillRepFaction1;
    rewOnKillRepFaction2.value = data.rewOnKillRepFaction2;
    maxStanding1Controller.value = {data.maxStanding1};
    maxStanding2Controller.value = {data.maxStanding2};
    isTeamAward1Controller.value = {data.isTeamAward1 ? 1 : 0};
    isTeamAward2Controller.value = {data.isTeamAward2 ? 1 : 0};
    rewOnKillRepValue1.value = data.rewOnKillRepValue1;
    rewOnKillRepValue2.value = data.rewOnKillRepValue2;
    teamDependent.value = data.teamDependent;
  }

  /// 初始化 ViewModel
  Future<void> initSignals({required int creatureId}) async {
    try {
      this.creatureId.value = creatureId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化击杀声望失败: $e');
      DialogUtil.instance.error('初始化击杀声望失败: $e');
    }
  }

  /// 清理资源
  void dispose() {
    maxStanding1Controller.dispose();
    maxStanding2Controller.dispose();
    isTeamAward1Controller.dispose();
    isTeamAward2Controller.dispose();
  }
}
