import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_solo_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellItemEnchantmentDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final id = signal<int>(0);
  final nameController = TextEditingController();
  final charges = signal<int>(0);

  /// Effect
  final effect0 = signal<int>(0);
  final effect1 = signal<int>(0);
  final effect2 = signal<int>(0);

  /// EffectPointsMin
  final effectPointsMin0 = signal<int>(0);
  final effectPointsMin1 = signal<int>(0);
  final effectPointsMin2 = signal<int>(0);

  /// EffectPointsMax
  final effectPointsMax0 = signal<int>(0);
  final effectPointsMax1 = signal<int>(0);
  final effectPointsMax2 = signal<int>(0);

  /// EffectArg
  final effectArg0 = signal<int>(0);
  final effectArg1 = signal<int>(0);
  final effectArg2 = signal<int>(0);

  /// Other
  final itemVisual = signal<int>(0);
  final flags = signal<int>(0);
  final srcItemId = signal<int>(0);
  final conditionId = signal<int>(0);
  final requiredSkillId = signal<int>(0);
  final requiredSkillRank = signal<int>(0);
  final minLevel = signal<int>(0);

  final enchantment = signal(SpellItemEnchantmentEntity());
  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = SpellItemEnchantmentSoloRepository();
      if (t.id == 0) {
        await repository.storeSpellItemEnchantment(t);
      } else {
        await repository.updateSpellItemEnchantment(t);
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
    final t = SpellItemEnchantmentEntity(
      id: id.value,
      nameLangZhCn: nameController.text,
      charges: charges.value,
      effect0: effect0.value,
      effect1: effect1.value,
      effect2: effect2.value,
      effectPointsMin0: effectPointsMin0.value,
      effectPointsMin1: effectPointsMin1.value,
      effectPointsMin2: effectPointsMin2.value,
      effectPointsMax0: effectPointsMax0.value,
      effectPointsMax1: effectPointsMax1.value,
      effectPointsMax2: effectPointsMax2.value,
      effectArg0: effectArg0.value,
      effectArg1: effectArg1.value,
      effectArg2: effectArg2.value,
      itemVisual: itemVisual.value,
      flags: flags.value,
      srcItemId: srcItemId.value,
      conditionId: conditionId.value,
      requiredSkillId: requiredSkillId.value,
      requiredSkillRank: requiredSkillRank.value,
      minLevel: minLevel.value,
    );
    return t;
  }

  void _logActivity(ActivityActionType action, SpellItemEnchantmentEntity t) {
    final log = ActivityLogEntity(
      module: 'spell_item_enchantment',
      actionType: action,
      entityId: t.id,
      entityName: t.nameLangZhCn,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    nameController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      enchantment.value = (await SpellItemEnchantmentSoloRepository()
          .getSpellItemEnchantment(id))!;
      _initControllers(enchantment.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载法术附魔(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(SpellItemEnchantmentEntity entry) {
    id.value = entry.id;
    nameController.text = entry.nameLangZhCn;
    charges.value = entry.charges;
    effect0.value = entry.effect0;
    effect1.value = entry.effect1;
    effect2.value = entry.effect2;
    effectPointsMin0.value = entry.effectPointsMin0;
    effectPointsMin1.value = entry.effectPointsMin1;
    effectPointsMin2.value = entry.effectPointsMin2;
    effectPointsMax0.value = entry.effectPointsMax0;
    effectPointsMax1.value = entry.effectPointsMax1;
    effectPointsMax2.value = entry.effectPointsMax2;
    effectArg0.value = entry.effectArg0;
    effectArg1.value = entry.effectArg1;
    effectArg2.value = entry.effectArg2;
    itemVisual.value = entry.itemVisual;
    flags.value = entry.flags;
    srcItemId.value = entry.srcItemId;
    conditionId.value = entry.conditionId;
    requiredSkillId.value = entry.requiredSkillId;
    requiredSkillRank.value = entry.requiredSkillRank;
    minLevel.value = entry.minLevel;
  }
}
