import 'package:foxy/constant/item_constants.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_item_template_entity.dart';
import 'package:foxy/entity/item_template_filter_entity.dart';
import 'package:foxy/entity/item_template_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ItemTemplateListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());
  late final nameController = registerController(StringFieldController());
  late final descriptionController = registerController(
    StringFieldController(),
  );

  final _repository = GetIt.instance.get<ItemTemplateRepository>();

  final page = signal(1);
  final templates = signal(<BriefItemTemplateEntity>[]);
  final total = signal(0);
  final selectedClassId = signal(-1);
  final selectedSubclass = signal(-1);

  /// 获取当前类别下的子类别列表
  List<String> get currentSubclasses {
    if (selectedClassId.value < 0 ||
        selectedClassId.value >= kItemSubclasses.length) {
      return [];
    }
    return kItemSubclasses[selectedClassId.value];
  }

  /// 当前选中的类别名称
  String get selectedClassName {
    return selectedClassId.value >= 0
        ? kItemClasses[selectedClassId.value]
        : '';
  }

  /// 清除类别选择
  void clearClass() {
    selectedClassId.value = -1;
    selectedSubclass.value = -1;
    search();
  }

  /// 清除子类别选择
  void clearSubclass() {
    selectedSubclass.value = -1;
    search();
  }

  Future<void> copyItemTemplate(ItemTemplateKey key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 ${key.entry} 的物品模板？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyItemTemplate(key);
      _logActivity(ActivityActionType.copy, key);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteItemTemplate(ItemTemplateKey key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 ${key.entry} 的物品模板？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyItemTemplate(key);
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
        _repository.getBriefItemTemplates(),
        _repository.countItemTemplates(),
      ).wait;
      if (token != _refreshToken) return;
      templates.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载物品列表失败: $e');
      DialogUtil.instance.error('加载物品列表失败: $e');
    }
  }

  void navigateToDetail({ItemTemplateKey? key, String? name}) {
    final routerFacade = GetIt.instance.get<RouterFacade>();
    final label = key == null
        ? '新建物品'
        : name?.isNotEmpty == true
        ? name!
        : '物品 #${key.entry}';
    routerFacade.navigateToDetail(
      label: label,
      route: ItemTemplateDetailRoute(itemTemplateKey: key),
      parentMenu: RouterMenu.itemTemplate,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    nameController.init('');
    descriptionController.init('');
    selectedClassId.value = -1;
    selectedSubclass.value = -1;
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  /// 选择类别
  void selectClass(int classId) {
    selectedClassId.value = classId;
    selectedSubclass.value = -1;
    search();
  }

  /// 选择子类别
  void selectSubclass(int subclass) {
    selectedSubclass.value = subclass;
    search();
  }

  Future<int> _count() async {
    final filter = ItemTemplateFilterEntity(
      entry: entryController.collect(),
      name: nameController.collect(),
      description: descriptionController.collect(),
      classId: selectedClassId.value,
      subclass: selectedSubclass.value,
    );
    return _repository.countItemTemplates(filter: filter);
  }

  Future<List<BriefItemTemplateEntity>> _fetchItems() async {
    final filter = ItemTemplateFilterEntity(
      entry: entryController.collect(),
      name: nameController.collect(),
      description: descriptionController.collect(),
      classId: selectedClassId.value,
      subclass: selectedSubclass.value,
    );
    return _repository.getBriefItemTemplates(page: page.value, filter: filter);
  }

  void _logActivity(ActivityActionType action, ItemTemplateKey key) {
    final templates = this.templates.value;
    final template = templates.where((t) => t.entry == key.entry).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLogEntity(
      module: 'item_template',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (_fetchItems(), _count()).wait;
      if (token != _refreshToken) return;
      templates.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新物品列表失败: $e');
      DialogUtil.instance.error('刷新物品列表失败: $e');
    }
  }
}
