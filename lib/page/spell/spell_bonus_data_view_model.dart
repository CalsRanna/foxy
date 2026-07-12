import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellBonusDataViewModel {
  final _repository = GetIt.instance.get<SpellBonusDataRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final spellId = signal(0);

  final spellIdController = IntFieldController();
  final directBonusController = DoubleFieldController();
  final dotBonusController = DoubleFieldController();
  final apBonusController = DoubleFieldController();
  final apDotBonusController = DoubleFieldController();
  final commentsController = StringFieldController();

  late final _controllers = <FieldController>[
    spellIdController,
    directBonusController,
    dotBonusController,
    apBonusController,
    apDotBonusController,
    commentsController,
  ];

  final bonusData = signal(SpellBonusDataEntity());

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
      directBonus: directBonusController.collect(),
      dotBonus: dotBonusController.collect(),
      apBonus: apBonusController.collect(),
      apDotBonus: apDotBonusController.collect(),
      comments: commentsController.collect(),
    );
  }

  void initControllers(SpellBonusDataEntity data) {
    spellIdController.init(spellId.value);
    directBonusController.init(data.directBonus);
    dotBonusController.init(data.dotBonus);
    apBonusController.init(data.apBonus);
    apDotBonusController.init(data.apDotBonus);
    commentsController.init(data.comments);
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      this.spellId.value = spellId;
      spellIdController.init(spellId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('法术加成-初始化失败: $e');
      DialogUtil.instance.error('法术加成-初始化失败: $e');
    }
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }
}
