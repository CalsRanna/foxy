// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickpocketing_loot_template_collection_editor_view_model.dart';

mixin _PickpocketingLootTemplateCollectionEditorViewModelMixin
    on FieldControllerMixin {
  final _repository = GetIt.instance.get<PickpocketingLootTemplateRepository>();

  final parentKey = signal<int?>(null);

  final items = signal(<BriefPickpocketingLootTemplateEntity>[]);

  final editingKey = signal<PickpocketingLootTemplateKey?>(null);

  final selectedKey = signal<PickpocketingLootTemplateKey?>(null);

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
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) {}

  void _applyCandidate(
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) {
    entryController.init(pickpocketingLootTemplate.entry);
    itemController.init(pickpocketingLootTemplate.item);
    referenceController.init(pickpocketingLootTemplate.reference);
    chanceController.init(pickpocketingLootTemplate.chance);
    questRequiredController.init(
      pickpocketingLootTemplate.questRequired ? 1 : 0,
    );
    lootModeController.init(pickpocketingLootTemplate.lootMode);
    groupIdController.init(pickpocketingLootTemplate.groupId);
    minCountController.init(pickpocketingLootTemplate.minCount);
    maxCountController.init(pickpocketingLootTemplate.maxCount);
    commentController.init(pickpocketingLootTemplate.comment);
    _afterApplyCandidate(pickpocketingLootTemplate);
  }

  PickpocketingLootTemplateEntity _collectCandidate() {
    return PickpocketingLootTemplateEntity(
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

  Future<void> copy(PickpocketingLootTemplateKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null)
      throw ParentNotLoadedException('parent record not loaded');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyPickpocketingLootTemplate(key);
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
      final candidate = await _repository.createPickpocketingLootTemplate(
        parent,
      );
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

  Future<void> destroy(PickpocketingLootTemplateKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final parent = parentKey.value;
    if (parent == null)
      throw ParentNotLoadedException('parent record not loaded');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyPickpocketingLootTemplate(key);
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

  Future<void> edit(PickpocketingLootTemplateKey key) async {
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
      final candidate = await _repository.getPickpocketingLootTemplate(key);
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
        await _repository.storePickpocketingLootTemplate(candidate);
      } else {
        await _repository.updatePickpocketingLootTemplate(
          originalKey,
          candidate,
        );
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
    _applyCandidate(PickpocketingLootTemplateEntity(entry: parent));
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
      final count = await _repository.countPickpocketingLootTemplates(parent);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefPickpocketingLootTemplates(
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
