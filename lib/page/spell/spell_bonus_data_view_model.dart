import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellBonusDataViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final spellId = signal(0);

  final directBonus = signal<double>(0.0);
  final dotBonus = signal<double>(0.0);
  final apBonus = signal<double>(0.0);
  final apDotBonus = signal<double>(0.0);
  final commentsController = TextEditingController();

  final bonusData = signal(SpellBonusDataEntity());

  Future<void> load() async {
    final repository = SpellBonusDataRepository();
    final data = await repository.getSpellBonusData(spellId.value);
    if (data != null) {
      bonusData.value = data;
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      final repository = SpellBonusDataRepository();
      await repository.saveSpellBonusData(data);
      bonusData.value = data;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('奖励系数已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  SpellBonusDataEntity _collectFromControllers() {
    return SpellBonusDataEntity(
      entry: spellId.value,
      directBonus: directBonus.value,
      dotBonus: dotBonus.value,
      apBonus: apBonus.value,
      apDotBonus: apDotBonus.value,
      comments: commentsController.text,
    );
  }

  void initControllers(SpellBonusDataEntity data) {
    directBonus.value = data.directBonus;
    dotBonus.value = data.dotBonus;
    apBonus.value = data.apBonus;
    apDotBonus.value = data.apDotBonus;
    commentsController.text = data.comments;
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      this.spellId.value = spellId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('法术加成-初始化失败: $e');
      DialogUtil.instance.error('法术加成-初始化失败: $e');
    }
  }

  void dispose() {
    commentsController.dispose();
  }
}
