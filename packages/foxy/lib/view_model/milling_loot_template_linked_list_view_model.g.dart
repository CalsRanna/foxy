// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milling_loot_template_linked_list_view_model.dart';

mixin _MillingLootTemplateLinkedListViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<MillingLootTemplateRepository>();

  final linkKey = signal<int?>(null);

  final items = signal(<BriefMillingLootTemplateEntity>[]);

  final editingKey = signal<MillingLootTemplateKey?>(null);

  final selectedKey = signal<MillingLootTemplateKey?>(null);

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

  void _afterApplyCandidate(MillingLootTemplateEntity millingLootTemplate) {}

  void _applyCandidate(MillingLootTemplateEntity millingLootTemplate) {
    entryController.init(millingLootTemplate.entry);
    itemController.init(millingLootTemplate.item);
    referenceController.init(millingLootTemplate.reference);
    chanceController.init(millingLootTemplate.chance);
    questRequiredController.init(millingLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(millingLootTemplate.lootMode);
    groupIdController.init(millingLootTemplate.groupId);
    minCountController.init(millingLootTemplate.minCount);
    maxCountController.init(millingLootTemplate.maxCount);
    commentController.init(millingLootTemplate.comment);
    _afterApplyCandidate(millingLootTemplate);
  }

  MillingLootTemplateEntity _collectCandidate() {
    return MillingLootTemplateEntity(
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

  Future<void> copy(MillingLootTemplateKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyMillingLootTemplate(key);
      if (token != _interactionToken || linkKey.value != link) return;
      try {
        await _logActivity(ActivityActionType.copy, key);
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> create() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createMillingLootTemplate(link);
      if (token != _interactionToken || linkKey.value != link) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    }
  }

  Future<void> destroy(MillingLootTemplateKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      final record = await _repository.getMillingLootTemplate(key);
      await _repository.destroyMillingLootTemplate(key);
      if (token != _interactionToken || linkKey.value != link) return;
      try {
        await _logActivity(ActivityActionType.delete, key, record);
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() => disposeControllers();

  Future<void> edit(MillingLootTemplateKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getMillingLootTemplate(key);
      if (token != _interactionToken || linkKey.value != link) return;
      if (candidate == null) {
        throw RecordNotFoundException('record not found');
      }
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      editingKey.value = null;
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      if (token == _interactionToken) loading.value = false;
    }
  }

  Future<void> initSignals({required int linkKey}) => setLinkKey(linkKey);

  Future<void> paginate(int page) async {
    _interactionToken++;
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final candidate = _collectCandidate();
    final originalKey = editingKey.value;
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeMillingLootTemplate(candidate);
      } else {
        await _repository.updateMillingLootTemplate(originalKey, candidate);
      }
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        await _logActivity(
          action,
          originalKey ?? MillingLootTemplateKey.fromEntity(candidate),
        );
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      if (token != _interactionToken || linkKey.value != link) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> setLinkKey(int linkKey) async {
    _interactionToken++;
    if (this.linkKey.value != linkKey) page.value = 1;
    this.linkKey.value = linkKey;
    final link = linkKey;
    editingKey.value = null;
    selectedKey.value = null;
    _applyCandidate(MillingLootTemplateEntity(entry: link));
    await _refresh();
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect. The default resolves the
  /// record's name from the database via the generated query layer
  /// (pass [record] to skip the lookup, e.g. after a delete); override
  /// in the hand-written class when the business log content differs.
  Future<void> _logActivity(
    ActivityActionType action,
    MillingLootTemplateKey key, [
    MillingLootTemplateEntity? record,
  ]) async {
    final resolved = record ?? await _repository.getMillingLootTemplate(key);
    final entityName = resolved == null
        ? key.toString()
        : resolved.comment.isNotEmpty
        ? resolved.comment
        : key.toString();
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'milling_loot_template',
          actionType: action,
          entityName: entityName,
          createdAt: DateTime.now(),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    final link = linkKey.value;
    if (link == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countMillingLootTemplates(link);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefMillingLootTemplates(
        link,
        page: nextPage,
      );
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      editingKey.value = null;
      selectedKey.value = null;
    } catch (error) {
      if (token == _refreshToken) {
        errorMessage.value = FoxyExceptions.message(error);
        LoggerUtil.instance.e('刷新子表列表失败: $error');
      }
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
