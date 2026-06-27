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
  final _repository = GetIt.instance.get<QuestOfferRewardRepository>();
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

  String _fmt(num v) {
    if (v is double) {
      final s = v.toString();
      if (s.contains('.') && s.endsWith('0')) {
        return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return s;
    }
    return v.toString();
  }

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> initSignals({required int questId}) async {
    try {
      this.questId.value = questId;
      final existing = await _repository.getQuestOfferReward(questId);
      if (existing != null) {
        _originalId = existing.id;
        _initSignals(existing);
      } else {
        final blank = await _repository.createQuestOfferReward(questId);
        _initSignals(blank);
      }
      idController.text = _fmt(questId);
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collect();
      if (_originalId == 0) {
        await _repository.storeQuestOfferReward(model);
      } else {
        await _repository.updateQuestOfferReward(_originalId, model);
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

  void _initSignals(QuestOfferRewardEntity model) {
    emote1Controller.text = _fmt(model.emote1);
    emote2Controller.text = _fmt(model.emote2);
    emote3Controller.text = _fmt(model.emote3);
    emote4Controller.text = _fmt(model.emote4);
    emoteDelay1Controller.text = _fmt(model.emoteDelay1);
    emoteDelay2Controller.text = _fmt(model.emoteDelay2);
    emoteDelay3Controller.text = _fmt(model.emoteDelay3);
    emoteDelay4Controller.text = _fmt(model.emoteDelay4);
    rewardTextController.text = model.rewardText;
  }

  QuestOfferRewardEntity _collect() {
    return QuestOfferRewardEntity(
      id: questId.value,
      emote1: _pi(emote1Controller.text),
      emote2: _pi(emote2Controller.text),
      emote3: _pi(emote3Controller.text),
      emote4: _pi(emote4Controller.text),
      emoteDelay1: _pi(emoteDelay1Controller.text),
      emoteDelay2: _pi(emoteDelay2Controller.text),
      emoteDelay3: _pi(emoteDelay3Controller.text),
      emoteDelay4: _pi(emoteDelay4Controller.text),
      rewardText: rewardTextController.text,
    );
  }

  void dispose() {
    emote1Controller.dispose();
    emote2Controller.dispose();
    emote3Controller.dispose();
    emote4Controller.dispose();
    emoteDelay1Controller.dispose();
    emoteDelay2Controller.dispose();
    emoteDelay3Controller.dispose();
    emoteDelay4Controller.dispose();
    idController.dispose();
    rewardTextController.dispose();
  }
}
