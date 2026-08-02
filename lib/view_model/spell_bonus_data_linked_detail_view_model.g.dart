// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_bonus_data_linked_detail_view_model.dart';

mixin _SpellBonusDataLinkedDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellBonusDataRepository>();

  final linkKey = signal<int?>(null);

  final editingKey = signal<int?>(null);

  final entity = signal<SpellBonusDataEntity?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final entryController = registerController(IntFieldController());
  late final directBonusController = registerController(
    DoubleFieldController(),
  );
  late final dotBonusController = registerController(DoubleFieldController());
  late final apBonusController = registerController(DoubleFieldController());
  late final apDotBonusController = registerController(DoubleFieldController());
  late final commentsController = registerController(StringFieldController());

  void _afterApplyCandidate(SpellBonusDataEntity spellBonusData) {}

  void _applyCandidate(SpellBonusDataEntity spellBonusData) {
    entryController.init(spellBonusData.entry);
    directBonusController.init(spellBonusData.directBonus);
    dotBonusController.init(spellBonusData.dotBonus);
    apBonusController.init(spellBonusData.apBonus);
    apDotBonusController.init(spellBonusData.apDotBonus);
    commentsController.init(spellBonusData.comments);
    _afterApplyCandidate(spellBonusData);
  }

  SpellBonusDataEntity _collectCandidate() {
    return SpellBonusDataEntity(
      entry: entryController.collect(),
      directBonus: directBonusController.collect(),
      dotBonus: dotBonusController.collect(),
      apBonus: apBonusController.collect(),
      apDotBonus: apDotBonusController.collect(),
      comments: commentsController.collect(),
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
      await _repository.destroySpellBonusData(key);
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
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
        await _repository.storeSpellBonusData(candidate);
      } else {
        await _repository.updateSpellBonusData(originalKey, candidate);
      }
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.entry;
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
      final existing = await _repository.getSpellBonusData(linkSnapshot);
      if (token != _refreshToken) return;
      final candidate =
          existing ?? await _repository.createSpellBonusData(linkSnapshot);
      if (token != _refreshToken) return;
      entity.value = candidate;
      editingKey.value = existing == null ? null : linkSnapshot;
      _applyCandidate(candidate);
    } catch (error, stackTrace) {
      if (token != _refreshToken) return;
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载单行编辑器失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
