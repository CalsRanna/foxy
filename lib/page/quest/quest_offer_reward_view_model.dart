import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/repository/quest_offer_reward_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestOfferRewardViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);

  final id = signal<int>(0);
  final emote1 = signal<int>(0);
  final emote2 = signal<int>(0);
  final emote3 = signal<int>(0);
  final emote4 = signal<int>(0);
  final emoteDelay1 = signal<int>(0);
  final emoteDelay2 = signal<int>(0);
  final emoteDelay3 = signal<int>(0);
  final emoteDelay4 = signal<int>(0);
  final rewardTextController = TextEditingController();

  int _originalId = 0;

  Future<void> initSignals({required int questId}) async {
    try {
      this.questId.value = questId;
      final repository = QuestOfferRewardRepository();
      final existing = await repository.getQuestOfferReward(questId);
      if (existing != null) {
        _originalId = existing.id;
        _applyToSignals(existing);
      } else {
        final blank = await repository.createQuestOfferReward(questId);
        _applyToSignals(blank);
      }
      id.value = questId;
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collect();
      final repository = QuestOfferRewardRepository();
      if (_originalId == 0) {
        await repository.storeQuestOfferReward(model);
      } else {
        await repository.updateQuestOfferReward(_originalId, model);
      }
      _originalId = model.id;

      if (!context.mounted) return;
      var toast = ShadToast(description: Text('发放奖励数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void _applyToSignals(QuestOfferRewardEntity model) {
    emote1.value = model.emote1;
    emote2.value = model.emote2;
    emote3.value = model.emote3;
    emote4.value = model.emote4;
    emoteDelay1.value = model.emoteDelay1;
    emoteDelay2.value = model.emoteDelay2;
    emoteDelay3.value = model.emoteDelay3;
    emoteDelay4.value = model.emoteDelay4;
    rewardTextController.text = model.rewardText;
  }

  QuestOfferRewardEntity _collect() {
    return QuestOfferRewardEntity(
      id: questId.value,
      emote1: emote1.value,
      emote2: emote2.value,
      emote3: emote3.value,
      emote4: emote4.value,
      emoteDelay1: emoteDelay1.value,
      emoteDelay2: emoteDelay2.value,
      emoteDelay3: emoteDelay3.value,
      emoteDelay4: emoteDelay4.value,
      rewardText: rewardTextController.text,
    );
  }

  void dispose() {
    rewardTextController.dispose();
  }
}
