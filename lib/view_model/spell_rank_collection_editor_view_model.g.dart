// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_rank_collection_editor_view_model.dart';

mixin _SpellRankCollectionEditorViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellRankRepository>();

  final parentKey = signal<int?>(null);

  final items = signal(<BriefSpellRankEntity>[]);

  final editingKey = signal<SpellRankKey?>(null);

  final selectedKey = signal<SpellRankKey?>(null);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final firstSpellIdController = registerController(IntFieldController());
  late final spellIdController = registerController(IntFieldController());
  late final rankController = registerController(IntFieldController());

  void _afterApplyCandidate(SpellRankEntity spellRank) {}

  void _applyCandidate(SpellRankEntity spellRank) {
    firstSpellIdController.init(spellRank.firstSpellId);
    spellIdController.init(spellRank.spellId);
    rankController.init(spellRank.rank);
    _afterApplyCandidate(spellRank);
  }

  SpellRankEntity _collectCandidate() {
    return SpellRankEntity(
      firstSpellId: firstSpellIdController.collect(),
      spellId: spellIdController.collect(),
      rank: rankController.collect(),
    );
  }

  int _refreshToken = 0;
  int _interactionToken = 0;

  Future<void> copy(SpellRankKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null) {
      throw ParentNotLoadedException('parent record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copySpellRank(key);
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
      final candidate = await _repository.createSpellRank(parent);
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

  Future<void> destroy(SpellRankKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null) {
      throw ParentNotLoadedException('parent record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroySpellRank(key);
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

  Future<void> edit(SpellRankKey key) async {
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
      final candidate = await _repository.getSpellRank(key);
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
        await _repository.storeSpellRank(candidate);
      } else {
        await _repository.updateSpellRank(originalKey, candidate);
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
    _applyCandidate(SpellRankEntity(firstSpellId: parent));
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
      final count = await _repository.countSpellRanks(parent);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefSpellRanks(parent, page: nextPage);
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
