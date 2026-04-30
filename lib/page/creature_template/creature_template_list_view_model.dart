import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class CreatureTemplateListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final subNameController = TextEditingController();
  final repository = CreatureTemplateRepository();

  final page = signal(1);
  final templates = signal(<BriefCreatureTemplateEntity>[]);
  final total = signal(0);

  Future<void> copyCreatureTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $entry 的生物模板？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyCreatureTemplate(entry);
      _logActivity(ActivityActionType.copy, entry);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteCreatureTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $entry 的生物模板？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyCreatureTemplate(entry);
      _logActivity(ActivityActionType.delete, entry);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
    subNameController.dispose();
  }

  Future<void> initSignals() async {
    try {
      templates.value = await repository.getBriefCreatureTemplates();
      total.value = await repository.countCreatureTemplates();
    } catch (e) {
      LoggerUtil.instance.e('加载生物列表失败: $e');
      DialogUtil.instance.error('加载生物列表失败: $e');
    }
  }

  void navigateToDetail({int? entry, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建生物';
    final id = entry != null ? 'creature_$entry' : 'creature_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: id,
      label: label,
      route: CreatureTemplateDetailRoute(entry: entry, name: name),
      parentMenu: RouterMenu.creatureTemplate,
    );
  }

  CreatureTemplateFilterEntity _buildFilter() {
    return CreatureTemplateFilterEntity(
      entry: entryController.text,
      name: nameController.text,
      subName: subNameController.text,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    subNameController.clear();
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    try {
      final filter = _buildFilter();
      templates.value = await repository.getBriefCreatureTemplates(
        page: page.value,
        filter: filter,
      );
      total.value = await repository.countCreatureTemplates(filter: filter);
    } catch (e) {
      LoggerUtil.instance.e('刷新生物列表失败: $e');
      DialogUtil.instance.error('刷新生物列表失败: $e');
    }
  }

  void _logActivity(ActivityActionType action, int entry) {
    final templates = this.templates.value;
    final template = templates.where((t) => t.entry == entry).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLogEntity(
      module: 'creature_template',
      actionType: action,
      entityId: entry,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
