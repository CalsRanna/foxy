import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log.dart';
import 'package:foxy/entity/quest_faction_reward.dart';
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

  final reward = signal(QuestFactionReward());
  final saving = signal(false);

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    saving.value = true;
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
    } finally {
      saving.value = false;
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 QuestFactionReward
  QuestFactionReward _collectFromControllers() {
    return QuestFactionReward(
      id: _parseInt(idController.text),
      difficulty0: _parseInt(difficulty0Controller.text),
      difficulty1: _parseInt(difficulty1Controller.text),
      difficulty2: _parseInt(difficulty2Controller.text),
      difficulty3: _parseInt(difficulty3Controller.text),
      difficulty4: _parseInt(difficulty4Controller.text),
      difficulty5: _parseInt(difficulty5Controller.text),
      difficulty6: _parseInt(difficulty6Controller.text),
      difficulty7: _parseInt(difficulty7Controller.text),
      difficulty8: _parseInt(difficulty8Controller.text),
      difficulty9: _parseInt(difficulty9Controller.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, QuestFactionReward t) {
    final log = ActivityLog(
      module: 'quest_faction_reward',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    /// Basic
    idController.dispose();

    /// Difficulty
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
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      reward.value = (await QuestFactionRewardRepository()
          .getQuestFactionReward(id))!;
      _initControllers(reward.value);
    } catch (e, s) {
      logger.e('加载任务声望(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestFactionReward table) {
    /// Basic
    idController.text = table.id.toString();

    /// Difficulty
    difficulty0Controller.text = table.difficulty0.toString();
    difficulty1Controller.text = table.difficulty1.toString();
    difficulty2Controller.text = table.difficulty2.toString();
    difficulty3Controller.text = table.difficulty3.toString();
    difficulty4Controller.text = table.difficulty4.toString();
    difficulty5Controller.text = table.difficulty5.toString();
    difficulty6Controller.text = table.difficulty6.toString();
    difficulty7Controller.text = table.difficulty7.toString();
    difficulty8Controller.text = table.difficulty8.toString();
    difficulty9Controller.text = table.difficulty9.toString();
  }
}
