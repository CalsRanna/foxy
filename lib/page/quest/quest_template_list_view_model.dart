import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_quest_template_entity.dart';
import 'package:foxy/entity/quest_template_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// 任务模板列表 ViewModel（LazySingleton，保留搜索状态）
class QuestTemplateListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  final _repository = GetIt.instance.get<QuestTemplateRepository>();

  late final idController = registerController(StringFieldController());
  late final titleController = registerController(StringFieldController());

  final templates = signal<List<BriefQuestTemplateEntity>>([]);
  final page = signal(1);
  final total = signal(0);

  Future<void> copyQuestTemplate(int key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '此操作将复制 ID=$key 的任务记录，确认继续？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyQuestTemplate(key);
      _logActivity(ActivityActionType.copy, key);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteQuestTemplate(int key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '将永久删除 ID=$key 的任务记录，此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyQuestTemplate(key);
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
    try {
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e('加载任务列表失败: $e');
      DialogUtil.instance.error('加载任务列表失败: $e');
    }
  }

  /// 导航到详情页（null 表示新建）
  void navigateToDetail({int? key, String? name}) {
    final label = key == null
        ? '新建任务'
        : name?.isNotEmpty == true
        ? name!
        : '任务 #$key';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      label: label,
      route: QuestTemplateDetailRoute(questTemplateKey: key),
      parentMenu: RouterMenu.questTemplate,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    idController.init('');
    titleController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  QuestTemplateFilterEntity _buildFilter() {
    return QuestTemplateFilterEntity(
      id: idController.collect(),
      title: titleController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, int key) {
    final templates = this.templates.value;
    final template = templates.where((t) => t.id == key).firstOrNull;
    final name = template?.logTitle ?? '';
    final log = ActivityLogEntity(
      module: 'quest_template',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefQuestTemplates(filter: filter, page: page.value),
        _repository.countQuestTemplates(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      templates.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新任务列表失败: $e');
      DialogUtil.instance.error('刷新任务列表失败: $e');
    }
  }
}
