import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/entity/smart_script_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SmartScriptListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryOrGuidController = registerController(
    StringFieldController(),
  );
  late final commentController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<SmartScriptRepository>();

  final page = signal(1);
  final scripts = signal(<BriefSmartScriptEntity>[]);
  final total = signal(0);

  Future<void> copySmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制该脚本行（entryorguid=$entryOrGuid, id=$id）？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copySmartScript(entryOrGuid, sourceType, id, link);
      _logActivity(ActivityActionType.copy, entryOrGuid, sourceType, id, link);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteSmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除脚本行（entryorguid=$entryOrGuid, id=$id）？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroySmartScript(entryOrGuid, sourceType, id, link);
      _logActivity(
        ActivityActionType.delete,
        entryOrGuid,
        sourceType,
        id,
        link,
      );
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
        _repository.getBriefSmartScripts(),
        _repository.countSmartScripts(),
      ).wait;
      if (token != _refreshToken) return;
      scripts.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载SmartAI脚本列表失败: $e');
      DialogUtil.instance.error('加载SmartAI脚本列表失败: $e');
    }
  }

  void navigateToDetail({
    int? entryOrGuid,
    int? sourceType,
    int? id,
    int? link,
  }) {
    final routerFacade = GetIt.instance.get<RouterFacade>();
    final isNew = entryOrGuid == null;
    final label = isNew ? '新建脚本' : '脚本 $entryOrGuid/$sourceType/$id/$link';
    routerFacade.navigateToDetail(
      label: label,
      route: SmartScriptDetailRoute(
        entryOrGuid: entryOrGuid,
        sourceType: sourceType,
        id: id,
        link: link,
      ),
      parentMenu: RouterMenu.smartScript,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryOrGuidController.init('');
    commentController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  SmartScriptFilterEntity _buildFilter() {
    return SmartScriptFilterEntity(
      entryOrGuid: entryOrGuidController.collect(),
      comment: commentController.collect(),
    );
  }

  void _logActivity(
    ActivityActionType action,
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) {
    final templates = scripts.value;
    final template = templates
        .where(
          (t) =>
              t.entryOrGuid == entryOrGuid &&
              t.sourceType == sourceType &&
              t.id == id &&
              t.link == link,
        )
        .firstOrNull;
    final name = template?.comment ?? '';
    final log = ActivityLogEntity(
      module: 'smart_script',
      actionType: action,
      entityName:
          'SmartScript $entryOrGuid/$sourceType/$id/$link'
          '${name.isEmpty ? '' : ' - $name'}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefSmartScripts(page: page.value, filter: filter),
        _repository.countSmartScripts(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      scripts.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新SmartAI脚本列表失败: $e');
      DialogUtil.instance.error('刷新SmartAI脚本列表失败: $e');
    }
  }
}
