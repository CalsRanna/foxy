import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestFactionRewardDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final id = signal<int>(0);

  /// Difficulty
  final difficulty0 = signal<int>(0);
  final difficulty1 = signal<int>(0);
  final difficulty2 = signal<int>(0);
  final difficulty3 = signal<int>(0);
  final difficulty4 = signal<int>(0);
  final difficulty5 = signal<int>(0);
  final difficulty6 = signal<int>(0);
  final difficulty7 = signal<int>(0);
  final difficulty8 = signal<int>(0);
  final difficulty9 = signal<int>(0);

  final reward = signal(QuestFactionRewardEntity());
  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = QuestFactionRewardRepository();
      if (t.id == 0) {
        await repository.storeQuestFactionReward(t);
      } else {
        await repository.updateQuestFactionReward(t);
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
      id: id.value,
      difficulty0: difficulty0.value,
      difficulty1: difficulty1.value,
      difficulty2: difficulty2.value,
      difficulty3: difficulty3.value,
      difficulty4: difficulty4.value,
      difficulty5: difficulty5.value,
      difficulty6: difficulty6.value,
      difficulty7: difficulty7.value,
      difficulty8: difficulty8.value,
      difficulty9: difficulty9.value,
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

  void dispose() {}

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      reward.value = (await QuestFactionRewardRepository()
          .getQuestFactionReward(id))!;
      _initControllers(reward.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载任务声望(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestFactionRewardEntity table) {
    /// Basic
    id.value = table.id;

    /// Difficulty
    difficulty0.value = table.difficulty0;
    difficulty1.value = table.difficulty1;
    difficulty2.value = table.difficulty2;
    difficulty3.value = table.difficulty3;
    difficulty4.value = table.difficulty4;
    difficulty5.value = table.difficulty5;
    difficulty6.value = table.difficulty6;
    difficulty7.value = table.difficulty7;
    difficulty8.value = table.difficulty8;
    difficulty9.value = table.difficulty9;
  }
}
