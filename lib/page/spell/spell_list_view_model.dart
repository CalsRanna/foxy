import 'package:flutter/widgets.dart';
import 'package:foxy/model/spell.dart';
import 'package:foxy/model/spell_filter_entity.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SpellListViewModel {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final repository = SpellRepository();

  final page = signal(1);
  final templates = signal(<BriefSpell>[]);
  final total = signal(0);

  Future<void> copySpell(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的法术？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copySpell(id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteSpell(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的法术？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroySpell(id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    idController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals() async {
    templates.value = await repository.getBriefSpells();
    total.value = await repository.count();
  }

  void navigateSpellDetailPage(BuildContext context, {int? id, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建法术';
    final detailId = id != null ? 'spell_$id' : 'spell_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: detailId,
      label: label,
      route: SpellDetailRoute(id: id),
      parentMenu: RouterMenu.spell,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    var filter = SpellFilterEntity()
      ..id = idController.text
      ..name = nameController.text;
    templates.value = await repository.getBriefSpells(page: page, filter: filter);
    total.value = await repository.count(filter: filter);
  }

  Future<void> reset() async {
    idController.clear();
    nameController.clear();
    page.value = 1;
    templates.value = await repository.getBriefSpells();
    total.value = await repository.count();
  }

  Future<void> search() async {
    page.value = 1;
    var filter = SpellFilterEntity()
      ..id = idController.text
      ..name = nameController.text;
    templates.value = await repository.getBriefSpells(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.count(filter: filter);
  }

  Future<void> _refresh() async {
    var filter = SpellFilterEntity()
      ..id = idController.text
      ..name = nameController.text;
    templates.value = await repository.getBriefSpells(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.count(filter: filter);
  }
}
