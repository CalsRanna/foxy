import 'package:flutter/widgets.dart';
import 'package:foxy/constant/item_constants.dart';
import 'package:foxy/model/brief_item_template.dart';
import 'package:foxy/model/item_template_filter_entity.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:signals_flutter/signals_core.dart';

class ItemTemplateListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final repository = ItemTemplateRepository();

  final page = signal(1);
  final items = signal(<BriefItemTemplate>[]);
  final total = signal(0);
  final selectedClassId = signal(-1);
  final selectedSubclass = signal(-1);

  /// 当前选中的类别名称
  String get selectedClassName {
    final classId = selectedClassId.value;
    return classId >= 0 ? kItemClasses[classId] : '';
  }

  /// 获取当前类别下的子类别列表
  List<String> get currentSubclasses {
    final classId = selectedClassId.value;
    if (classId < 0 || classId >= kItemSubclasses.length) return [];
    return kItemSubclasses[classId];
  }

  Future<void> initSignals() async {
    items.value = await repository.getBriefItemTemplates();
    total.value = await repository.count();
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }

  Future<void> search() async {
    page.value = 1;
    items.value = await _fetchItems();
    total.value = await _count();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    items.value = await _fetchItems();
    total.value = await _count();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    descriptionController.clear();
    selectedClassId.value = -1;
    selectedSubclass.value = -1;
    page.value = 1;
    items.value = await repository.getBriefItemTemplates();
    total.value = await repository.count();
  }

  /// 选择类别
  void selectClass(int classId) {
    selectedClassId.value = classId;
    selectedSubclass.value = -1;  // 重置子类别选择
  }

  /// 清除类别选择
  void clearClass() {
    selectedClassId.value = -1;
    selectedSubclass.value = -1;
  }

  /// 选择子类别
  void selectSubclass(int subclass) {
    selectedSubclass.value = subclass;
  }

  /// 清除子类别选择
  void clearSubclass() {
    selectedSubclass.value = -1;
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
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  Future<List<BriefItemTemplate>> _fetchItems() async {
    var filter = ItemTemplateFilterEntity()
      ..entry = entryController.text
      ..name = nameController.text
      ..description = descriptionController.text
      ..classId = selectedClassId.value
      ..subclass = selectedSubclass.value;
    return repository.getBriefItemTemplates(
      page: page.value,
      filter: filter,
    );
  }

  Future<int> _count() async {
    var filter = ItemTemplateFilterEntity()
      ..entry = entryController.text
      ..name = nameController.text
      ..description = descriptionController.text
      ..classId = selectedClassId.value
      ..subclass = selectedSubclass.value;
    return repository.countWithFilter(filter: filter);
  }

  Future<void> _refresh() async {
    items.value = await _fetchItems();
    total.value = await _count();
  }
}
