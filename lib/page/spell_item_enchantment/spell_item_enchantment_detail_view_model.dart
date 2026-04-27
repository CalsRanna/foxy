import 'package:flutter/widgets.dart';
import 'package:foxy/model/spell_item_enchantment.dart';
import 'package:foxy/repository/spell_item_enchantment_solo_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellItemEnchantmentDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final chargesController = TextEditingController();

  /// Effect
  final effect0Controller = TextEditingController();
  final effect1Controller = TextEditingController();
  final effect2Controller = TextEditingController();

  /// EffectPointsMin
  final effectPointsMin0Controller = TextEditingController();
  final effectPointsMin1Controller = TextEditingController();
  final effectPointsMin2Controller = TextEditingController();

  /// EffectPointsMax
  final effectPointsMax0Controller = TextEditingController();
  final effectPointsMax1Controller = TextEditingController();
  final effectPointsMax2Controller = TextEditingController();

  /// EffectArg
  final effectArg0Controller = TextEditingController();
  final effectArg1Controller = TextEditingController();
  final effectArg2Controller = TextEditingController();

  /// Other
  final itemVisualController = TextEditingController();
  final flagsController = TextEditingController();
  final srcItemIdController = TextEditingController();
  final conditionIdController = TextEditingController();
  final requiredSkillIdController = TextEditingController();
  final requiredSkillRankController = TextEditingController();
  final minLevelController = TextEditingController();

  final table = signal(SpellItemEnchantment());

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = SpellItemEnchantmentSoloRepository();
      if (t.id == 0) {
        await repository.store(t);
      } else {
        await repository.update(t);
      }
      table.value = t;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('法术附魔数据已保存'));
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

  /// 从所有 Controller 收集数据构建 SpellItemEnchantment
  SpellItemEnchantment _collectFromControllers() {
    final t = SpellItemEnchantment();

    /// Basic
    t.id = _parseInt(idController.text);
    t.nameLangZhCn = nameController.text;
    t.charges = _parseInt(chargesController.text);

    /// Effect
    t.effect0 = _parseInt(effect0Controller.text);
    t.effect1 = _parseInt(effect1Controller.text);
    t.effect2 = _parseInt(effect2Controller.text);

    /// EffectPointsMin
    t.effectPointsMin0 = _parseInt(effectPointsMin0Controller.text);
    t.effectPointsMin1 = _parseInt(effectPointsMin1Controller.text);
    t.effectPointsMin2 = _parseInt(effectPointsMin2Controller.text);

    /// EffectPointsMax
    t.effectPointsMax0 = _parseInt(effectPointsMax0Controller.text);
    t.effectPointsMax1 = _parseInt(effectPointsMax1Controller.text);
    t.effectPointsMax2 = _parseInt(effectPointsMax2Controller.text);

    /// EffectArg
    t.effectArg0 = _parseInt(effectArg0Controller.text);
    t.effectArg1 = _parseInt(effectArg1Controller.text);
    t.effectArg2 = _parseInt(effectArg2Controller.text);

    /// Other
    t.itemVisual = _parseInt(itemVisualController.text);
    t.flags = _parseInt(flagsController.text);
    t.srcItemId = _parseInt(srcItemIdController.text);
    t.conditionId = _parseInt(conditionIdController.text);
    t.requiredSkillId = _parseInt(requiredSkillIdController.text);
    t.requiredSkillRank = _parseInt(requiredSkillRankController.text);
    t.minLevel = _parseInt(minLevelController.text);

    return t;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void dispose() {
    /// Basic
    idController.dispose();
    nameController.dispose();
    chargesController.dispose();

    /// Effect
    effect0Controller.dispose();
    effect1Controller.dispose();
    effect2Controller.dispose();

    /// EffectPointsMin
    effectPointsMin0Controller.dispose();
    effectPointsMin1Controller.dispose();
    effectPointsMin2Controller.dispose();

    /// EffectPointsMax
    effectPointsMax0Controller.dispose();
    effectPointsMax1Controller.dispose();
    effectPointsMax2Controller.dispose();

    /// EffectArg
    effectArg0Controller.dispose();
    effectArg1Controller.dispose();
    effectArg2Controller.dispose();

    /// Other
    itemVisualController.dispose();
    flagsController.dispose();
    srcItemIdController.dispose();
    conditionIdController.dispose();
    requiredSkillIdController.dispose();
    requiredSkillRankController.dispose();
    minLevelController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      table.value =
          (await SpellItemEnchantmentSoloRepository().find(id))!;
      _initControllers(table.value);
    } catch (e, s) {
      logger.e('加载法术附魔(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(SpellItemEnchantment entry) {
    /// Basic
    idController.text = entry.id.toString();
    nameController.text = entry.nameLangZhCn;
    chargesController.text = entry.charges.toString();

    /// Effect
    effect0Controller.text = entry.effect0.toString();
    effect1Controller.text = entry.effect1.toString();
    effect2Controller.text = entry.effect2.toString();

    /// EffectPointsMin
    effectPointsMin0Controller.text = entry.effectPointsMin0.toString();
    effectPointsMin1Controller.text = entry.effectPointsMin1.toString();
    effectPointsMin2Controller.text = entry.effectPointsMin2.toString();

    /// EffectPointsMax
    effectPointsMax0Controller.text = entry.effectPointsMax0.toString();
    effectPointsMax1Controller.text = entry.effectPointsMax1.toString();
    effectPointsMax2Controller.text = entry.effectPointsMax2.toString();

    /// EffectArg
    effectArg0Controller.text = entry.effectArg0.toString();
    effectArg1Controller.text = entry.effectArg1.toString();
    effectArg2Controller.text = entry.effectArg2.toString();

    /// Other
    itemVisualController.text = entry.itemVisual.toString();
    flagsController.text = entry.flags.toString();
    srcItemIdController.text = entry.srcItemId.toString();
    conditionIdController.text = entry.conditionId.toString();
    requiredSkillIdController.text = entry.requiredSkillId.toString();
    requiredSkillRankController.text = entry.requiredSkillRank.toString();
    minLevelController.text = entry.minLevel.toString();
  }
}
