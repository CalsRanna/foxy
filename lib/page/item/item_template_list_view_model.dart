import 'package:flutter/widgets.dart';
import 'package:foxy/constant/item_constants.dart';
import 'package:foxy/model/brief_item_template.dart';
import 'package:foxy/model/item_template_filter_entity.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:signals/signals.dart';

class ItemTemplateListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final repository = ItemTemplateRepository();

  final page = signal(1);
  final templates = signal(<BriefItemTemplate>[]);
  final total = signal(0);
  int _selectedClassId = -1;
  int _selectedSubclass = -1;

  int get selectedClassId => _selectedClassId;
  int get selectedSubclass => _selectedSubclass;

  /// 当前选中的类别名称
  String get selectedClassName {
    return _selectedClassId >= 0 ? kItemClasses[_selectedClassId] : '';
  }

  /// 获取当前类别下的子类别列表
  List<String> get currentSubclasses {
    if (_selectedClassId < 0 || _selectedClassId >= kItemSubclasses.length) {
      return [];
    }
    return kItemSubclasses[_selectedClassId];
  }

  Future<void> initSignals() async {
    templates.value = await repository.getBriefItemTemplates();
    total.value = await repository.count();
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }

  Future<void> search() async {
    page.value = 1;
    templates.value = await _fetchItems();
    total.value = await _count();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    templates.value = await _fetchItems();
    total.value = await _count();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    descriptionController.clear();
    _selectedClassId = -1;
    _selectedSubclass = -1;
    page.value = 1;
    templates.value = await repository.getBriefItemTemplates();
    total.value = await repository.count();
  }

  /// 选择类别
  void selectClass(int classId) {
    _selectedClassId = classId;
    _selectedSubclass = -1;
    search();
  }

  /// 清除类别选择
  void clearClass() {
    _selectedClassId = -1;
    _selectedSubclass = -1;
    search();
  }

  /// 选择子类别
  void selectSubclass(int subclass) {
    _selectedSubclass = subclass;
    search();
  }

  /// 清除子类别选择
  void clearSubclass() {
    _selectedSubclass = -1;
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
      ..classId = _selectedClassId
      ..subclass = _selectedSubclass;
    return repository.getBriefItemTemplates(page: page.value, filter: filter);
  }

  Future<int> _count() async {
    var filter = ItemTemplateFilterEntity()
      ..entry = entryController.text
      ..name = nameController.text
      ..description = descriptionController.text
      ..classId = _selectedClassId
      ..subclass = _selectedSubclass;
    return repository.count(filter: filter);
  }

  Future<void> _refresh() async {
    templates.value = await _fetchItems();
    total.value = await _count();
  }
}
