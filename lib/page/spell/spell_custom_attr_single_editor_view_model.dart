import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_custom_attr_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/spell_custom_attr_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SpellCustomAttrSingleEditorViewModel
    with
        ViewModelValidationMixin,
        SpellCustomAttrValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellCustomAttrRepository>();

  final parentKey = signal<int?>(null);
  final editingKey = signal<int?>(null);
  final entity = signal<SpellCustomAttrEntity?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final spellIdController = registerController(IntFieldController());
  late final attributesController = registerController(FlagFieldController());

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
    validateSpellCustomAttrFields(candidate);
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeSpellCustomAttr(candidate);
      } else {
        await _repository.updateSpellCustomAttr(originalKey, candidate);
      }
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.spellId;
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
      await _repository.destroySpellCustomAttr(key);
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

SpellCustomAttrEntity _collectCandidate() {
    return SpellCustomAttrEntity(
      spellId: spellIdController.collect(),
      attributes: attributesController.collect(),
    );
  }

void _applyCandidate(SpellCustomAttrEntity data) {
    spellIdController.init(data.spellId);
    attributesController.init(data.attributes);
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
      final existing = await _repository.getSpellCustomAttr(parentSnapshot);
      if (token != _refreshToken) return;
      final candidate =
          existing ?? await _repository.createSpellCustomAttr(parentSnapshot);
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
