import 'package:flutter/widgets.dart';
import 'package:foxy/model/activity_log.dart';
import 'package:foxy/model/smart_script.dart';
import 'package:foxy/model/smart_script_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SmartScriptListViewModel {
  final entryOrGuidController = TextEditingController();
  final commentController = TextEditingController();
  final repository = SmartScriptRepository();

  final page = signal(1);
  final scripts = signal(<BriefSmartScript>[]);
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
      DialogUtil.instance.loading();
      await repository.copySmartScript(entryOrGuid, sourceType, id, link);
      _logActivity(ActivityActionType.copy, entryOrGuid, sourceType, id, link);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
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
      DialogUtil.instance.loading();
      await repository.destroySmartScript(entryOrGuid, sourceType, id, link);
      _logActivity(ActivityActionType.delete, entryOrGuid, sourceType, id, link);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryOrGuidController.dispose();
    commentController.dispose();
  }

  Future<void> initSignals() async {
    scripts.value = await repository.getBriefSmartScripts();
    total.value = await repository.countSmartScripts();
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
    final detailId = isNew
        ? 'smart_new'
        : 'smart_${entryOrGuid}_${sourceType}_${id}_$link';
    routerFacade.navigateToDetail(
      id: detailId,
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

  SmartScriptFilterEntity _buildFilter() {
    return SmartScriptFilterEntity()
      ..entryOrGuid = entryOrGuidController.text
      ..comment = commentController.text;
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryOrGuidController.clear();
    commentController.clear();
    page.value = 1;
    scripts.value = await repository.getBriefSmartScripts();
    total.value = await repository.countSmartScripts();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    scripts.value = await repository.getBriefSmartScripts(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.countSmartScripts(filter: filter);
  }

  void _logActivity(
    ActivityActionType action,
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) {
    final templates = scripts.value;
    final template = templates.where(
      (t) =>
          t.entryOrGuid == entryOrGuid &&
          t.sourceType == sourceType &&
          t.id == id &&
          t.link == link,
    ).firstOrNull;
    final name = template?.comment ?? '';
    final log = ActivityLog(
      module: 'smart_script',
      actionType: action,
      entityId: entryOrGuid,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
