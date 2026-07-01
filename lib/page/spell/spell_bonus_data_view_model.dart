import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellBonusDataViewModel {
  final _repository = GetIt.instance.get<SpellBonusDataRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final spellId = signal(0);

  final directBonusController = TextEditingController();
  final dotBonusController = TextEditingController();
  final apBonusController = TextEditingController();
  final apDotBonusController = TextEditingController();
  final commentsController = TextEditingController();

  final bonusData = signal(SpellBonusDataEntity());

  String _fmt(num v) => formatNum(v);

  double _pd(String t) => double.tryParse(t) ?? 0.0;

  Future<void> load() async {
    final data = await _repository.getSpellBonusData(spellId.value);
    if (data != null) {
      bonusData.value = data;
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      await _repository.saveSpellBonusData(data);
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
      directBonus: _pd(directBonusController.text),
      dotBonus: _pd(dotBonusController.text),
      apBonus: _pd(apBonusController.text),
      apDotBonus: _pd(apDotBonusController.text),
      comments: commentsController.text,
    );
  }

  void initControllers(SpellBonusDataEntity data) {
    directBonusController.text = _fmt(data.directBonus);
    dotBonusController.text = _fmt(data.dotBonus);
    apBonusController.text = _fmt(data.apBonus);
    apDotBonusController.text = _fmt(data.apDotBonus);
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
    apBonusController.dispose();
    apDotBonusController.dispose();
    commentsController.dispose();
    directBonusController.dispose();
    dotBonusController.dispose();
  }
}
