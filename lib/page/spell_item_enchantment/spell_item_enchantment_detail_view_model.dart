import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellItemEnchantmentDetailViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellItemEnchantmentRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  late final idController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final chargesController = registerController(IntFieldController());

  /// Effect
  late final effect0Controller = registerController(IntFieldController());
  late final effect1Controller = registerController(IntFieldController());
  late final effect2Controller = registerController(IntFieldController());

  /// EffectPointsMin
  late final effectPointsMin0Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMin1Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMin2Controller = registerController(
    IntFieldController(),
  );

  /// EffectPointsMax
  late final effectPointsMax0Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMax1Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMax2Controller = registerController(
    IntFieldController(),
  );

  /// EffectArg
  late final effectArg0Controller = registerController(IntFieldController());
  late final effectArg1Controller = registerController(IntFieldController());
  late final effectArg2Controller = registerController(IntFieldController());

  /// Other
  late final itemVisualController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final srcItemIdController = registerController(IntFieldController());
  late final conditionIdController = registerController(IntFieldController());
  late final requiredSkillIdController = registerController(
    IntFieldController(),
  );
  late final requiredSkillRankController = registerController(
    IntFieldController(),
  );
  late final minLevelController = registerController(IntFieldController());

  final enchantment = signal(SpellItemEnchantmentEntity());

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      final isCreate =
          (await _repository.getSpellItemEnchantment(t.id)) == null;
      if (isCreate) {
        final id = await _repository.storeSpellItemEnchantment(t);
        t = t.copyWith(id: id);
        idController.init(id);
      } else {
        await _repository.updateSpellItemEnchantment(t);
      }
      enchantment.value = t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
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

  void applyNameLocales(List<DbcLocaleFieldValue> values) {
    enchantment.value = enchantment.value.copyWith(
      nameLangEnUS: values.valueOf('enUS'),
      nameLangKoKR: values.valueOf('koKR'),
      nameLangFrFR: values.valueOf('frFR'),
      nameLangDeDE: values.valueOf('deDE'),
      nameLangZhCN: values.valueOf('zhCN'),
      nameLangZhTW: values.valueOf('zhTW'),
      nameLangEsES: values.valueOf('esES'),
      nameLangEsMX: values.valueOf('esMX'),
      nameLangRuRU: values.valueOf('ruRU'),
      nameLangJaJP: values.valueOf('jaJP'),
      nameLangPtPT: values.valueOf('ptPT'),
      nameLangPtBR: values.valueOf('ptBR'),
      nameLangItIT: values.valueOf('itIT'),
      nameLangUnk1: values.valueOf('unk1'),
      nameLangUnk2: values.valueOf('unk2'),
      nameLangUnk3: values.valueOf('unk3'),
    );
    nameController.init(values.zhCN);
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 SpellItemEnchantment
  SpellItemEnchantmentEntity _collectFromControllers() {
    // 基于已加载实体覆盖 UI 字段，避免清空未展示的多语言等列。
    return enchantment.value.copyWith(
      id: idController.collect(),
      nameLangZhCN: nameController.collect(),
      charges: chargesController.collect(),
      effect0: effect0Controller.collect(),
      effect1: effect1Controller.collect(),
      effect2: effect2Controller.collect(),
      effectPointsMin0: effectPointsMin0Controller.collect(),
      effectPointsMin1: effectPointsMin1Controller.collect(),
      effectPointsMin2: effectPointsMin2Controller.collect(),
      effectPointsMax0: effectPointsMax0Controller.collect(),
      effectPointsMax1: effectPointsMax1Controller.collect(),
      effectPointsMax2: effectPointsMax2Controller.collect(),
      effectArg0: effectArg0Controller.collect(),
      effectArg1: effectArg1Controller.collect(),
      effectArg2: effectArg2Controller.collect(),
      itemVisual: itemVisualController.collect(),
      flags: flagsController.collect(),
      srcItemId: srcItemIdController.collect(),
      conditionId: conditionIdController.collect(),
      requiredSkillId: requiredSkillIdController.collect(),
      requiredSkillRank: requiredSkillRankController.collect(),
      minLevel: minLevelController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, SpellItemEnchantmentEntity t) {
    final log = ActivityLogEntity(
      module: 'spell_item_enchantment',
      actionType: action,
      entityId: t.id,
      entityName: t.nameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createSpellItemEnchantment();
        enchantment.value = blank;
        _initControllers(blank);
        return;
      }
      enchantment.value = (await _repository.getSpellItemEnchantment(id))!;
      _initControllers(enchantment.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载法术附魔(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(SpellItemEnchantmentEntity entry) {
    idController.init(entry.id);
    nameController.init(entry.nameLangZhCN);
    chargesController.init(entry.charges);
    effect0Controller.init(entry.effect0);
    effect1Controller.init(entry.effect1);
    effect2Controller.init(entry.effect2);
    effectPointsMin0Controller.init(entry.effectPointsMin0);
    effectPointsMin1Controller.init(entry.effectPointsMin1);
    effectPointsMin2Controller.init(entry.effectPointsMin2);
    effectPointsMax0Controller.init(entry.effectPointsMax0);
    effectPointsMax1Controller.init(entry.effectPointsMax1);
    effectPointsMax2Controller.init(entry.effectPointsMax2);
    effectArg0Controller.init(entry.effectArg0);
    effectArg1Controller.init(entry.effectArg1);
    effectArg2Controller.init(entry.effectArg2);
    itemVisualController.init(entry.itemVisual);
    flagsController.init(entry.flags);
    srcItemIdController.init(entry.srcItemId);
    conditionIdController.init(entry.conditionId);
    requiredSkillIdController.init(entry.requiredSkillId);
    requiredSkillRankController.init(entry.requiredSkillRank);
    minLevelController.init(entry.minLevel);
  }
}
