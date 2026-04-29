import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/entity/quest_faction_reward_filter_entity.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestFactionRewardListViewModel {
  final entryController = TextEditingController();
  final repository = QuestFactionRewardRepository();

  final page = signal(1);
  final rewards = signal(<QuestFactionRewardEntity>[]);
  final total = signal(0);

  Future<void> copyQuestFactionReward(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的任务声望？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyQuestFactionReward(id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteQuestFactionReward(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的任务声望？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyQuestFactionReward(id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryController.dispose();
  }

  Future<void> initSignals() async {
    final filter = QuestFactionRewardFilterEntity();
    rewards.value = await repository.getQuestFactionRewards(
      page: 1,
      filter: filter,
    );
    total.value = await repository.countQuestFactionRewards(filter: filter);
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
    return QuestFactionRewardFilterEntity(id: entryController.text);
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    page.value = 1;
    final filter = QuestFactionRewardFilterEntity();
    rewards.value = await repository.getQuestFactionRewards(
      page: 1,
      filter: filter,
    );
    total.value = await repository.countQuestFactionRewards(filter: filter);
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    rewards.value = await repository.getQuestFactionRewards(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.countQuestFactionRewards(filter: filter);
  }
}
