import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestFactionRewardDetailViewModel {
  final _repository = GetIt.instance.get<QuestFactionRewardRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = IntFieldController();

  /// Difficulty
  final difficulty0Controller = IntFieldController();
  final difficulty1Controller = IntFieldController();
  final difficulty2Controller = IntFieldController();
  final difficulty3Controller = IntFieldController();
  final difficulty4Controller = IntFieldController();
  final difficulty5Controller = IntFieldController();
  final difficulty6Controller = IntFieldController();
  final difficulty7Controller = IntFieldController();
  final difficulty8Controller = IntFieldController();
  final difficulty9Controller = IntFieldController();

  late final _controllers = <FieldController>[
    idController,
    difficulty0Controller,
    difficulty1Controller,
    difficulty2Controller,
    difficulty3Controller,
    difficulty4Controller,
    difficulty5Controller,
    difficulty6Controller,
    difficulty7Controller,
    difficulty8Controller,
    difficulty9Controller,
  ];

  final reward = signal(QuestFactionRewardEntity());

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final existed = await _repository.getQuestFactionReward(t.id);
      if (existed == null) {
        final id = await _repository.storeQuestFactionReward(t);
        idController.init(id);
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
      id: idController.collect(),
      difficulty0: difficulty0Controller.collect(),
      difficulty1: difficulty1Controller.collect(),
      difficulty2: difficulty2Controller.collect(),
      difficulty3: difficulty3Controller.collect(),
      difficulty4: difficulty4Controller.collect(),
      difficulty5: difficulty5Controller.collect(),
      difficulty6: difficulty6Controller.collect(),
      difficulty7: difficulty7Controller.collect(),
      difficulty8: difficulty8Controller.collect(),
      difficulty9: difficulty9Controller.collect(),
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createQuestFactionReward();
        reward.value = blank;
        _initControllers(blank);
        return;
      }
      reward.value = (await _repository.getQuestFactionReward(id))!;
      _initControllers(reward.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载任务声望(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestFactionRewardEntity table) {
    idController.init(table.id);
    difficulty0Controller.init(table.difficulty0);
    difficulty1Controller.init(table.difficulty1);
    difficulty2Controller.init(table.difficulty2);
    difficulty3Controller.init(table.difficulty3);
    difficulty4Controller.init(table.difficulty4);
    difficulty5Controller.init(table.difficulty5);
    difficulty6Controller.init(table.difficulty6);
    difficulty7Controller.init(table.difficulty7);
    difficulty8Controller.init(table.difficulty8);
    difficulty9Controller.init(table.difficulty9);
  }
}
