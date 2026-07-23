import 'package:foxy/constant/item_constants.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_item_template_entity.dart';
import 'package:foxy/entity/item_template_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ItemTemplateListViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<ItemTemplateRepository>();

  final items = signal(<BriefItemTemplateEntity>[]);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  final selectedClassId = signal(-1);

  final selectedSubclass = signal(-1);

  late final entryController = registerController(StringFieldController());

  late final nameController = registerController(StringFieldController());

  late final descriptionController = registerController(
    StringFieldController(),
  );

  int _refreshToken = 0;

  Future<void> initSignals() async {
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
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

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> copy(int key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyItemTemplate(key);
      _logActivity(ActivityActionType.copy, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(int key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyItemTemplate(key);
      _logActivity(ActivityActionType.delete, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

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

  ItemTemplateFilterEntity _collectFilter() {
    return ItemTemplateFilterEntity(
      entry: entryController.collect(),
      name: nameController.collect(),
      description: descriptionController.collect(),
      classId: selectedClassId.value,
      subclass: selectedSubclass.value,
    );
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final filter = _collectFilter();
    final currentPage = page.value;
    loading.value = true;
    errorMessage.value = null;
    try {
      final (nextItems, nextTotal) = await (
        _repository.getBriefItemTemplates(page: currentPage, filter: filter),
        _repository.countItemTemplates(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      items.value = nextItems;
      total.value = nextTotal;
    } catch (error) {
      if (token != _refreshToken) return;
      LoggerUtil.instance.e('刷新列表失败: $error');
      errorMessage.value = '刷新列表失败: $error';
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void _logActivity(ActivityActionType action, int key) {
    final items = this.items.value;
    final template = items.where((t) => t.entry == key).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLogEntity(
      module: 'item_template',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
