import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellBonusDataViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final spellId = signal(0);

  final directBonusController = TextEditingController();
  final dotBonusController = TextEditingController();
  final apBonusController = TextEditingController();
  final apDotBonusController = TextEditingController();
  final commentsController = TextEditingController();

  final loading = signal(false);
  final bonusData = signal(SpellBonusDataEntity());

  Future<void> load() async {
    loading.value = true;
    try {
      final repository = SpellBonusDataRepository();
      final data = await repository.getSpellBonusData(spellId.value);
      if (data != null) {
        bonusData.value = data;
      }
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
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
      directBonus: _parseDouble(directBonusController.text),
      dotBonus: _parseDouble(dotBonusController.text),
      apBonus: _parseDouble(apBonusController.text),
      apDotBonus: _parseDouble(apDotBonusController.text),
      comments: commentsController.text,
    );
  }

  double _parseDouble(String text) {
    if (text.isEmpty) return 0.0;
    final value = double.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void initControllers(SpellBonusDataEntity data) {
    directBonusController.text = data.directBonus.toString();
    dotBonusController.text = data.dotBonus.toString();
    apBonusController.text = data.apBonus.toString();
    apDotBonusController.text = data.apDotBonus.toString();
    commentsController.text = data.comments;
  }

  Future<void> initSignals({required int spellId}) async {
    this.spellId.value = spellId;
    await load();
  }

  void dispose() {
    directBonusController.dispose();
    dotBonusController.dispose();
    apBonusController.dispose();
    apDotBonusController.dispose();
    commentsController.dispose();
  }
}
