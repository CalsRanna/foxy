import 'package:flutter/widgets.dart';
import 'package:foxy/model/quest_offer_reward.dart';
import 'package:foxy/repository/quest_offer_reward_locale_repository.dart';
import 'package:foxy/repository/quest_offer_reward_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:signals/signals.dart';

/// QuestOfferReward 子表 ViewModel（1:1 编辑模式 + locale）
///
/// 10 个显式 TextEditingController 用于主表字段，
/// Map<String, TextEditingController> 用于 locale 字段。
class QuestOfferRewardViewModel {
  final _repository = QuestOfferRewardRepository();
  final _localeRepository = QuestOfferRewardLocaleRepository();

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

  final _localeControllers = <String, TextEditingController>{};

  /// 按需获取 locale 字段 controller（惰性初始化）
  TextEditingController localeControllerOf(String key) {
    return _localeControllers.putIfAbsent(key, () => TextEditingController());
  }

  final loading = signal(false);
  final saving = signal(false);
  final creating = signal(true);
  final currentId = signal(0);
  final localeExists = signal(false);

  int _originalId = 0;

  /// 加载：find main + load zhCN locale，不存在则进入创建模式
  Future<void> search(int questId) async {
    loading.value = true;
    try {
      final existing = await _repository.find(questId);
      if (existing != null) {
        creating.value = false;
        _originalId = existing.id;
        currentId.value = existing.id;
        _applyToControllers(existing);
      } else {
        creating.value = true;
        final blank = await _repository.create(questId);
        currentId.value = questId;
        _applyToControllers(blank);
      }

      final locales = await _localeRepository.search(questId);
      QuestOfferRewardLocale? zhCN;
      for (final l in locales) {
        if (l.locale == 'zhCN') {
          zhCN = l;
          break;
        }
      }
      localeExists.value = zhCN != null;
      final target = zhCN ?? (QuestOfferRewardLocale()..id = questId);
      _applyLocaleToControllers(target);
    } finally {
      loading.value = false;
    }
  }

  /// 保存主表 + replaceAll locale（zhCN）
  Future<void> onSave() async {
    saving.value = true;
    try {
      final model = _collectFromControllers();
      if (creating.value) {
        await _repository.store(model);
        creating.value = false;
      } else {
        await _repository.update(_originalId, model);
      }
      _originalId = model.id;
      currentId.value = model.id;

      final locale = _collectLocaleFromControllers(model.id);
      await _localeRepository.replaceAll(model.id, [locale]);
      localeExists.value = true;

      DialogUtil.instance.success('保存成功');
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('保存失败: ${e.toString()}');
    } finally {
      saving.value = false;
    }
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

  void _applyLocaleToControllers(QuestOfferRewardLocale locale) {
    localeControllerOf('RewardText').text = locale.rewardText;
  }

  QuestOfferReward _collectFromControllers() {
    final model = QuestOfferReward();
    model.id = _parseInt(idController.text);
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

  QuestOfferRewardLocale _collectLocaleFromControllers(int id) {
    final locale = QuestOfferRewardLocale();
    locale.id = id;
    locale.locale = 'zhCN';
    locale.rewardText = localeControllerOf('RewardText').text;
    return locale;
  }

  int _parseInt(String text) => int.tryParse(text) ?? 0;

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
    for (final c in _localeControllers.values) {
      c.dispose();
    }
    _localeControllers.clear();
  }
}