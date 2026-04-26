import 'package:flutter/material.dart';
import 'package:foxy/model/spell_bonus_data.dart';
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
  final bonusData = signal(SpellBonusData());

  Future<void> load() async {
    loading.value = true;
    try {
      final repository = SpellBonusDataRepository();
      final data = await repository.find(spellId.value);
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
      await repository.save(data);
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

  SpellBonusData _collectFromControllers() {
    final data = SpellBonusData();
    data.entry = spellId.value;
    data.directBonus = _parseDouble(directBonusController.text);
    data.dotBonus = _parseDouble(dotBonusController.text);
    data.apBonus = _parseDouble(apBonusController.text);
    data.apDotBonus = _parseDouble(apDotBonusController.text);
    data.comments = commentsController.text;
    return data;
  }

  double _parseDouble(String text) => text.isEmpty ? 0.0 : double.parse(text);

  void initControllers(SpellBonusData data) {
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
