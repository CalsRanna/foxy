import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_solo_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellItemEnchantmentDetailViewModel {
  final _repository = GetIt.instance.get<SpellItemEnchantmentSoloRepository>();
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

  final enchantment = signal(SpellItemEnchantmentEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        final id = await _repository.storeSpellItemEnchantment(t);
        idController.text = '$id';
      } else {
        await _repository.updateSpellItemEnchantment(t);
      }
      enchantment.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
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
  SpellItemEnchantmentEntity _collectFromControllers() {
    // 基于已加载实体覆盖 UI 字段，避免清空未展示的多语言等列。
    final t = enchantment.value.copyWith(
      id: _pi(idController.text),
      nameLangZhCN: nameController.text,
      charges: _pi(chargesController.text),
      effect0: _pi(effect0Controller.text),
      effect1: _pi(effect1Controller.text),
      effect2: _pi(effect2Controller.text),
      effectPointsMin0: _pi(effectPointsMin0Controller.text),
      effectPointsMin1: _pi(effectPointsMin1Controller.text),
      effectPointsMin2: _pi(effectPointsMin2Controller.text),
      effectPointsMax0: _pi(effectPointsMax0Controller.text),
      effectPointsMax1: _pi(effectPointsMax1Controller.text),
      effectPointsMax2: _pi(effectPointsMax2Controller.text),
      effectArg0: _pi(effectArg0Controller.text),
      effectArg1: _pi(effectArg1Controller.text),
      effectArg2: _pi(effectArg2Controller.text),
      itemVisual: _pi(itemVisualController.text),
      flags: _pi(flagsController.text),
      srcItemId: _pi(srcItemIdController.text),
      conditionId: _pi(conditionIdController.text),
      requiredSkillId: _pi(requiredSkillIdController.text),
      requiredSkillRank: _pi(requiredSkillRankController.text),
      minLevel: _pi(minLevelController.text),
    );
    return t;
  }

  void _logActivity(ActivityActionType action, SpellItemEnchantmentEntity t) {
    final log = ActivityLogEntity(
      module: 'spell_item_enchantment',
      actionType: action,
      entityId: t.id,
      entityName: t.nameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    chargesController.dispose();
    conditionIdController.dispose();
    effect0Controller.dispose();
    effect1Controller.dispose();
    effect2Controller.dispose();
    effectArg0Controller.dispose();
    effectArg1Controller.dispose();
    effectArg2Controller.dispose();
    effectPointsMax0Controller.dispose();
    effectPointsMax1Controller.dispose();
    effectPointsMax2Controller.dispose();
    effectPointsMin0Controller.dispose();
    effectPointsMin1Controller.dispose();
    effectPointsMin2Controller.dispose();
    flagsController.dispose();
    idController.dispose();
    itemVisualController.dispose();
    minLevelController.dispose();
    nameController.dispose();
    requiredSkillIdController.dispose();
    requiredSkillRankController.dispose();
    srcItemIdController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      enchantment.value = (await _repository.getSpellItemEnchantment(id))!;
      _initControllers(enchantment.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载法术附魔(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(SpellItemEnchantmentEntity entry) {
    idController.text = _fmt(entry.id);
    nameController.text = entry.nameLangZhCN;
    chargesController.text = _fmt(entry.charges);
    effect0Controller.text = _fmt(entry.effect0);
    effect1Controller.text = _fmt(entry.effect1);
    effect2Controller.text = _fmt(entry.effect2);
    effectPointsMin0Controller.text = _fmt(entry.effectPointsMin0);
    effectPointsMin1Controller.text = _fmt(entry.effectPointsMin1);
    effectPointsMin2Controller.text = _fmt(entry.effectPointsMin2);
    effectPointsMax0Controller.text = _fmt(entry.effectPointsMax0);
    effectPointsMax1Controller.text = _fmt(entry.effectPointsMax1);
    effectPointsMax2Controller.text = _fmt(entry.effectPointsMax2);
    effectArg0Controller.text = _fmt(entry.effectArg0);
    effectArg1Controller.text = _fmt(entry.effectArg1);
    effectArg2Controller.text = _fmt(entry.effectArg2);
    itemVisualController.text = _fmt(entry.itemVisual);
    flagsController.text = _fmt(entry.flags);
    srcItemIdController.text = _fmt(entry.srcItemId);
    conditionIdController.text = _fmt(entry.conditionId);
    requiredSkillIdController.text = _fmt(entry.requiredSkillId);
    requiredSkillRankController.text = _fmt(entry.requiredSkillRank);
    minLevelController.text = _fmt(entry.minLevel);
  }
}
