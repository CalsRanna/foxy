import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/repository/quest_offer_reward_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestOfferRewardViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestOfferRewardRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);

  late final idController = registerController(IntFieldController());
  late final emote1Controller = registerController(IntFieldController());
  late final emote2Controller = registerController(IntFieldController());
  late final emote3Controller = registerController(IntFieldController());
  late final emote4Controller = registerController(IntFieldController());
  late final emoteDelay1Controller = registerController(IntFieldController());
  late final emoteDelay2Controller = registerController(IntFieldController());
  late final emoteDelay3Controller = registerController(IntFieldController());
  late final emoteDelay4Controller = registerController(IntFieldController());
  late final rewardTextController = registerController(StringFieldController());

  int _originalId = 0;

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
      idController.init(questId);
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
    emote1Controller.init(model.emote1);
    emote2Controller.init(model.emote2);
    emote3Controller.init(model.emote3);
    emote4Controller.init(model.emote4);
    emoteDelay1Controller.init(model.emoteDelay1);
    emoteDelay2Controller.init(model.emoteDelay2);
    emoteDelay3Controller.init(model.emoteDelay3);
    emoteDelay4Controller.init(model.emoteDelay4);
    rewardTextController.init(model.rewardText);
  }

  QuestOfferRewardEntity _collect() {
    return QuestOfferRewardEntity(
      id: questId.value,
      emote1: emote1Controller.collect(),
      emote2: emote2Controller.collect(),
      emote3: emote3Controller.collect(),
      emote4: emote4Controller.collect(),
      emoteDelay1: emoteDelay1Controller.collect(),
      emoteDelay2: emoteDelay2Controller.collect(),
      emoteDelay3: emoteDelay3Controller.collect(),
      emoteDelay4: emoteDelay4Controller.collect(),
      rewardText: rewardTextController.collect(),
    );
  }

  void dispose() {
    disposeControllers();
  }
}
