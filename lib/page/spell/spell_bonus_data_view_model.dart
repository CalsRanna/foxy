import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/entity/spell_bonus_data_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellBonusDataViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellBonusDataRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  late final spellIdController = registerController(IntFieldController());
  late final directBonusController = registerController(
    DoubleFieldController(),
  );
  late final dotBonusController = registerController(DoubleFieldController());
  late final apBonusController = registerController(DoubleFieldController());
  late final apDotBonusController = registerController(DoubleFieldController());
  late final commentsController = registerController(StringFieldController());

  final bonusData = signal(SpellBonusDataEntity());
  final editingKey = signal<SpellBonusDataKey?>(null);

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      final key = SpellBonusDataKey(entry: spellId);
      final data = await _repository.getSpellBonusData(key);
      if (data == null) {
        editingKey.value = null;
        final blank = await _repository.createSpellBonusData(spellId);
        bonusData.value = blank;
        _initControllers(blank);
      } else {
        editingKey.value = key;
        bonusData.value = data;
        _initControllers(data);
      }
    } catch (e) {
      LoggerUtil.instance.e('法术加成-初始化失败: $e');
      DialogUtil.instance.error('法术加成-初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      final originalKey = editingKey.value;
      if (originalKey == null) {
        await _repository.storeSpellBonusData(data);
      } else {
        await _repository.updateSpellBonusData(originalKey, data);
      }
      editingKey.value = SpellBonusDataKey.fromEntity(data);
      bonusData.value = data;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('奖励系数已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  SpellBonusDataEntity _collectFromControllers() {
    return SpellBonusDataEntity(
      entry: spellIdController.collect(),
      directBonus: directBonusController.collect(),
      dotBonus: dotBonusController.collect(),
      apBonus: apBonusController.collect(),
      apDotBonus: apDotBonusController.collect(),
      comments: commentsController.collect(),
    );
  }

  void _initControllers(SpellBonusDataEntity data) {
    spellIdController.init(data.entry);
    directBonusController.init(data.directBonus);
    dotBonusController.init(data.dotBonus);
    apBonusController.init(data.apBonus);
    apDotBonusController.init(data.apDotBonus);
    commentsController.init(data.comments);
  }
}
