import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/entity/quest_template_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// 任务模板列表 ViewModel（LazySingleton，保留搜索状态）
class QuestTemplateListViewModel {
  final repository = QuestTemplateRepository();

  final idController = TextEditingController();
  final titleController = TextEditingController();

  final templates = signal<List<BriefQuestTemplateEntity>>([]);
  final page = signal(1);
  final total = signal(0);

  Future<void> initSignals() async {
    try {
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e('加载任务列表失败: $e');
      DialogUtil.instance.error('加载任务列表失败: $e');
    }
  }

  void dispose() {
    idController.dispose();
    titleController.dispose();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> paginate(int newPage) async {
    page.value = newPage;
    await _refresh();
  }

  Future<void> reset() async {
    idController.clear();
    titleController.clear();
    page.value = 1;
    await _refresh();
  }

  Future<void> copyQuestTemplate(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '此操作将复制 ID=$id 的任务记录，确认继续？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyQuestTemplate(id);
      _logActivity(ActivityActionType.copy, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteQuestTemplate(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '将永久删除 ID=$id 的任务记录，此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyQuestTemplate(id);
      _logActivity(ActivityActionType.delete, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  /// 导航到详情页（null 表示新建）
  void navigateToDetail({int? id}) {
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: id?.toString() ?? 'new',
      label: id != null ? '任务 $id' : '新建任务',
      route: QuestTemplateDetailRoute(entry: id),
      parentMenu: RouterMenu.questTemplate,
    );
  }

  Future<void> _refresh() async {
    try {
      final filter = _buildFilter();
      templates.value = await repository.getBriefQuestTemplates(
        filter: filter,
        page: page.value,
      );
      total.value = await repository.countQuestTemplates(filter: filter);
    } catch (e) {
      LoggerUtil.instance.e('刷新任务列表失败: $e');
      DialogUtil.instance.error('刷新任务列表失败: $e');
    }
  }

  QuestTemplateFilterEntity _buildFilter() {
    return QuestTemplateFilterEntity(
      id: idController.text,
      title: titleController.text,
    );
  }

  void _logActivity(ActivityActionType action, int id) {
    final templates = this.templates.value;
    final template = templates.where((t) => t.id == id).firstOrNull;
    final name = template?.logTitle ?? '';
    final log = ActivityLogEntity(
      module: 'quest_template',
      actionType: action,
      entityId: id,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
