// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_custom_attr_linked_detail_view_model.dart';

mixin _SpellCustomAttrLinkedDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellCustomAttrRepository>();

  final linkKey = signal<int?>(null);

  final editingKey = signal<int?>(null);

  final entity = signal<SpellCustomAttrEntity?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final spellIdController = registerController(IntFieldController());
  late final attributesController = registerController(FlagFieldController());

  void _afterApplyCandidate(SpellCustomAttrEntity spellCustomAttr) {}

  void _applyCandidate(SpellCustomAttrEntity spellCustomAttr) {
    spellIdController.init(spellCustomAttr.spellId);
    attributesController.init(spellCustomAttr.attributes);
    _afterApplyCandidate(spellCustomAttr);
  }

  SpellCustomAttrEntity _collectCandidate() {
    return SpellCustomAttrEntity(
      spellId: spellIdController.collect(),
      attributes: attributesController.collect(),
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
      await _repository.destroySpellCustomAttr(key);
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      try {
        _logActivity(ActivityActionType.delete, key);
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
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
        await _repository.storeSpellCustomAttr(candidate);
      } else {
        await _repository.updateSpellCustomAttr(originalKey, candidate);
      }
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.spellId;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        _logActivity(action, originalKey ?? candidate.spellId);
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
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

  /// Override point: records child-table row add/update/delete activity
  /// log.
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
      final existing = await _repository.getSpellCustomAttr(linkSnapshot);
      if (token != _refreshToken || isDisposed) return;
      final candidate =
          existing ?? await _repository.createSpellCustomAttr(linkSnapshot);
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
