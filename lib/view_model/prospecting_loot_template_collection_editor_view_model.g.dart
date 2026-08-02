// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prospecting_loot_template_collection_editor_view_model.dart';

mixin _ProspectingLootTemplateCollectionEditorViewModelMixin
    on FieldControllerMixin {
  final _repository = GetIt.instance.get<ProspectingLootTemplateRepository>();

  final parentKey = signal<int?>(null);

  final items = signal(<BriefProspectingLootTemplateEntity>[]);

  final editingKey = signal<ProspectingLootTemplateKey?>(null);

  final selectedKey = signal<ProspectingLootTemplateKey?>(null);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final entryController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final referenceController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());
  late final questRequiredController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final lootModeController = registerController(FlagFieldController());
  late final groupIdController = registerController(IntFieldController());
  late final minCountController = registerController(IntFieldController());
  late final maxCountController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  void _afterApplyCandidate(
    ProspectingLootTemplateEntity prospectingLootTemplate,
  ) {}

  void _applyCandidate(ProspectingLootTemplateEntity prospectingLootTemplate) {
    entryController.init(prospectingLootTemplate.entry);
    itemController.init(prospectingLootTemplate.item);
    referenceController.init(prospectingLootTemplate.reference);
    chanceController.init(prospectingLootTemplate.chance);
    questRequiredController.init(prospectingLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(prospectingLootTemplate.lootMode);
    groupIdController.init(prospectingLootTemplate.groupId);
    minCountController.init(prospectingLootTemplate.minCount);
    maxCountController.init(prospectingLootTemplate.maxCount);
    commentController.init(prospectingLootTemplate.comment);
    _afterApplyCandidate(prospectingLootTemplate);
  }

  ProspectingLootTemplateEntity _collectCandidate() {
    return ProspectingLootTemplateEntity(
      entry: entryController.collect(),
      item: itemController.collect(),
      reference: referenceController.collect(),
      chance: chanceController.collect(),
      questRequired: questRequiredController.collect() == 1,
      lootMode: lootModeController.collect(),
      groupId: groupIdController.collect(),
      minCount: minCountController.collect(),
      maxCount: maxCountController.collect(),
      comment: commentController.collect(),
    );
  }

  int _refreshToken = 0;
  int _interactionToken = 0;

  Future<void> copy(ProspectingLootTemplateKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null)
      throw ParentNotLoadedException('parent record not loaded');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyProspectingLootTemplate(key);
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
    if (parent == null)
      throw ParentNotLoadedException('parent record not loaded');
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createProspectingLootTemplate(parent);
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

  Future<void> destroy(ProspectingLootTemplateKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null)
      throw ParentNotLoadedException('parent record not loaded');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyProspectingLootTemplate(key);
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

  Future<void> edit(ProspectingLootTemplateKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null)
      throw ParentNotLoadedException('parent record not loaded');
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getProspectingLootTemplate(key);
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
    if (parent == null)
      throw ParentNotLoadedException('parent record not loaded');
    final candidate = _collectCandidate();
    final originalKey = editingKey.value;
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeProspectingLootTemplate(candidate);
      } else {
        await _repository.updateProspectingLootTemplate(originalKey, candidate);
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
    _applyCandidate(ProspectingLootTemplateEntity(entry: parent));
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
      final count = await _repository.countProspectingLootTemplates(parent);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefProspectingLootTemplates(
        parent,
        page: nextPage,
      );
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
