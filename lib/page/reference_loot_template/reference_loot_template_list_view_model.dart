import 'package:flutter/widgets.dart';
import 'package:foxy/model/loot_template.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ReferenceLootTemplateListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final repository = LootTemplateRepository(LootTableType.reference);

  final page = signal(1);
  final templates = signal<List<LootTemplate>>([]);
  final total = signal(0);

  final _routerFacade = GetIt.instance.get<RouterFacade>();

  Future<void> initSignals() async {
    templates.value = await _searchEntries();
    total.value = await _countEntries();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    page.value = 1;
    templates.value = await _searchEntries();
    total.value = await _countEntries();
  }

  Future<void> paginate(int newPage) async {
    page.value = newPage;
    await _refresh();
  }

  void navigateToDetail(
    BuildContext context, {
    int? entry,
    int? item,
    String? label,
  }) {
    final id = entry != null ? 'ref_loot_$entry' : 'ref_loot_new';
    final name = label?.isNotEmpty == true ? label! : '新建关联掉落';
    _routerFacade.navigateToDetail(
      id: id,
      label: name,
      route: ReferenceLootTemplateDetailRoute(
        entry: entry,
        item: item,
        label: label,
      ),
      parentMenu: RouterMenu.more,
    );
  }

  Future<void> copyReferenceLootTemplate(int entry, int item) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制关联掉落模板 Entry=$entry, Item=$item？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copy(entry, item);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteReferenceLootTemplate(int entry, int item) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除关联掉落记录 Entry=$entry, Item=$item？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.delete(entry, item);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  Future<List<LootTemplate>> _searchEntries() async {
    final filter = _buildFilter();
    return repository.searchByEntry(
      entry: filter['Entry'],
      name: filter['name'],
      page: page.value,
    );
  }

  Future<int> _countEntries() async {
    final filter = _buildFilter();
    return repository.countRows(entry: filter['Entry'], name: filter['name']);
  }

  Map<String, String> _buildFilter() {
    return {
      'Entry': entryController.text,
      'name': nameController.text,
    };
  }

  Future<void> _refresh() async {
    templates.value = await _searchEntries();
    total.value = await _countEntries();
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
  }
}
