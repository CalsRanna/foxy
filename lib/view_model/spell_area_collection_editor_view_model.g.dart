// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_area_collection_editor_view_model.dart';

mixin _SpellAreaCollectionEditorViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellAreaRepository>();

  final parentKey = signal<int?>(null);

  final items = signal(<BriefSpellAreaEntity>[]);

  final editingKey = signal<SpellAreaKey?>(null);

  final selectedKey = signal<SpellAreaKey?>(null);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final spellController = registerController(IntFieldController());
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

  void _afterApplyCandidate(SpellAreaEntity spellArea) {}

  void _applyCandidate(SpellAreaEntity spellArea) {
    spellController.init(spellArea.spell);
    areaController.init(spellArea.area);
    questStartController.init(spellArea.questStart);
    questEndController.init(spellArea.questEnd);
    auraSpellController.init(spellArea.auraSpell);
    racemaskController.init(spellArea.racemask);
    genderController.init(spellArea.gender);
    autocastController.init(spellArea.autocast);
    questStartStatusController.init(spellArea.questStartStatus);
    questEndStatusController.init(spellArea.questEndStatus);
    _afterApplyCandidate(spellArea);
  }

  SpellAreaEntity _collectCandidate() {
    return SpellAreaEntity(
      spell: spellController.collect(),
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
  }

  int _refreshToken = 0;
  int _interactionToken = 0;

  Future<void> copy(SpellAreaKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null) {
      throw ParentNotLoadedException('parent record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copySpellArea(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> create() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null) {
      throw ParentNotLoadedException('parent record not loaded');
    }
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
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    }
  }

  Future<void> destroy(SpellAreaKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null) {
      throw ParentNotLoadedException('parent record not loaded');
    }
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
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() => disposeControllers();

  Future<void> edit(SpellAreaKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null) {
      throw ParentNotLoadedException('parent record not loaded');
    }
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getSpellArea(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      if (candidate == null) {
        throw RecordNotFoundException('record not found');
      }
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      editingKey.value = null;
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      if (token == _interactionToken) loading.value = false;
    }
  }

  Future<void> initSignals({required int parentKey}) => setParentKey(parentKey);

  Future<void> paginate(int page) async {
    _interactionToken++;
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null) {
      throw ParentNotLoadedException('parent record not loaded');
    }
    final candidate = _collectCandidate();
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
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

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
      if (token == _refreshToken) errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
