// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_list_view_model.dart';

mixin _AchievementListViewModelMixin
    on FieldControllerMixin, QueryVersionMixin {
  final _repository = GetIt.instance.get<AchievementRepository>();

  final items = signal(<BriefAchievementEntity>[]);

  @override
  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(StringFieldController());

  late final titleController = registerController(StringFieldController());

  int _refreshToken = 0;

  Future<void> copy(int key) async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyAchievement(key);
      await _logActivity(ActivityActionType.copy, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(int key) async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      final record = await _repository.getAchievement(key);
      await _repository.destroyAchievement(key);
      await _logActivity(ActivityActionType.delete, key, record);
      normalizePageAfterDelete(total.value - 1);
      await _refresh();
    } catch (error) {
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals() async {
    await _refresh();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    markQueryVersion();
    await _refresh();
  }

  Future<void> reset() async {
    idController.init('');
    titleController.init('');
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  AchievementFilter _collectFilter() {
    return AchievementFilter(
      id: idController.collect(),
      title: titleController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect. The default resolves the
  /// record's name from the database via the generated query layer
  /// (pass [record] to skip the lookup, e.g. after a delete); override
  /// in the hand-written class when the business log content differs.
  Future<void> _logActivity(
    ActivityActionType action,
    int key, [
    AchievementEntity? record,
  ]) async {
    final resolved = record ?? await _repository.getAchievement(key);
    final entityName = resolved == null
        ? key.toString()
        : resolved.titleLangZhCN.isNotEmpty
        ? resolved.titleLangZhCN
        : key.toString();
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_achievement',
          actionType: action,
          entityName: entityName,
          createdAt: DateTime.now(),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final filter = _collectFilter();
    final currentPage = page.value;
    loading.value = true;
    errorMessage.value = null;
    try {
      final (nextItems, nextTotal) = await (
        _repository.getBriefAchievements(page: currentPage, filter: filter),
        _repository.countAchievements(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      items.value = nextItems;
      total.value = nextTotal;
    } catch (error) {
      if (token != _refreshToken) return;
      LoggerUtil.instance.e('刷新列表失败: $error');
      errorMessage.value = '刷新列表失败: ${FoxyError.message(error)}';
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
