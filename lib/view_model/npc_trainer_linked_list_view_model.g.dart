// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_trainer_linked_list_view_model.dart';

mixin _NpcTrainerLinkedListViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<NpcTrainerRepository>();

  final linkKey = signal<int?>(null);

  final items = signal(<BriefNpcTrainerEntity>[]);

  final editingKey = signal<NpcTrainerKey?>(null);

  final selectedKey = signal<NpcTrainerKey?>(null);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final trainerIdController = registerController(IntFieldController());
  late final spellIdController = registerController(IntFieldController());
  late final moneyCostController = registerController(IntFieldController());
  late final reqSkillLineController = registerController(IntFieldController());
  late final reqSkillRankController = registerController(IntFieldController());
  late final reqAbility1Controller = registerController(IntFieldController());
  late final reqAbility2Controller = registerController(IntFieldController());
  late final reqAbility3Controller = registerController(IntFieldController());
  late final reqLevelController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void _afterApplyCandidate(NpcTrainerEntity npcTrainer) {}

  void _applyCandidate(NpcTrainerEntity npcTrainer) {
    trainerIdController.init(npcTrainer.trainerId);
    spellIdController.init(npcTrainer.spellId);
    moneyCostController.init(npcTrainer.moneyCost);
    reqSkillLineController.init(npcTrainer.reqSkillLine);
    reqSkillRankController.init(npcTrainer.reqSkillRank);
    reqAbility1Controller.init(npcTrainer.reqAbility1);
    reqAbility2Controller.init(npcTrainer.reqAbility2);
    reqAbility3Controller.init(npcTrainer.reqAbility3);
    reqLevelController.init(npcTrainer.reqLevel);
    verifiedBuildController.init(npcTrainer.verifiedBuild);
    _afterApplyCandidate(npcTrainer);
  }

  NpcTrainerEntity _collectCandidate() {
    return NpcTrainerEntity(
      trainerId: trainerIdController.collect(),
      spellId: spellIdController.collect(),
      moneyCost: moneyCostController.collect(),
      reqSkillLine: reqSkillLineController.collect(),
      reqSkillRank: reqSkillRankController.collect(),
      reqAbility1: reqAbility1Controller.collect(),
      reqAbility2: reqAbility2Controller.collect(),
      reqAbility3: reqAbility3Controller.collect(),
      reqLevel: reqLevelController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  int _refreshToken = 0;
  int _interactionToken = 0;

  Future<void> copy(NpcTrainerKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyNpcTrainer(key);
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
      final candidate = await _repository.createNpcTrainer(link);
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

  Future<void> destroy(NpcTrainerKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyNpcTrainer(key);
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

  Future<void> edit(NpcTrainerKey key) async {
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
      final candidate = await _repository.getNpcTrainer(key);
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
        await _repository.storeNpcTrainer(candidate);
      } else {
        await _repository.updateNpcTrainer(originalKey, candidate);
      }
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        _logActivity(
          action,
          originalKey ?? NpcTrainerKey.fromEntity(candidate),
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
    _applyCandidate(NpcTrainerEntity(trainerId: link));
    await _refresh();
  }

  /// Override point: records child-table row add/update/copy/delete
  /// activity log.
  void _logActivity(ActivityActionType action, NpcTrainerKey key) {}

  Future<void> _refresh() async {
    final link = linkKey.value;
    if (link == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countNpcTrainers(link);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefNpcTrainers(link, page: nextPage);
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
