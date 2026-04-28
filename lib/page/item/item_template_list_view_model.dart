import 'package:flutter/widgets.dart';
import 'package:foxy/constant/item_constants.dart';
import 'package:foxy/model/activity_log.dart';
import 'package:foxy/model/item_template.dart';
import 'package:foxy/model/item_template_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ItemTemplateListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final repository = ItemTemplateRepository();

  final page = signal(1);
  final templates = signal(<BriefItemTemplate>[]);
  final total = signal(0);
  final selectedClassId = signal(-1);
  final selectedSubclass = signal(-1);

  /// 当前选中的类别名称
  String get selectedClassName {
    return selectedClassId.value >= 0 ? kItemClasses[selectedClassId.value] : '';
  }

  /// 获取当前类别下的子类别列表
  List<String> get currentSubclasses {
    if (selectedClassId.value < 0 || selectedClassId.value >= kItemSubclasses.length) {
      return [];
    }
    return kItemSubclasses[selectedClassId.value];
  }

  Future<void> initSignals() async {
    templates.value = await repository.getBriefItemTemplates();
    total.value = await repository.countItemTemplates();
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    descriptionController.clear();
    selectedClassId.value = -1;
    selectedSubclass.value = -1;
    page.value = 1;
    templates.value = await repository.getBriefItemTemplates();
    total.value = await repository.countItemTemplates();
  }

  /// 选择类别
  void selectClass(int classId) {
    selectedClassId.value = classId;
    selectedSubclass.value = -1;
    search();
  }

  /// 清除类别选择
  void clearClass() {
    selectedClassId.value = -1;
    selectedSubclass.value = -1;
    search();
  }

  /// 选择子类别
  void selectSubclass(int subclass) {
    selectedSubclass.value = subclass;
    search();
  }

  /// 清除子类别选择
  void clearSubclass() {
    selectedSubclass.value = -1;
    search();
  }

  Future<void> copyItemTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $entry 的物品模板？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyItemTemplate(entry);
      _logActivity(ActivityActionType.copy, entry);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteItemTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $entry 的物品模板？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyItemTemplate(entry);
      _logActivity(ActivityActionType.delete, entry);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void navigateToDetail(int entry, String name) {
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: 'item_$entry',
      label: name,
      route: ItemTemplateDetailRoute(entry: entry, name: name),
      parentMenu: RouterMenu.itemTemplate,
    );
  }

  void navigateToNew() {
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: 'item_new',
      label: '新建物品',
      route: ItemTemplateDetailRoute(),
      parentMenu: RouterMenu.itemTemplate,
    );
  }

  Future<List<BriefItemTemplate>> _fetchItems() async {
    var filter = ItemTemplateFilterEntity()
      ..entry = entryController.text
      ..name = nameController.text
      ..description = descriptionController.text
      ..classId = selectedClassId.value
      ..subclass = selectedSubclass.value;
    return repository.getBriefItemTemplates(page: page.value, filter: filter);
  }

  Future<int> _count() async {
    var filter = ItemTemplateFilterEntity()
      ..entry = entryController.text
      ..name = nameController.text
      ..description = descriptionController.text
      ..classId = selectedClassId.value
      ..subclass = selectedSubclass.value;
    return repository.countItemTemplates(filter: filter);
  }

  Future<void> _refresh() async {
    templates.value = await _fetchItems();
    total.value = await _count();
  }

  void _logActivity(ActivityActionType action, int entry) {
    final templates = this.templates.value;
    final template = templates.where((t) => t.entry == entry).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLog(
      module: 'item_template',
      actionType: action,
      entityId: entry,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
