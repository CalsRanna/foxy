import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/entity/creature_on_kill_reputation_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_on_kill_reputation_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/creature_on_kill_reputation_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureOnKillReputationViewModel
    with
        ViewModelValidationMixin,
        CreatureOnKillReputationValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<CreatureOnKillReputationRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final editingKey = signal<CreatureOnKillReputationKey?>(null);
  final parentCreatureID = signal(0);

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

  CreatureOnKillReputationEntity collectFromForm() {
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

  void dispose() => disposeControllers();

  Future<void> initSignals({required int creatureId}) async {
    try {
      await setParentCreatureID(creatureId);
    } catch (error) {
      LoggerUtil.instance.e('初始化击杀声望失败: $error');
      DialogUtil.instance.error('初始化击杀声望失败: $error');
    }
  }

  Future<void> load() => _refresh();

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateCreatureOnKillReputationFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeCreatureOnKillReputation(candidate);
    } else {
      await _repository.updateCreatureOnKillReputation(originalKey, candidate);
    }
    editingKey.value = CreatureOnKillReputationKey.fromEntity(candidate);
    await _refresh();
  }

  void pop() => routerFacade.goBack();

  Future<bool> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return true;
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('击杀声望数据已保存')));
      return true;
    } catch (error) {
      if (!context.mounted) return false;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
      return false;
    }
  }

  Future<void> setParentCreatureID(int creatureID) async {
    parentCreatureID.value = creatureID;
    editingKey.value = null;
    await _refresh();
  }

  void _initControllers(CreatureOnKillReputationEntity data) {
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
    final parentKey = CreatureOnKillReputationKey(
      creatureID: parentCreatureID.value,
    );
    final data = await _repository.getCreatureOnKillReputation(parentKey);
    if (data == null) {
      editingKey.value = null;
      _initControllers(
        CreatureOnKillReputationEntity(creatureID: parentCreatureID.value),
      );
      return;
    }
    editingKey.value = parentKey;
    _initControllers(data);
  }
}
