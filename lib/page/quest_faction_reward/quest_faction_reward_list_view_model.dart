import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_quest_faction_reward_entity.dart';
import 'package:foxy/entity/quest_faction_reward_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestFactionRewardListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<QuestFactionRewardRepository>();

  final page = signal(1);
  final rewards = signal(<BriefQuestFactionRewardEntity>[]);
  final total = signal(0);

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals() async {
    final token = ++_refreshToken;
    try {
      final filter = QuestFactionRewardFilterEntity();
      final (items, count) = await (
        _repository.getBriefQuestFactionRewards(page: 1, filter: filter),
        _repository.countQuestFactionRewards(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      rewards.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载任务阵营奖励列表失败: $e');
      DialogUtil.instance.error('加载任务阵营奖励列表失败: $e');
    }
  }

  Future<void> deleteQuestFactionReward(int key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $key 的任务声望？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyQuestFactionReward(key);
      _logActivity(ActivityActionType.delete, key);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void navigateToDetail({int? key}) {
    final label = key != null ? '#$key' : '新建任务声望';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      label: label,
      route: QuestFactionRewardDetailRoute(questFactionRewardKey: key),
      parentMenu: RouterMenu.questFactionReward,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  QuestFactionRewardFilterEntity _buildFilter() {
    return QuestFactionRewardFilterEntity(id: entryController.collect());
  }

  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'quest_faction_reward',
      actionType: action,
      entityName: 'QuestFactionReward $key',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefQuestFactionRewards(
          page: page.value,
          filter: filter,
        ),
        _repository.countQuestFactionRewards(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      rewards.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新任务阵营奖励列表失败: $e');
      DialogUtil.instance.error('刷新任务阵营奖励列表失败: $e');
    }
  }
}
