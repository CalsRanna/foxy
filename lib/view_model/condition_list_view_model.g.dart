// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition_list_view_model.dart';

mixin _ConditionListViewModelMixin on FieldControllerMixin, QueryVersionMixin {
  final _repository = GetIt.instance.get<ConditionRepository>();

  final items = signal(<BriefConditionEntity>[]);

  @override
  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final sourceTypeOrReferenceIdController = registerController(
    StringFieldController(),
  );

  late final sourceEntryController = registerController(
    StringFieldController(),
  );

  int _refreshToken = 0;

  Future<void> copy(ConditionKey key) async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyCondition(key);
      _logActivity(ActivityActionType.copy, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(ConditionKey key) async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyCondition(key);
      _logActivity(ActivityActionType.delete, key);
      normalizePageAfterDelete(total.value - 1);
      await _refresh();
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
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
    sourceTypeOrReferenceIdController.init('');
    sourceEntryController.init('');
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  ConditionFilter _collectFilter() {
    return ConditionFilter(
      sourceTypeOrReferenceId: sourceTypeOrReferenceIdController.collect(),
      sourceEntry: sourceEntryController.collect(),
    );
  }

  /// 覆写点:记录复制/删除活动日志,entityName 各页不同。
  void _logActivity(ActivityActionType action, ConditionKey key) {}

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final filter = _collectFilter();
    final currentPage = page.value;
    loading.value = true;
    errorMessage.value = null;
    try {
      final (nextItems, nextTotal) = await (
        _repository.getBriefConditions(page: currentPage, filter: filter),
        _repository.countConditions(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      items.value = nextItems;
      total.value = nextTotal;
    } catch (error) {
      if (token != _refreshToken) return;
      LoggerUtil.instance.e('刷新列表失败: $error');
      errorMessage.value = '刷新列表失败: ${foxyErrorMessage(error)}';
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
