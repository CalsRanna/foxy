import 'package:flutter/widgets.dart';
import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_default_trainer_repository.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class NpcTrainerViewModel with FieldControllerMixin {
  final creatureId = signal(0);
  final items = signal<List<BriefNpcTrainerEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final creating = signal(false);
  final editing = signal(false);

  late final creatureIdController = registerController(IntFieldController());
  late final trainerIdController = registerController(IntFieldController());
  late final spellIdController = registerController(IntFieldController());
  late final moneyCostController = registerController(IntFieldController());
  late final reqSkillLineController = registerController(IntFieldController());
  late final reqSkillRankController = registerController(IntFieldController());
  late final reqAbility1Controller = registerController(IntFieldController());
  late final reqAbility2Controller = registerController(IntFieldController());
  late final reqAbility3Controller = registerController(IntFieldController());
  late final reqLevelController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  final _repository = GetIt.instance.get<NpcTrainerRepository>();
  final _relationRepository = GetIt.instance
      .get<CreatureDefaultTrainerRepository>();

  Future<void> load() async {
    final relation = await _relationRepository.getCreatureDefaultTrainer(
      creatureId.value,
    );
    trainerIdController.init(relation?.trainerId ?? 0);
    items.value = relation == null
        ? []
        : await _repository.getBriefNpcTrainers(relation.trainerId);
    selectedIndex.value = null;
    creating.value = false;
    editing.value = false;
  }

  void resetForm() {
    trainerIdController.init(0);
    spellIdController.init(0);
    moneyCostController.init(0);
    reqSkillLineController.init(0);
    reqSkillRankController.init(0);
    reqAbility1Controller.init(0);
    reqAbility2Controller.init(0);
    reqAbility3Controller.init(0);
    reqLevelController.init(0);
    verifiedBuildController.init(0);
  }

  void fillForm(BriefNpcTrainerEntity trainer) {
    trainerIdController.init(trainer.trainerId);
    spellIdController.init(trainer.spellId);
    moneyCostController.init(trainer.moneyCost);
    reqSkillLineController.init(trainer.reqSkillLine);
    reqSkillRankController.init(trainer.reqSkillRank);
    reqAbility1Controller.init(trainer.reqAbility1);
    reqAbility2Controller.init(trainer.reqAbility2);
    reqAbility3Controller.init(trainer.reqAbility3);
    reqLevelController.init(trainer.reqLevel);
    verifiedBuildController.init(trainer.verifiedBuild);
  }

  NpcTrainerEntity collectFromForm() {
    return NpcTrainerEntity(
      trainerId: trainerIdController.collect(),
      spellId: spellIdController.collect(),
      moneyCost: moneyCostController.collect(),
      reqSkillLine: reqSkillLineController.collect(),
      reqSkillRank: reqSkillRankController.collect(),
      reqAbility1: reqAbility1Controller.collect(),
      reqAbility2: reqAbility2Controller.collect(),
      reqAbility3: reqAbility3Controller.collect(),
      reqLevel: reqLevelController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  Future<bool> create() async {
    try {
      final relation = await _relationRepository.getCreatureDefaultTrainer(
        creatureId.value,
      );
      if (relation == null) {
        throw StateError('该生物未配置 creature_default_trainer');
      }
      final blank = await _repository.createNpcTrainer(relation.trainerId);
      resetForm();
      trainerIdController.init(blank.trainerId);
      creating.value = true;
      editing.value = false;
      selectedIndex.value = null;
      return true;
    } catch (e) {
      LoggerUtil.instance.e('创建训练师技能记录失败: $e');
      DialogUtil.instance.error('创建训练师技能记录失败: $e');
      return false;
    }
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    fillForm(items.value[index]);
    editing.value = true;
    creating.value = false;
  }

  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final trainer = items.value[index];
    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条训练师技能记录吗？'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('取消'),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _repository.destroyNpcTrainer(trainer.trainerId, trainer.spellId);
      await load();
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('删除成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      await _repository.storeNpcTrainer(collectFromForm());
      await load();
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> update(BuildContext context) async {
    try {
      final trainer = collectFromForm();
      await _repository.updateNpcTrainer(
        trainer.trainerId,
        trainer.spellId,
        trainer,
      );
      await load();
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('更新成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> initSignals({required int creatureId}) async {
    try {
      this.creatureId.value = creatureId;
      creatureIdController.init(creatureId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化NPC训练师失败: $e');
      DialogUtil.instance.error('初始化NPC训练师失败: $e');
    }
  }

  void dispose() => disposeControllers();
}
