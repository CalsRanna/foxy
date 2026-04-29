import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class PageTextListViewModel {
  final idController = TextEditingController();
  final textController = TextEditingController();
  final repository = PageTextRepository();

  final page = signal(1);
  final pages = signal<List<PageTextEntity>>([]);
  final total = signal(0);

  final _routerFacade = GetIt.instance.get<RouterFacade>();

  Future<void> initSignals() async {
    pages.value = await repository.getPageTexts(
      filter: _buildFilter(),
      page: page.value,
    );
    total.value = await repository.countPageTexts(filter: _buildFilter());
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> reset() async {
    idController.clear();
    textController.clear();
    page.value = 1;
    pages.value = await repository.getPageTexts(
      filter: _buildFilter(),
      page: page.value,
    );
    total.value = await repository.countPageTexts(filter: _buildFilter());
  }

  Future<void> paginate(int newPage) async {
    page.value = newPage;
    await _refresh();
  }

  void navigateToDetail({int? id, String? label}) {
    final routeId = id != null ? 'page_text_$id' : 'page_text_new';
    final name = label?.isNotEmpty == true ? label! : '新建页面文本';
    _routerFacade.navigateToDetail(
      id: routeId,
      label: name,
      route: TextContentDetailRoute(id: id, label: label),
      parentMenu: RouterMenu.more,
    );
  }

  Future<void> copyPageText(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制页面文本 ID=$id？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyPageText(id);
      _logActivity(ActivityActionType.copy, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deletePageText(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除页面文本 ID=$id？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyPageText(id);
      _logActivity(ActivityActionType.delete, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final pages = this.pages.value;
    final page = pages.where((p) => p.id == id).firstOrNull;
    final name = page?.text ?? '';
    final log = ActivityLogEntity(
      module: 'page_text',
      actionType: action,
      entityId: id,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  PageTextFilterEntity _buildFilter() {
    return PageTextFilterEntity(
      id: idController.text,
      text: textController.text,
    );
  }

  Future<void> _refresh() async {
    pages.value = await repository.getPageTexts(
      filter: _buildFilter(),
      page: page.value,
    );
    total.value = await repository.countPageTexts(filter: _buildFilter());
  }

  void dispose() {
    idController.dispose();
    textController.dispose();
  }
}
