import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestFactionRewardDetailViewModel {
  final _repository = GetIt.instance.get<QuestFactionRewardRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();

  /// Difficulty
  final difficulty0Controller = TextEditingController();
  final difficulty1Controller = TextEditingController();
  final difficulty2Controller = TextEditingController();
  final difficulty3Controller = TextEditingController();
  final difficulty4Controller = TextEditingController();
  final difficulty5Controller = TextEditingController();
  final difficulty6Controller = TextEditingController();
  final difficulty7Controller = TextEditingController();
  final difficulty8Controller = TextEditingController();
  final difficulty9Controller = TextEditingController();

  final reward = signal(QuestFactionRewardEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        final id = await _repository.storeQuestFactionReward(t);
        idController.text = '$id';
      } else {
        await _repository.updateQuestFactionReward(t);
      }
      reward.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('任务声望数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 QuestFactionReward
  QuestFactionRewardEntity _collectFromControllers() {
    return QuestFactionRewardEntity(
      id: _pi(idController.text),
      difficulty0: _pi(difficulty0Controller.text),
      difficulty1: _pi(difficulty1Controller.text),
      difficulty2: _pi(difficulty2Controller.text),
      difficulty3: _pi(difficulty3Controller.text),
      difficulty4: _pi(difficulty4Controller.text),
      difficulty5: _pi(difficulty5Controller.text),
      difficulty6: _pi(difficulty6Controller.text),
      difficulty7: _pi(difficulty7Controller.text),
      difficulty8: _pi(difficulty8Controller.text),
      difficulty9: _pi(difficulty9Controller.text),
    );
  }

  void _logActivity(ActivityActionType action, QuestFactionRewardEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_faction_reward',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    difficulty0Controller.dispose();
    difficulty1Controller.dispose();
    difficulty2Controller.dispose();
    difficulty3Controller.dispose();
    difficulty4Controller.dispose();
    difficulty5Controller.dispose();
    difficulty6Controller.dispose();
    difficulty7Controller.dispose();
    difficulty8Controller.dispose();
    difficulty9Controller.dispose();
    idController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      reward.value = (await _repository.getQuestFactionReward(id))!;
      _initControllers(reward.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载任务声望(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestFactionRewardEntity table) {
    /// Basic
    idController.text = _fmt(table.id);

    /// Difficulty
    difficulty0Controller.text = _fmt(table.difficulty0);
    difficulty1Controller.text = _fmt(table.difficulty1);
    difficulty2Controller.text = _fmt(table.difficulty2);
    difficulty3Controller.text = _fmt(table.difficulty3);
    difficulty4Controller.text = _fmt(table.difficulty4);
    difficulty5Controller.text = _fmt(table.difficulty5);
    difficulty6Controller.text = _fmt(table.difficulty6);
    difficulty7Controller.text = _fmt(table.difficulty7);
    difficulty8Controller.text = _fmt(table.difficulty8);
    difficulty9Controller.text = _fmt(table.difficulty9);
  }
}
