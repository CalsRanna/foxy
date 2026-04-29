import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/spell_item_enchantment.dart';
import 'package:foxy/entity/spell_item_enchantment_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_solo_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SpellItemEnchantmentListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final repository = SpellItemEnchantmentSoloRepository();

  final page = signal(1);
  final enchantments = signal(<SpellItemEnchantment>[]);
  final total = signal(0);

  Future<void> copySpellItemEnchantment(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的法术附魔？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copySpellItemEnchantment(id);
      _logActivity(ActivityActionType.copy, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
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
      DialogUtil.instance.loading();
      await repository.destroySpellItemEnchantment(id);
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
    final enchantments = this.enchantments.value;
    final enchantment = enchantments.where((e) => e.id == id).firstOrNull;
    final name = enchantment?.nameLangZhCn ?? '';
    final log = ActivityLogEntity(
      module: 'spell_item_enchantment',
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
    final filter = SpellItemEnchantmentFilterEntity();
    enchantments.value = await repository.getSpellItemEnchantments(
      page: 1,
      filter: filter,
    );
    total.value = await repository.countSpellItemEnchantments(filter: filter);
  }

  void navigateToDetail({int? id, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建法术附魔';
    final routeId = id != null
        ? 'spell_item_enchantment_$id'
        : 'spell_item_enchantment_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: SpellItemEnchantmentDetailRoute(id: id),
      parentMenu: RouterMenu.spellItemEnchantment,
    );
  }

  SpellItemEnchantmentFilterEntity _buildFilter() {
    return SpellItemEnchantmentFilterEntity(
      id: entryController.text,
      name: nameController.text,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    page.value = 1;
    final filter = SpellItemEnchantmentFilterEntity();
    enchantments.value = await repository.getSpellItemEnchantments(
      page: 1,
      filter: filter,
    );
    total.value = await repository.countSpellItemEnchantments(filter: filter);
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    enchantments.value = await repository.getSpellItemEnchantments(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.countSpellItemEnchantments(filter: filter);
  }
}
