import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_offer_reward_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestOfferRewardSingleEditorViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestOfferRewardRepository>();

  final parentKey = signal<int?>(null);
  final editingKey = signal<int?>(null);
  final entity = signal<QuestOfferRewardEntity?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

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
  late final verifiedBuildController = registerController(IntFieldController());

  int _refreshToken = 0;
  int _parentToken = 0;

  Future<void> initSignals({required int parentKey}) {
    return setParentKey(parentKey);
  }

  Future<void> setParentKey(int parentKey) async {
    if (this.parentKey.value == parentKey && entity.value != null) return;
    _parentToken++;
    this.parentKey.value = parentKey;
    editingKey.value = null;
    await _refresh();
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    final parentSnapshot = parentKey.value;
    if (parentSnapshot == null) throw StateError('父记录尚未加载');
    final parentToken = _parentToken;
    final candidate = _collectCandidate();
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeQuestOfferReward(candidate);
      } else {
        await _repository.updateQuestOfferReward(originalKey, candidate);
      }
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.id;
      await _refresh();
    } catch (error) {
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final key = editingKey.value;
    if (key == null) return;
    final parentSnapshot = parentKey.value;
    final parentToken = _parentToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyQuestOfferReward(key);
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      editingKey.value = null;
      await _refresh();
    } catch (error) {
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

QuestOfferRewardEntity _collectCandidate() {
    return QuestOfferRewardEntity(
      id: idController.collect(),
      emote1: emote1Controller.collect(),
      emote2: emote2Controller.collect(),
      emote3: emote3Controller.collect(),
      emote4: emote4Controller.collect(),
      emoteDelay1: emoteDelay1Controller.collect(),
      emoteDelay2: emoteDelay2Controller.collect(),
      emoteDelay3: emoteDelay3Controller.collect(),
      emoteDelay4: emoteDelay4Controller.collect(),
      rewardText: rewardTextController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

void _applyCandidate(QuestOfferRewardEntity model) {
    idController.init(model.id);
    emote1Controller.init(model.emote1);
    emote2Controller.init(model.emote2);
    emote3Controller.init(model.emote3);
    emote4Controller.init(model.emote4);
    emoteDelay1Controller.init(model.emoteDelay1);
    emoteDelay2Controller.init(model.emoteDelay2);
    emoteDelay3Controller.init(model.emoteDelay3);
    emoteDelay4Controller.init(model.emoteDelay4);
    rewardTextController.init(model.rewardText);
    verifiedBuildController.init(model.verifiedBuild);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentSnapshot = parentKey.value;
    if (parentSnapshot == null) {
      entity.value = null;
      editingKey.value = null;
      return;
    }
    loading.value = true;
    errorMessage.value = null;
    try {
      final existing = await _repository.getQuestOfferReward(parentSnapshot);
      if (token != _refreshToken) return;
      final candidate =
          existing ?? await _repository.createQuestOfferReward(parentSnapshot);
      if (token != _refreshToken) return;
      entity.value = candidate;
      editingKey.value = existing == null ? null : parentSnapshot;
      _applyCandidate(candidate);
    } catch (error, stackTrace) {
      if (token != _refreshToken) return;
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载单行编辑器失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() {
    disposeControllers();
  }
}
