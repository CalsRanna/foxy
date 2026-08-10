// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_line_ability_linked_list_view_model.dart';

mixin _SkillLineAbilityLinkedListViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<SkillLineAbilityRepository>();

  final linkKey = signal<int?>(null);

  final items = signal(<BriefSkillLineAbilityEntity>[]);

  final editingKey = signal<SkillLineAbilityKey?>(null);

  final selectedKey = signal<SkillLineAbilityKey?>(null);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final skillLineController = registerController(IntFieldController());
  late final spellController = registerController(IntFieldController());
  late final raceMaskController = registerController(IntFieldController());
  late final classMaskController = registerController(IntFieldController());
  late final excludeRaceController = registerController(IntFieldController());
  late final excludeClassController = registerController(IntFieldController());
  late final minSkillLineRankController = registerController(
    IntFieldController(),
  );
  late final supercededBySpellController = registerController(
    IntFieldController(),
  );
  late final acquireMethodController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final trivialSkillLineRankHighController = registerController(
    IntFieldController(),
  );
  late final trivialSkillLineRankLowController = registerController(
    IntFieldController(),
  );
  late final characterPoints0Controller = registerController(
    IntFieldController(),
  );
  late final characterPoints1Controller = registerController(
    IntFieldController(),
  );

  void _afterApplyCandidate(SkillLineAbilityEntity skillLineAbility) {}

  void _applyCandidate(SkillLineAbilityEntity skillLineAbility) {
    idController.init(skillLineAbility.id);
    skillLineController.init(skillLineAbility.skillLine);
    spellController.init(skillLineAbility.spell);
    raceMaskController.init(skillLineAbility.raceMask);
    classMaskController.init(skillLineAbility.classMask);
    excludeRaceController.init(skillLineAbility.excludeRace);
    excludeClassController.init(skillLineAbility.excludeClass);
    minSkillLineRankController.init(skillLineAbility.minSkillLineRank);
    supercededBySpellController.init(skillLineAbility.supercededBySpell);
    acquireMethodController.init(skillLineAbility.acquireMethod);
    trivialSkillLineRankHighController.init(
      skillLineAbility.trivialSkillLineRankHigh,
    );
    trivialSkillLineRankLowController.init(
      skillLineAbility.trivialSkillLineRankLow,
    );
    characterPoints0Controller.init(skillLineAbility.characterPoints0);
    characterPoints1Controller.init(skillLineAbility.characterPoints1);
    _afterApplyCandidate(skillLineAbility);
  }

  SkillLineAbilityEntity _collectCandidate() {
    return SkillLineAbilityEntity(
      id: idController.collect(),
      skillLine: skillLineController.collect(),
      spell: spellController.collect(),
      raceMask: raceMaskController.collect(),
      classMask: classMaskController.collect(),
      excludeRace: excludeRaceController.collect(),
      excludeClass: excludeClassController.collect(),
      minSkillLineRank: minSkillLineRankController.collect(),
      supercededBySpell: supercededBySpellController.collect(),
      acquireMethod: acquireMethodController.collect(),
      trivialSkillLineRankHigh: trivialSkillLineRankHighController.collect(),
      trivialSkillLineRankLow: trivialSkillLineRankLowController.collect(),
      characterPoints0: characterPoints0Controller.collect(),
      characterPoints1: characterPoints1Controller.collect(),
    );
  }

  int _refreshToken = 0;
  int _interactionToken = 0;

  Future<void> copy(SkillLineAbilityKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copySkillLineAbility(key);
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
      errorMessage.value = FoxyError.message(error);
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
      final candidate = await _repository.createSkillLineAbility(link);
      if (token != _interactionToken || linkKey.value != link) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyError.message(error);
      rethrow;
    }
  }

  Future<void> destroy(SkillLineAbilityKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroySkillLineAbility(key);
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
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() => disposeControllers();

  Future<void> edit(SkillLineAbilityKey key) async {
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
      final candidate = await _repository.getSkillLineAbility(key);
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
      errorMessage.value = FoxyError.message(error);
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
        await _repository.storeSkillLineAbility(candidate);
      } else {
        await _repository.updateSkillLineAbility(originalKey, candidate);
      }
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        _logActivity(
          action,
          originalKey ?? SkillLineAbilityKey.fromEntity(candidate),
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
      errorMessage.value = FoxyError.message(error);
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
    _applyCandidate(SkillLineAbilityEntity(skillLine: link));
    await _refresh();
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(ActivityActionType action, SkillLineAbilityKey key) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_skill_line_ability',
          actionType: action,
          entityName: key.toString(),
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
      final count = await _repository.countSkillLineAbilities(link);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefSkillLineAbilities(
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
        errorMessage.value = FoxyError.message(error);
        LoggerUtil.instance.e('刷新子表列表失败: $error');
      }
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
