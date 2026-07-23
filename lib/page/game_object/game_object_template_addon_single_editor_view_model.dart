import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/game_object_template_addon_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/game_object_template_addon_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GameObjectTemplateAddonSingleEditorViewModel
    with
        ViewModelValidationMixin,
        GameObjectTemplateAddonValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<GameObjectTemplateAddonRepository>();

  final parentKey = signal<int?>(null);
  final editingKey = signal<int?>(null);
  final entity = signal<GameObjectTemplateAddonEntity?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final factionController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final gameObjectIdController = registerController(IntFieldController());
  late final minGoldController = registerController(IntFieldController());
  late final maxGoldController = registerController(IntFieldController());
  late final artkit0Controller = registerController(IntFieldController());
  late final artkit1Controller = registerController(IntFieldController());
  late final artkit2Controller = registerController(IntFieldController());
  late final artkit3Controller = registerController(IntFieldController());

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
    validateGameObjectTemplateAddonFields(candidate);
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeGameObjectTemplateAddon(candidate);
      } else {
        await _repository.updateGameObjectTemplateAddon(originalKey, candidate);
      }
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.entry;
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
      await _repository.destroyGameObjectTemplateAddon(key);
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

GameObjectTemplateAddonEntity _collectCandidate() {
    return GameObjectTemplateAddonEntity(
      entry: gameObjectIdController.collect(),
      faction: factionController.collect(),
      flags: flagsController.collect(),
      minGold: minGoldController.collect(),
      maxGold: maxGoldController.collect(),
      artkit0: artkit0Controller.collect(),
      artkit1: artkit1Controller.collect(),
      artkit2: artkit2Controller.collect(),
      artkit3: artkit3Controller.collect(),
    );
  }

void _applyCandidate(GameObjectTemplateAddonEntity data) {
    gameObjectIdController.init(data.entry);
    factionController.init(data.faction);
    flagsController.init(data.flags);
    minGoldController.init(data.minGold);
    maxGoldController.init(data.maxGold);
    artkit0Controller.init(data.artkit0);
    artkit1Controller.init(data.artkit1);
    artkit2Controller.init(data.artkit2);
    artkit3Controller.init(data.artkit3);
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
      final existing = await _repository.getGameObjectTemplateAddon(
        parentSnapshot,
      );
      if (token != _refreshToken) return;
      final candidate =
          existing ??
          await _repository.createGameObjectTemplateAddon(parentSnapshot);
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

  void dispose() {
    disposeControllers();
  }
}
