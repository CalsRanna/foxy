import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_page_text_entity.dart';
import 'package:foxy/entity/page_text_filter_entity.dart';
import 'package:foxy/entity/page_text_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class PageTextListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final idController = registerController(StringFieldController());
  late final textController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<PageTextRepository>();

  final page = signal(1);
  final pages = signal<List<BriefPageTextEntity>>([]);
  final total = signal(0);

  final _routerFacade = GetIt.instance.get<RouterFacade>();

  Future<void> copyPageText(PageTextKey key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制页面文本 ID=${key.id}？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyPageText(key);
      _logActivity(ActivityActionType.copy, key);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deletePageText(PageTextKey key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除页面文本 ID=${key.id}？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyPageText(key);
      _logActivity(ActivityActionType.delete, key);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (
        _repository.getBriefPageTexts(filter: _buildFilter(), page: page.value),
        _repository.countPageTexts(filter: _buildFilter()),
      ).wait;
      if (token != _refreshToken) return;
      pages.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载页面文本列表失败: $e');
      DialogUtil.instance.error('加载页面文本列表失败: $e');
    }
  }

  void navigateToDetail({PageTextKey? key, String? label}) {
    final name = label?.isNotEmpty == true ? label! : '新建页面文本';
    _routerFacade.navigateToDetail(
      label: name,
      route: TextContentDetailRoute(pageTextKey: key),
      parentMenu: RouterMenu.more,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    idController.init('');
    textController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  PageTextFilterEntity _buildFilter() {
    return PageTextFilterEntity(
      id: idController.collect(),
      text: textController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, PageTextKey key) {
    final pages = this.pages.value;
    final page = pages.where((p) => p.key == key).firstOrNull;
    final name = page?.text ?? '';
    final log = ActivityLogEntity(
      module: 'page_text',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (
        _repository.getBriefPageTexts(filter: _buildFilter(), page: page.value),
        _repository.countPageTexts(filter: _buildFilter()),
      ).wait;
      if (token != _refreshToken) return;
      pages.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新页面文本列表失败: $e');
      DialogUtil.instance.error('刷新页面文本列表失败: $e');
    }
  }
}
