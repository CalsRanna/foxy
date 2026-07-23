import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_template_addon_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/creature_template_addon_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class CreatureTemplateAddonSingleEditorViewModel
    with
        ViewModelValidationMixin,
        CreatureTemplateAddonValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<CreatureTemplateAddonRepository>();

  final parentKey = signal<int?>(null);
  final editingKey = signal<int?>(null);
  final entity = signal<CreatureTemplateAddonEntity?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final creatureIdController = registerController(IntFieldController());
  late final pathIdController = registerController(IntFieldController());
  late final mountController = registerController(IntFieldController());
  late final emoteController = registerController(IntFieldController());
  late final bytes1Controller = registerController(IntFieldController());
  late final bytes2Controller = registerController(IntFieldController());
  late final visibilityDistanceTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final aurasController = registerController(StringFieldController());

  int _refreshToken = 0;
  int _parentToken = 0;
  /// 初始化 ViewModel
  /// 退出页面
  /// 保存数据到数据库
  /// 从 Controller 收集数据构建 CreatureTemplateAddon

  /// 初始化 Controller 的值

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
    validateCreatureTemplateAddonFields(candidate);
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeCreatureTemplateAddon(candidate);
      } else {
        await _repository.updateCreatureTemplateAddon(originalKey, candidate);
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
      await _repository.destroyCreatureTemplateAddon(key);
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

CreatureTemplateAddonEntity _collectCandidate() {
    return CreatureTemplateAddonEntity(
      entry: creatureIdController.collect(),
      pathId: pathIdController.collect(),
      mount: mountController.collect(),
      emote: emoteController.collect(),
      bytes1: bytes1Controller.collect(),
      bytes2: bytes2Controller.collect(),
      visibilityDistanceType: visibilityDistanceTypeController.collect(),
      auras: normalizeCreatureTemplateAddonAuras(aurasController.collect()),
    );
  }

void _applyCandidate(CreatureTemplateAddonEntity data) {
    creatureIdController.init(data.entry);
    pathIdController.init(data.pathId);
    mountController.init(data.mount);
    emoteController.init(data.emote);
    bytes1Controller.init(data.bytes1);
    bytes2Controller.init(data.bytes2);
    visibilityDistanceTypeController.init(data.visibilityDistanceType);
    aurasController.init(data.auras);
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
      final existing = await _repository.getCreatureTemplateAddon(
        parentSnapshot,
      );
      if (token != _refreshToken) return;
      final candidate =
          existing ??
          await _repository.createCreatureTemplateAddon(parentSnapshot);
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

  /// 清理资源
  void dispose() {
    disposeControllers();
  }
}
