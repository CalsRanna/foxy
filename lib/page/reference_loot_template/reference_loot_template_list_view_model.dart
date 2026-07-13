import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/loot_template_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ReferenceLootTemplateListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());
  late final nameController = registerController(StringFieldController());

  final repository = LootTemplateRepository(LootTableType.reference);

  final page = signal(1);
  final templates = signal<List<BriefLootTemplateEntity>>([]);
  final total = signal(0);

  final _routerFacade = GetIt.instance.get<RouterFacade>();

  Future<void> initSignals() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (_searchEntries(), _countEntries()).wait;
      if (token != _refreshToken) return;
      templates.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载引用掉落模板列表失败: $e');
      DialogUtil.instance.error('加载引用掉落模板列表失败: $e');
    }
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    nameController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  void navigateToDetail({int? entry, int? item, String? label}) {
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
      await repository.copyLootTemplate(entry, item);
      _logActivity(ActivityActionType.copy, entry);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
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
      await repository.destroyLootTemplate(entry, item);
      _logActivity(ActivityActionType.delete, entry);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void _logActivity(ActivityActionType action, int entry) {
    final templates = this.templates.value;
    final t = templates.where((t) => t.entry == entry).firstOrNull;
    final name = t?.item.toString() ?? '';
    final log = ActivityLogEntity(
      module: 'reference_loot_template',
      actionType: action,
      entityId: entry,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<List<BriefLootTemplateEntity>> _searchEntries() async {
    return repository.getBriefLootTemplateRows(
      filter: _buildFilter(),
      page: page.value,
    );
  }

  Future<int> _countEntries() async {
    return repository.countLootTemplateRows(filter: _buildFilter());
  }

  LootTemplateFilterEntity _buildFilter() {
    return LootTemplateFilterEntity(
      entry: entryController.collect(),
      name: nameController.collect(),
    );
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (_searchEntries(), _countEntries()).wait;
      if (token != _refreshToken) return;
      templates.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新引用掉落模板列表失败: $e');
      DialogUtil.instance.error('刷新引用掉落模板列表失败: $e');
    }
  }

  void dispose() {
    disposeControllers();
  }
}
