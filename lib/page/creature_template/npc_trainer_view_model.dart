import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_npc_trainer_entity.dart';
import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/entity/npc_trainer_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_default_trainer_repository.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/npc_trainer_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class NpcTrainerViewModel
    with
        ViewModelValidationMixin,
        NpcTrainerValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<NpcTrainerRepository>();
  final _relationRepository = GetIt.instance
      .get<CreatureDefaultTrainerRepository>();

  final creatureId = signal(0);
  final editingKey = signal<NpcTrainerKey?>(null);
  final items = signal<List<BriefNpcTrainerEntity>>([]);
  final page = signal(1);
  final relationTrainerId = signal<int?>(null);
  final selectedIndex = signal<int?>(null);
  final total = signal(0);

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

  int _refreshToken = 0;

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
      final trainerId = relationTrainerId.value;
      if (trainerId == null) {
        throw StateError('该生物未配置 creature_default_trainer');
      }
      final blank = await _repository.createNpcTrainer(trainerId);
      _clearEditingState();
      _initControllers(blank);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建训练师技能记录失败: $error');
      DialogUtil.instance.error('创建训练师技能记录失败: $error');
      return false;
    }
  }

  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final trainer = items.value[index];
    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: const Text('确认删除'),
        description: const Text('确定要删除这条训练师技能记录吗？'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _repository.destroyNpcTrainer(trainer.key);
      await load();
      if (!context.mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('删除成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<bool> edit() async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return false;
    final key = items.value[index].key;
    editingKey.value = key;
    try {
      final trainer = await _repository.getNpcTrainer(key);
      if (trainer == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(trainer);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('加载训练师技能记录失败: $error');
      DialogUtil.instance.error('加载训练师技能记录失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int creatureId}) async {
    try {
      await setParentCreatureId(creatureId);
    } catch (error) {
      LoggerUtil.instance.e('初始化 NPC 训练师失败: $error');
      DialogUtil.instance.error('初始化 NPC 训练师失败: $error');
    }
  }

  Future<void> load() => _refresh();

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateNpcTrainerFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeNpcTrainer(candidate);
    } else {
      await _repository.updateNpcTrainer(originalKey, candidate);
    }
    editingKey.value = NpcTrainerKey.fromEntity(candidate);
    await _refresh();
  }

  void resetForm() {
    _initControllers(NpcTrainerEntity(trainerId: relationTrainerId.value ?? 0));
  }

  Future<bool> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return true;
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
      return true;
    } catch (error) {
      if (!context.mounted) return false;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
      return false;
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> setParentCreatureId(int creatureId) async {
    if (this.creatureId.value != creatureId) page.value = 1;
    this.creatureId.value = creatureId;
    _clearEditingState(resetForm: true);
    await _refresh();
  }

  void _clearEditingState({bool resetForm = false}) {
    editingKey.value = null;
    selectedIndex.value = null;
    if (resetForm) this.resetForm();
  }

  void _initControllers(NpcTrainerEntity trainer) {
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

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentCreatureId = creatureId.value;
    final relation = await _relationRepository.getCreatureDefaultTrainer(
      parentCreatureId,
    );
    if (token != _refreshToken) return;
    final trainerId = relation?.trainerId;
    final count = trainerId == null
        ? 0
        : await _repository.countNpcTrainers(trainerId);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = trainerId == null
        ? <BriefNpcTrainerEntity>[]
        : await _repository.getBriefNpcTrainers(trainerId, page: page.value);
    if (token != _refreshToken) return;
    relationTrainerId.value = trainerId;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }
}
