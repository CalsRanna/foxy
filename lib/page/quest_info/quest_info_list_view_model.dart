import 'package:flutter/widgets.dart';
import 'package:foxy/model/activity_log.dart';
import 'package:foxy/model/quest_info.dart';
import 'package:foxy/model/quest_info_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestInfoListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final repository = QuestInfoRepository();

  final page = signal(1);
  final infos = signal(<QuestInfo>[]);
  final total = signal(0);

  Future<void> copyQuestInfo(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的任务信息？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyQuestInfo(id);
      _logActivity(ActivityActionType.copy, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteQuestInfo(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的任务信息？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyQuestInfo(id);
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
    final infos = this.infos.value;
    final info = infos.where((i) => i.id == id).firstOrNull;
    final name = info?.infoNameLangZhCn ?? '';
    final log = ActivityLog(
      module: 'quest_info',
      actionType: action,
      entityId: id,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals() async {
    final filter = QuestInfoFilterEntity();
    infos.value = await repository.getQuestInfos(page: 1, filter: filter);
    total.value = await repository.countQuestInfos(filter: filter);
  }

  void navigateToDetail({int? id, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建任务信息';
    final routeId = id != null ? 'quest_info_$id' : 'quest_info_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: QuestInfoDetailRoute(id: id),
      parentMenu: RouterMenu.questInfo,
    );
  }

  QuestInfoFilterEntity _buildFilter() {
    return QuestInfoFilterEntity()
      ..id = entryController.text
      ..name = nameController.text;
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    page.value = 1;
    final filter = QuestInfoFilterEntity();
    infos.value = await repository.getQuestInfos(page: 1, filter: filter);
    total.value = await repository.countQuestInfos(filter: filter);
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    infos.value = await repository.getQuestInfos(page: page.value, filter: filter);
    total.value = await repository.countQuestInfos(filter: filter);
  }
}
