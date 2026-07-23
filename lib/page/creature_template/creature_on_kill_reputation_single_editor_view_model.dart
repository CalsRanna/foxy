import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_on_kill_reputation_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/creature_on_kill_reputation_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class CreatureOnKillReputationSingleEditorViewModel
    with
        ViewModelValidationMixin,
        CreatureOnKillReputationValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<CreatureOnKillReputationRepository>();

  final parentKey = signal<int?>(null);
  final editingKey = signal<int?>(null);
  final entity = signal<CreatureOnKillReputationEntity?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final creatureIdController = registerController(IntFieldController());
  late final rewOnKillRepFaction1Controller = registerController(
    IntFieldController(),
  );
  late final rewOnKillRepFaction2Controller = registerController(
    IntFieldController(),
  );
  late final maxStanding1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final maxStanding2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final isTeamAward1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final isTeamAward2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final rewOnKillRepValue1Controller = registerController(
    DoubleFieldController(),
  );
  late final rewOnKillRepValue2Controller = registerController(
    DoubleFieldController(),
  );
  late final teamDependentController = registerController(
    SelectFieldController<int>(fallback: 0),
  );

  int _refreshToken = 0;
  int _parentToken = 0;

  Future<void> initSignals({required int parentKey}) {
    return setParentKey(parentKey);
  }

  Future<void> setParentKey(int parentKey) async {
    if (this.parentKey.value == parentKey && entity.value != null) return;
    _parentToken++;
    this.parentKey.value = parentKey;
    editingKey.value = null;
    await _refresh();
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    final parentSnapshot = parentKey.value;
    if (parentSnapshot == null) throw StateError('父记录尚未加载');
    final parentToken = _parentToken;
    final candidate = _collectCandidate();
    validateCreatureOnKillReputationFields(candidate);
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeCreatureOnKillReputation(candidate);
      } else {
        await _repository.updateCreatureOnKillReputation(
          originalKey,
          candidate,
        );
      }
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.creatureID;
      await _refresh();
    } catch (error) {
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final key = editingKey.value;
    if (key == null) return;
    final parentSnapshot = parentKey.value;
    final parentToken = _parentToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyCreatureOnKillReputation(key);
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      editingKey.value = null;
      await _refresh();
    } catch (error) {
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

CreatureOnKillReputationEntity _collectCandidate() {
    return CreatureOnKillReputationEntity(
      creatureID: creatureIdController.collect(),
      rewOnKillRepFaction1: rewOnKillRepFaction1Controller.collect(),
      rewOnKillRepFaction2: rewOnKillRepFaction2Controller.collect(),
      maxStanding1: maxStanding1Controller.collect(),
      maxStanding2: maxStanding2Controller.collect(),
      isTeamAward1: isTeamAward1Controller.collect() == 1,
      isTeamAward2: isTeamAward2Controller.collect() == 1,
      rewOnKillRepValue1: rewOnKillRepValue1Controller.collect(),
      rewOnKillRepValue2: rewOnKillRepValue2Controller.collect(),
      teamDependent: teamDependentController.collect(),
    );
  }

void _applyCandidate(CreatureOnKillReputationEntity data) {
    creatureIdController.init(data.creatureID);
    rewOnKillRepFaction1Controller.init(data.rewOnKillRepFaction1);
    rewOnKillRepFaction2Controller.init(data.rewOnKillRepFaction2);
    maxStanding1Controller.init(data.maxStanding1);
    maxStanding2Controller.init(data.maxStanding2);
    isTeamAward1Controller.init(data.isTeamAward1 ? 1 : 0);
    isTeamAward2Controller.init(data.isTeamAward2 ? 1 : 0);
    rewOnKillRepValue1Controller.init(data.rewOnKillRepValue1);
    rewOnKillRepValue2Controller.init(data.rewOnKillRepValue2);
    teamDependentController.init(data.teamDependent);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentSnapshot = parentKey.value;
    if (parentSnapshot == null) {
      entity.value = null;
      editingKey.value = null;
      return;
    }
    loading.value = true;
    errorMessage.value = null;
    try {
      final existing = await _repository.getCreatureOnKillReputation(
        parentSnapshot,
      );
      if (token != _refreshToken) return;
      final candidate =
          existing ??
          await _repository.createCreatureOnKillReputation(parentSnapshot);
      if (token != _refreshToken) return;
      entity.value = candidate;
      editingKey.value = existing == null ? null : parentSnapshot;
      _applyCandidate(candidate);
    } catch (error, stackTrace) {
      if (token != _refreshToken) return;
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载单行编辑器失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() => disposeControllers();
}
