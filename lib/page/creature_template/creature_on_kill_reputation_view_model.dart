import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/model/creature_onkill_reputation.dart';
import 'package:foxy/repository/creature_on_kill_reputation_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureOnKillReputationViewModel {
  final creatureId = signal(0);
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureIdController = TextEditingController();
  final rewOnKillRepFaction1Controller = TextEditingController();
  final rewOnKillRepFaction2Controller = TextEditingController();
  final maxStanding1Controller = ShadSelectController<int>();
  final maxStanding2Controller = ShadSelectController<int>();
  final isTeamAward1Controller = ShadSelectController<int>();
  final isTeamAward2Controller = ShadSelectController<int>();
  final rewOnKillRepValue1Controller = TextEditingController();
  final rewOnKillRepValue2Controller = TextEditingController();
  final teamDependentController = TextEditingController();

  final loading = signal(false);
  final saving = signal(false);
  final reputation = signal(CreatureOnKillReputation());

  /// 从数据库加载数据
  Future<void> load() async {
    loading.value = true;
    try {
      final repository = CreatureOnKillReputationRepository();
      final data = await repository.find(creatureId.value);
      if (data != null) {
        reputation.value = data;
      }
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  /// 保存数据到数据库
  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final repData = _collectFromControllers();
      final repository = CreatureOnKillReputationRepository();
      await repository.save(repData);
      reputation.value = repData;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('击杀声望数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从 Controller 收集数据构建 CreatureOnKillReputation
  CreatureOnKillReputation _collectFromControllers() {
    final data = CreatureOnKillReputation();
    data.creatureID = creatureId.value;
    data.rewOnKillRepFaction1 = _parseInt(rewOnKillRepFaction1Controller.text);
    data.rewOnKillRepFaction2 = _parseInt(rewOnKillRepFaction2Controller.text);
    data.maxStanding1 = _getControllerValue(maxStanding1Controller);
    data.maxStanding2 = _getControllerValue(maxStanding2Controller);
    data.isTeamAward1 = _getControllerValue(isTeamAward1Controller) == 1;
    data.isTeamAward2 = _getControllerValue(isTeamAward2Controller) == 1;
    data.rewOnKillRepValue1 = _parseDouble(rewOnKillRepValue1Controller.text);
    data.rewOnKillRepValue2 = _parseDouble(rewOnKillRepValue2Controller.text);
    data.teamDependent = _parseInt(teamDependentController.text);
    return data;
  }

  int _getControllerValue(ShadSelectController<int> controller) {
    final value = controller.value;
    if (value.isNotEmpty) {
      return value.first;
    }
    return 0;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);
  double _parseDouble(String text) => text.isEmpty ? 0.0 : double.parse(text);

  /// 初始化 Controller 的值
  void initControllers(CreatureOnKillReputation data) {
    creatureIdController.text = data.creatureID.toString();
    rewOnKillRepFaction1Controller.text = data.rewOnKillRepFaction1.toString();
    rewOnKillRepFaction2Controller.text = data.rewOnKillRepFaction2.toString();
    maxStanding1Controller.value = {data.maxStanding1};
    maxStanding2Controller.value = {data.maxStanding2};
    isTeamAward1Controller.value = {data.isTeamAward1 ? 1 : 0};
    isTeamAward2Controller.value = {data.isTeamAward2 ? 1 : 0};
    rewOnKillRepValue1Controller.text = data.rewOnKillRepValue1.toString();
    rewOnKillRepValue2Controller.text = data.rewOnKillRepValue2.toString();
    teamDependentController.text = data.teamDependent.toString();
  }

  /// 初始化 ViewModel
  Future<void> initSignals({required int creatureId}) async {
    this.creatureId.value = creatureId;
    creatureIdController.text = creatureId.toString();
    await load();
  }

  /// 清理资源
  void dispose() {
    creatureIdController.dispose();
    rewOnKillRepFaction1Controller.dispose();
    rewOnKillRepFaction2Controller.dispose();
    maxStanding1Controller.dispose();
    maxStanding2Controller.dispose();
    isTeamAward1Controller.dispose();
    isTeamAward2Controller.dispose();
    rewOnKillRepValue1Controller.dispose();
    rewOnKillRepValue2Controller.dispose();
    teamDependentController.dispose();
  }
}
