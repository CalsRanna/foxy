import 'package:flutter/widgets.dart';
import 'package:foxy/model/emote_text.dart';
import 'package:foxy/model/emote_text_filter_entity.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class EmoteTextListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final repository = EmoteTextRepository();

  final page = signal(1);
  final items = signal(<EmoteText>[]);
  final total = signal(0);
  final selectedRowIndex = signal(-1);

  Future<void> copyEmoteText(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的表情文本？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copy(id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteEmoteText(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的表情文本？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroy(id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals() async {
    final filter = EmoteTextFilterEntity();
    items.value = await repository.search(page: 1, filter: filter);
    total.value = await repository.count(filter: filter);
  }

  void navigateToDetail(BuildContext context, {int? id, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建表情文本';
    final routeId = id != null ? 'emote_text_$id' : 'emote_text_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: EmoteTextDetailRoute(id: id),
      parentMenu: RouterMenu.emoteText,
    );
  }

  EmoteTextFilterEntity _buildFilter() {
    return EmoteTextFilterEntity()
      ..id = entryController.text
      ..name = nameController.text;
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    page.value = 1;
    final filter = EmoteTextFilterEntity();
    items.value = await repository.search(page: 1, filter: filter);
    total.value = await repository.count(filter: filter);
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    items.value = await repository.search(page: page.value, filter: filter);
    total.value = await repository.count(filter: filter);
  }
}
