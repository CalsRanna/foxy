// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_info_list_view_model.dart';

mixin _QuestInfoListViewModelMixin on FieldControllerMixin, QueryVersionMixin {
  final _repository = GetIt.instance.get<QuestInfoRepository>();

  final items = signal(<BriefQuestInfoEntity>[]);

  @override
  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(StringFieldController());

  late final nameController = registerController(StringFieldController());

  int _refreshToken = 0;

  Future<void> copy(int key) async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyQuestInfo(key);
      await _logActivity(ActivityActionType.copy, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = FoxyExceptions.message(error);
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
      final record = await _repository.getQuestInfo(key);
      await _repository.destroyQuestInfo(key);
      await _logActivity(ActivityActionType.delete, key, record);
      normalizePageAfterDelete(total.value - 1);
      await _refresh();
    } catch (error) {
      errorMessage.value = FoxyExceptions.message(error);
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
    nameController.init('');
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  QuestInfoFilter _collectFilter() {
    return QuestInfoFilter(
      id: idController.collect(),
      name: nameController.collect(),
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
    QuestInfoEntity? record,
  ]) async {
    final resolved = record ?? await _repository.getQuestInfo(key);
    final entityName = resolved == null
        ? key.toString()
        : resolved.infoNameLangZhCN.isNotEmpty
        ? resolved.infoNameLangZhCN
        : key.toString();
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_quest_info',
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
        _repository.getBriefQuestInfos(page: currentPage, filter: filter),
        _repository.countQuestInfos(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      items.value = nextItems;
      total.value = nextTotal;
    } catch (error) {
      if (token != _refreshToken) return;
      LoggerUtil.instance.e('刷新列表失败: $error');
      errorMessage.value = '刷新列表失败: ${FoxyExceptions.message(error)}';
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
