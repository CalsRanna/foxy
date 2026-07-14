import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/entity/quest_faction_reward_filter_entity.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
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

  void navigateToDetail({int? id}) {
    final label = id != null ? '#$id' : '新建任务声望';
    final routeId = id != null
        ? 'quest_faction_reward_$id'
        : 'quest_faction_reward_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: QuestFactionRewardDetailRoute(id: id),
      parentMenu: RouterMenu.questFactionReward,
    );
  }

  QuestFactionRewardFilterEntity _buildFilter() {
    return QuestFactionRewardFilterEntity(id: entryController.collect());
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
