import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GossipMenuListViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<GossipMenuRepository>();

  final items = signal<List<BriefGossipMenuEntity>>([]);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final menuIdController = registerController(StringFieldController());

  late final textController = registerController(StringFieldController());

  int _refreshToken = 0;

  Future<void> initSignals() async {
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> reset() async {
    menuIdController.init('');
    textController.init('');
    page.value = 1;
    await _refresh();
  }

  /// 导航到详情页（null 表示新建）

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> copy(GossipMenuKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyGossipMenu(key);
      _logActivity(ActivityActionType.copy, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(GossipMenuKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyGossipMenu(key);
      _logActivity(ActivityActionType.delete, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  GossipMenuFilterEntity _collectFilter() {
    return GossipMenuFilterEntity(
      menuId: menuIdController.collect(),
      text: textController.collect(),
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
        _repository.getBriefGossipMenus(filter: filter, page: currentPage),
        _repository.countGossipMenus(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      items.value = nextItems;
      total.value = nextTotal;
    } catch (error) {
      if (token != _refreshToken) return;
      LoggerUtil.instance.e('刷新列表失败: $error');
      errorMessage.value = '刷新列表失败: $error';
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void _logActivity(ActivityActionType action, GossipMenuKey key) {
    final templates = items.value;
    final template = templates.where((t) => t.key == key).firstOrNull;
    final name = template?.text ?? '';
    final log = ActivityLogEntity(
      module: 'gossip_menu',
      actionType: action,
      entityName:
          'GossipMenu ${key.menuId}/${key.textId}${name.isEmpty ? '' : ' - $name'}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
