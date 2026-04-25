import 'package:flutter/material.dart';
import 'package:foxy/model/quest_offer_reward.dart';
import 'package:foxy/repository/quest_offer_reward_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestOfferRewardViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);

  final idController = TextEditingController();
  final emote1Controller = TextEditingController();
  final emote2Controller = TextEditingController();
  final emote3Controller = TextEditingController();
  final emote4Controller = TextEditingController();
  final emoteDelay1Controller = TextEditingController();
  final emoteDelay2Controller = TextEditingController();
  final emoteDelay3Controller = TextEditingController();
  final emoteDelay4Controller = TextEditingController();
  final rewardTextController = TextEditingController();

  int _originalId = 0;

  Future<void> initSignals({required int questId}) async {
    this.questId.value = questId;
    final repository = QuestOfferRewardRepository();
    final existing = await repository.find(questId);
    if (existing != null) {
      _originalId = existing.id;
      _applyToControllers(existing);
    } else {
      final blank = await repository.create(questId);
      _applyToControllers(blank);
    }
    idController.text = questId.toString();
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collectFromControllers();
      final repository = QuestOfferRewardRepository();
      if (_originalId == 0) {
        await repository.store(model);
      } else {
        await repository.update(_originalId, model);
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

  void _applyToControllers(QuestOfferReward model) {
    idController.text = model.id.toString();
    emote1Controller.text = model.emote1.toString();
    emote2Controller.text = model.emote2.toString();
    emote3Controller.text = model.emote3.toString();
    emote4Controller.text = model.emote4.toString();
    emoteDelay1Controller.text = model.emoteDelay1.toString();
    emoteDelay2Controller.text = model.emoteDelay2.toString();
    emoteDelay3Controller.text = model.emoteDelay3.toString();
    emoteDelay4Controller.text = model.emoteDelay4.toString();
    rewardTextController.text = model.rewardText;
  }

  QuestOfferReward _collectFromControllers() {
    final model = QuestOfferReward();
    model.id = questId.value;
    model.emote1 = _parseInt(emote1Controller.text);
    model.emote2 = _parseInt(emote2Controller.text);
    model.emote3 = _parseInt(emote3Controller.text);
    model.emote4 = _parseInt(emote4Controller.text);
    model.emoteDelay1 = _parseInt(emoteDelay1Controller.text);
    model.emoteDelay2 = _parseInt(emoteDelay2Controller.text);
    model.emoteDelay3 = _parseInt(emoteDelay3Controller.text);
    model.emoteDelay4 = _parseInt(emoteDelay4Controller.text);
    model.rewardText = rewardTextController.text;
    return model;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

  void dispose() {
    idController.dispose();
    emote1Controller.dispose();
    emote2Controller.dispose();
    emote3Controller.dispose();
    emote4Controller.dispose();
    emoteDelay1Controller.dispose();
    emoteDelay2Controller.dispose();
    emoteDelay3Controller.dispose();
    emoteDelay4Controller.dispose();
    rewardTextController.dispose();
  }
}