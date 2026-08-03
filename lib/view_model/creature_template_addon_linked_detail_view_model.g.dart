// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_addon_linked_detail_view_model.dart';

mixin _CreatureTemplateAddonLinkedDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<CreatureTemplateAddonRepository>();

  final linkKey = signal<int?>(null);

  final editingKey = signal<int?>(null);

  final entity = signal<CreatureTemplateAddonEntity?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final entryController = registerController(IntFieldController());
  late final pathIdController = registerController(IntFieldController());
  late final mountController = registerController(IntFieldController());
  late final emoteController = registerController(IntFieldController());
  late final bytes1Controller = registerController(IntFieldController());
  late final bytes2Controller = registerController(IntFieldController());
  late final visibilityDistanceTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final aurasController = registerController(StringFieldController());

  void _afterApplyCandidate(
    CreatureTemplateAddonEntity creatureTemplateAddon,
  ) {}

  void _applyCandidate(CreatureTemplateAddonEntity creatureTemplateAddon) {
    entryController.init(creatureTemplateAddon.entry);
    pathIdController.init(creatureTemplateAddon.pathId);
    mountController.init(creatureTemplateAddon.mount);
    emoteController.init(creatureTemplateAddon.emote);
    bytes1Controller.init(creatureTemplateAddon.bytes1);
    bytes2Controller.init(creatureTemplateAddon.bytes2);
    visibilityDistanceTypeController.init(
      creatureTemplateAddon.visibilityDistanceType,
    );
    aurasController.init(creatureTemplateAddon.auras);
    _afterApplyCandidate(creatureTemplateAddon);
  }

  CreatureTemplateAddonEntity _collectCandidate() {
    return CreatureTemplateAddonEntity(
      entry: entryController.collect(),
      pathId: pathIdController.collect(),
      mount: mountController.collect(),
      emote: emoteController.collect(),
      bytes1: bytes1Controller.collect(),
      bytes2: bytes2Controller.collect(),
      visibilityDistanceType: visibilityDistanceTypeController.collect(),
      auras: aurasController.collect(),
    );
  }

  int _refreshToken = 0;
  int _linkToken = 0;

  Future<void> destroy() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final key = editingKey.value;
    if (key == null) return;
    final linkSnapshot = linkKey.value;
    final linkToken = _linkToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyCreatureTemplateAddon(key);
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      try {
        _logActivity(ActivityActionType.delete, key);
      } catch (_) {
        // 活动日志 best-effort,失败(如测试环境未注册)不影响主流程。
      }
      editingKey.value = null;
      await _refresh();
    } catch (error) {
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({required int linkKey}) {
    return setLinkKey(linkKey);
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final linkSnapshot = linkKey.value;
    if (linkSnapshot == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final linkToken = _linkToken;
    final candidate = _collectCandidate();
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeCreatureTemplateAddon(candidate);
      } else {
        await _repository.updateCreatureTemplateAddon(originalKey, candidate);
      }
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.entry;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        _logActivity(action, originalKey ?? candidate.entry);
      } catch (_) {
        // 活动日志 best-effort,失败(如测试环境未注册)不影响主流程。
      }
      await _refresh();
    } catch (error) {
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> setLinkKey(int linkKey) async {
    if (this.linkKey.value == linkKey && entity.value != null) return;
    _linkToken++;
    this.linkKey.value = linkKey;
    editingKey.value = null;
    await _refresh();
  }

  /// 覆写点:记录子表单行新增/更新/删除活动日志。
  void _logActivity(ActivityActionType action, int key) {}

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final linkSnapshot = linkKey.value;
    if (linkSnapshot == null) {
      entity.value = null;
      editingKey.value = null;
      return;
    }
    loading.value = true;
    errorMessage.value = null;
    try {
      final existing = await _repository.getCreatureTemplateAddon(linkSnapshot);
      if (token != _refreshToken || isDisposed) return;
      final candidate =
          existing ??
          await _repository.createCreatureTemplateAddon(linkSnapshot);
      if (token != _refreshToken || isDisposed) return;
      entity.value = candidate;
      editingKey.value = existing == null ? null : linkSnapshot;
      _applyCandidate(candidate);
    } catch (error, stackTrace) {
      if (token != _refreshToken || isDisposed) return;
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载单行编辑器失败', error: error, stackTrace: stackTrace);
    } finally {
      if (token == _refreshToken && !isDisposed) loading.value = false;
    }
  }
}
