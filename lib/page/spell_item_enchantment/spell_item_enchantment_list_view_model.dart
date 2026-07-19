import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SpellItemEnchantmentListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());
  late final nameController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<SpellItemEnchantmentRepository>();

  final page = signal(1);
  final enchantments = signal(<BriefSpellItemEnchantmentEntity>[]);
  final total = signal(0);

  Future<void> copySpellItemEnchantment(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的法术附魔？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copySpellItemEnchantment(id);
      _logActivity(ActivityActionType.copy, id);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteSpellItemEnchantment(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的法术附魔？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroySpellItemEnchantment(id);
      _logActivity(ActivityActionType.delete, id);
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
      final filter = SpellItemEnchantmentFilterEntity();
      final (items, count) = await (
        _repository.getBriefSpellItemEnchantments(page: 1, filter: filter),
        _repository.countSpellItemEnchantments(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      enchantments.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载法术物品附魔列表失败: $e');
      DialogUtil.instance.error('加载法术物品附魔列表失败: $e');
    }
  }

  void navigateToDetail({int? id, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建法术附魔';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      label: label,
      route: SpellItemEnchantmentDetailRoute(id: id, name: name),
      parentMenu: RouterMenu.spellItemEnchantment,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    nameController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  SpellItemEnchantmentFilterEntity _buildFilter() {
    return SpellItemEnchantmentFilterEntity(
      id: entryController.collect(),
      name: nameController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, int id) {
    final enchantments = this.enchantments.value;
    final enchantment = enchantments.where((e) => e.id == id).firstOrNull;
    final name = enchantment?.nameLangZhCN ?? '';
    final log = ActivityLogEntity(
      module: 'spell_item_enchantment',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefSpellItemEnchantments(
          page: page.value,
          filter: filter,
        ),
        _repository.countSpellItemEnchantments(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      enchantments.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新法术物品附魔列表失败: $e');
      DialogUtil.instance.error('刷新法术物品附魔列表失败: $e');
    }
  }
}
