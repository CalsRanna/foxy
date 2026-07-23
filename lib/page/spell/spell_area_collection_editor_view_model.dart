import 'dart:math';
import 'package:foxy/entity/brief_spell_area_entity.dart';
import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/entity/spell_area_key.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/spell_area_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SpellAreaCollectionEditorViewModel
    with
        ViewModelValidationMixin,
        SpellAreaValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellAreaRepository>();

  final parentKey = signal<int?>(null);
  final items = signal<List<BriefSpellAreaEntity>>([]);
  final editingKey = signal<SpellAreaKey?>(null);
  final selectedKey = signal<SpellAreaKey?>(null);
  final page = signal(1);
  final total = signal(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final spellIdController = registerController(IntFieldController());
  late final areaController = registerController(IntFieldController());
  late final questStartController = registerController(IntFieldController());
  late final questEndController = registerController(IntFieldController());
  late final auraSpellController = registerController(IntFieldController());
  late final racemaskController = registerController(FlagFieldController());
  late final genderController = registerController(
    SelectFieldController<int>(fallback: 2),
  );
  late final autocastController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final questStartStatusController = registerController(
    FlagFieldController(),
  );
  late final questEndStatusController = registerController(
    FlagFieldController(),
  );

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
    _applyCandidate(SpellAreaEntity(spell: parent));
    await _refresh();
  }

  Future<void> create() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createSpellArea(parent);
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

  Future<void> edit(SpellAreaKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getSpellArea(key);
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
    validateSpellAreaFields(candidate);
    final originalKey = editingKey.value;
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeSpellArea(candidate);
      } else {
        await _repository.updateSpellArea(originalKey, candidate);
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

  Future<void> destroy(SpellAreaKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroySpellArea(key);
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

  SpellAreaEntity _collectCandidate() => SpellAreaEntity(
    spell: spellIdController.collect(),
    area: areaController.collect(),
    questStart: questStartController.collect(),
    questEnd: questEndController.collect(),
    auraSpell: auraSpellController.collect(),
    racemask: racemaskController.collect(),
    gender: genderController.collect(),
    autocast: autocastController.collect(),
    questStartStatus: questStartStatusController.collect(),
    questEndStatus: questEndStatusController.collect(),
  );

  void _applyCandidate(SpellAreaEntity data) {
    spellIdController.init(data.spell);
    areaController.init(data.area);
    questStartController.init(data.questStart);
    questEndController.init(data.questEnd);
    auraSpellController.init(data.auraSpell);
    racemaskController.init(data.racemask);
    genderController.init(data.gender);
    autocastController.init(data.autocast);
    questStartStatusController.init(data.questStartStatus);
    questEndStatusController.init(data.questEndStatus);
  }

  Future<void> _refresh() async {
    final parent = parentKey.value;
    if (parent == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countSpellAreas(parent);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefSpellAreas(parent, page: nextPage);
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
}
