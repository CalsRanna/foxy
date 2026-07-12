import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:foxy/repository/creature_on_kill_reputation_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureOnKillReputationViewModel {
  final _repository = GetIt.instance.get<CreatureOnKillReputationRepository>();
  final creatureIdController = TextEditingController();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final rewOnKillRepFaction1Controller = TextEditingController();
  final rewOnKillRepFaction2Controller = TextEditingController();
  final maxStanding1Controller = ShadSelectController<int>();
  final maxStanding2Controller = ShadSelectController<int>();
  final isTeamAward1Controller = ShadSelectController<int>();
  final isTeamAward2Controller = ShadSelectController<int>();
  final rewOnKillRepValue1Controller = TextEditingController();
  final rewOnKillRepValue2Controller = TextEditingController();
  final teamDependentController = TextEditingController();

  final reputation = signal(CreatureOnKillReputationEntity());

  /// 从数据库加载数据
  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);
  double _pd(String t, [String field = '']) =>
      parseDoubleField(t, field: field);

  Future<void> load() async {
    final data = await _repository.getCreatureOnKillReputation(
      _pi(creatureIdController.text),
    );
    if (data != null) {
      reputation.value = data;
    }
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

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从 Controller 收集数据构建 CreatureOnKillReputation
  CreatureOnKillReputationEntity _collectFromControllers() {
    return CreatureOnKillReputationEntity(
      creatureID: _pi(creatureIdController.text),
      rewOnKillRepFaction1: _pi(rewOnKillRepFaction1Controller.text),
      rewOnKillRepFaction2: _pi(rewOnKillRepFaction2Controller.text),
      maxStanding1: _getControllerValue(maxStanding1Controller),
      maxStanding2: _getControllerValue(maxStanding2Controller),
      isTeamAward1: _getControllerValue(isTeamAward1Controller) == 1,
      isTeamAward2: _getControllerValue(isTeamAward2Controller) == 1,
      rewOnKillRepValue1: _pd(rewOnKillRepValue1Controller.text),
      rewOnKillRepValue2: _pd(rewOnKillRepValue2Controller.text),
      teamDependent: _pi(teamDependentController.text),
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
    rewOnKillRepFaction1Controller.text = _fmt(data.rewOnKillRepFaction1);
    rewOnKillRepFaction2Controller.text = _fmt(data.rewOnKillRepFaction2);
    maxStanding1Controller.value = {data.maxStanding1};
    maxStanding2Controller.value = {data.maxStanding2};
    isTeamAward1Controller.value = {data.isTeamAward1 ? 1 : 0};
    isTeamAward2Controller.value = {data.isTeamAward2 ? 1 : 0};
    rewOnKillRepValue1Controller.text = _fmt(data.rewOnKillRepValue1);
    rewOnKillRepValue2Controller.text = _fmt(data.rewOnKillRepValue2);
    teamDependentController.text = _fmt(data.teamDependent);
  }

  /// 初始化 ViewModel
  Future<void> initSignals({required int creatureId}) async {
    try {
      creatureIdController.text = _fmt(creatureId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化击杀声望失败: $e');
      DialogUtil.instance.error('初始化击杀声望失败: $e');
    }
  }

  /// 清理资源
  void dispose() {
    creatureIdController.dispose();
    isTeamAward1Controller.dispose();
    isTeamAward2Controller.dispose();
    maxStanding1Controller.dispose();
    maxStanding2Controller.dispose();
    rewOnKillRepFaction1Controller.dispose();
    rewOnKillRepFaction2Controller.dispose();
    rewOnKillRepValue1Controller.dispose();
    rewOnKillRepValue2Controller.dispose();
    teamDependentController.dispose();
  }
}
