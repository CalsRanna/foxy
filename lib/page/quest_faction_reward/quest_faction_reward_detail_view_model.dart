import 'package:flutter/widgets.dart';
import 'package:foxy/model/quest_faction_reward.dart';
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

  final table = signal(QuestFactionReward());

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = QuestFactionRewardRepository();
      if (t.id == 0) {
        await repository.store(t);
      } else {
        await repository.update(t);
      }
      table.value = t;
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
  QuestFactionReward _collectFromControllers() {
    final t = QuestFactionReward();

    /// Basic
    t.id = _parseInt(idController.text);

    /// Difficulty
    t.difficulty0 = _parseInt(difficulty0Controller.text);
    t.difficulty1 = _parseInt(difficulty1Controller.text);
    t.difficulty2 = _parseInt(difficulty2Controller.text);
    t.difficulty3 = _parseInt(difficulty3Controller.text);
    t.difficulty4 = _parseInt(difficulty4Controller.text);
    t.difficulty5 = _parseInt(difficulty5Controller.text);
    t.difficulty6 = _parseInt(difficulty6Controller.text);
    t.difficulty7 = _parseInt(difficulty7Controller.text);
    t.difficulty8 = _parseInt(difficulty8Controller.text);
    t.difficulty9 = _parseInt(difficulty9Controller.text);

    return t;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

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
      table.value = (await QuestFactionRewardRepository().find(id))!;
      _initControllers(table.value);
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
