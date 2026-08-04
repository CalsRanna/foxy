// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_list_view_model.dart';

mixin _PlayerCreateInfoListViewModelMixin
    on FieldControllerMixin, QueryVersionMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoRepository>();

  final items = signal(<BriefPlayerCreateInfoEntity>[]);

  @override
  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final raceController = registerController(StringFieldController());

  late final classController = registerController(StringFieldController());

  int _refreshToken = 0;

  Future<void> copy(PlayerCreateInfoKey key) async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyPlayerCreateInfo(key);
      _logActivity(ActivityActionType.copy, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(PlayerCreateInfoKey key) async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyPlayerCreateInfo(key);
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
    raceController.init('');
    classController.init('');
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  PlayerCreateInfoFilter _collectFilter() {
    return PlayerCreateInfoFilter(
      race: raceController.collect(),
      class_: classController.collect(),
    );
  }

  /// Override point: records copy/delete activity log; entityName differs per page.
  void _logActivity(ActivityActionType action, PlayerCreateInfoKey key) {}

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final filter = _collectFilter();
    final currentPage = page.value;
    loading.value = true;
    errorMessage.value = null;
    try {
      final (nextItems, nextTotal) = await (
        _repository.getBriefPlayerCreateInfos(
          page: currentPage,
          filter: filter,
        ),
        _repository.countPlayerCreateInfos(filter: filter),
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
