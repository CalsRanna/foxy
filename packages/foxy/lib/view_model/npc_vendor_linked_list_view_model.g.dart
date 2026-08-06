// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_vendor_linked_list_view_model.dart';

mixin _NpcVendorLinkedListViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<NpcVendorRepository>();

  final linkKey = signal<int?>(null);

  final items = signal(<BriefNpcVendorEntity>[]);

  final editingKey = signal<NpcVendorKey?>(null);

  final selectedKey = signal<NpcVendorKey?>(null);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final entryController = registerController(IntFieldController());
  late final slotController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final maxcountController = registerController(IntFieldController());
  late final incrtimeController = registerController(IntFieldController());
  late final extendedCostController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void _afterApplyCandidate(NpcVendorEntity npcVendor) {}

  void _applyCandidate(NpcVendorEntity npcVendor) {
    entryController.init(npcVendor.entry);
    slotController.init(npcVendor.slot);
    itemController.init(npcVendor.item);
    maxcountController.init(npcVendor.maxcount);
    incrtimeController.init(npcVendor.incrtime);
    extendedCostController.init(npcVendor.extendedCost);
    verifiedBuildController.init(npcVendor.verifiedBuild);
    _afterApplyCandidate(npcVendor);
  }

  NpcVendorEntity _collectCandidate() {
    return NpcVendorEntity(
      entry: entryController.collect(),
      slot: slotController.collect(),
      item: itemController.collect(),
      maxcount: maxcountController.collect(),
      incrtime: incrtimeController.collect(),
      extendedCost: extendedCostController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  int _refreshToken = 0;
  int _interactionToken = 0;

  Future<void> copy(NpcVendorKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyNpcVendor(key);
      if (token != _interactionToken || linkKey.value != link) return;
      try {
        _logActivity(ActivityActionType.copy, key);
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
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
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createNpcVendor(link);
      if (token != _interactionToken || linkKey.value != link) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    }
  }

  Future<void> destroy(NpcVendorKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyNpcVendor(key);
      if (token != _interactionToken || linkKey.value != link) return;
      try {
        _logActivity(ActivityActionType.delete, key);
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() => disposeControllers();

  Future<void> edit(NpcVendorKey key) async {
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
      final candidate = await _repository.getNpcVendor(key);
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
      errorMessage.value = foxyErrorMessage(error);
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
        await _repository.storeNpcVendor(candidate);
      } else {
        await _repository.updateNpcVendor(originalKey, candidate);
      }
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        _logActivity(action, originalKey ?? NpcVendorKey.fromEntity(candidate));
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
      errorMessage.value = foxyErrorMessage(error);
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
    _applyCandidate(NpcVendorEntity(entry: link));
    await _refresh();
  }

  /// Override point: records child-table row add/update/copy/delete
  /// activity log.
  void _logActivity(ActivityActionType action, NpcVendorKey key) {}

  Future<void> _refresh() async {
    final link = linkKey.value;
    if (link == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countNpcVendors(link);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefNpcVendors(link, page: nextPage);
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      editingKey.value = null;
      selectedKey.value = null;
    } catch (error) {
      if (token == _refreshToken) {
        errorMessage.value = foxyErrorMessage(error);
        LoggerUtil.instance.e('刷新子表列表失败: $error');
      }
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
