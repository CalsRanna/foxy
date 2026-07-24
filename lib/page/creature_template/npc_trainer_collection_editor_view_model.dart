import 'dart:math';
import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/npc_trainer_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class NpcTrainerCollectionEditorViewModel
    with
        ViewModelValidationMixin,
        NpcTrainerValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<NpcTrainerRepository>();

  final parentKey = signal<int?>(null);
  final items = signal<List<BriefNpcTrainerEntity>>([]);
  final editingKey = signal<NpcTrainerKey?>(null);
  final selectedKey = signal<NpcTrainerKey?>(null);
  final page = signal(1);
  final total = signal(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

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
  int _interactionToken = 0;

  Future<void> initSignals({required int parentKey}) =>
      setParentKey(parentKey);

  Future<void> setParentKey(int parentKey) async {
    _interactionToken++;
    if (this.parentKey.value != parentKey) page.value = 1;
    this.parentKey.value = parentKey;
    final parent = parentKey;
    editingKey.value = null;
    selectedKey.value = null;
    _applyCandidate(NpcTrainerEntity(trainerId: parent));
    await _refresh();
  }

  Future<void> create() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createNpcTrainer(parent);
      if (token != _interactionToken || parentKey.value != parent) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    }
  }

  Future<void> edit(NpcTrainerKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getNpcTrainer(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      if (candidate == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      editingKey.value = null;
      errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _interactionToken) loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final candidate = _collectCandidate();
    validateNpcTrainerFields(candidate);
    final originalKey = editingKey.value;
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeNpcTrainer(candidate);
      } else {
        await _repository.updateNpcTrainer(originalKey, candidate);
      }
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(NpcTrainerKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyNpcTrainer(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> paginate(int page) async {
    _interactionToken++;
    this.page.value = page;
    await _refresh();
  }

  NpcTrainerEntity _collectCandidate() {
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

  void _applyCandidate(NpcTrainerEntity trainer) {
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
    final parent = parentKey.value;
    if (parent == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countNpcTrainers(parent);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefNpcTrainers(parent, page: nextPage);
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      editingKey.value = null;
      selectedKey.value = null;
    } catch (error) {
      if (token == _refreshToken) errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() => disposeControllers();

  void clearParent() {
    ++_refreshToken;
    parentKey.value = null;
    items.value = const [];
    editingKey.value = null;
    selectedKey.value = null;
    page.value = 1;
    total.value = 0;
    loading.value = false;
    errorMessage.value = null;
    _applyCandidate(const NpcTrainerEntity());
  }
}
