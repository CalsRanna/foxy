// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_list_view_model.dart';

mixin _GossipMenuListViewModelMixin on FieldControllerMixin, QueryVersionMixin {
  final _repository = GetIt.instance.get<GossipMenuRepository>();

  final items = signal(<BriefGossipMenuEntity>[]);

  @override
  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final menuIdController = registerController(StringFieldController());

  late final textController = registerController(StringFieldController());

  int _refreshToken = 0;

  Future<void> copy(GossipMenuKey key) async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyGossipMenu(key);
      _logActivity(ActivityActionType.copy, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(GossipMenuKey key) async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyGossipMenu(key);
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
    menuIdController.init('');
    textController.init('');
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  GossipMenuFilter _collectFilter() {
    return GossipMenuFilter(
      menuId: menuIdController.collect(),
      text: textController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(ActivityActionType action, GossipMenuKey key) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'gossip_menu',
          actionType: action,
          entityName: key.toString(),
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
        _repository.getBriefGossipMenus(page: currentPage, filter: filter),
        _repository.countGossipMenus(filter: filter),
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
