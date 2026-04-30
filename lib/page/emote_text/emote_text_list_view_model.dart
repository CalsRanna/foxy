import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/entity/emote_text_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
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
  final emotes = signal(<EmoteTextEntity>[]);
  final total = signal(0);

  Future<void> copyEmoteText(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的表情文本？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await repository.copyEmoteText(id);
      _logActivity(ActivityActionType.copy, id);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
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
      await repository.destroyEmoteText(id);
      _logActivity(ActivityActionType.delete, id);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final templates = emotes.value;
    final template = templates.where((t) => t.id == id).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLogEntity(
      module: 'emote_text',
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
    try {
      emotes.value = await repository.getEmoteTexts(page: 1);
      total.value = await repository.countEmoteTexts();
    } catch (e) {
      LoggerUtil.instance.e('加载表情文本列表失败: $e');
      DialogUtil.instance.error('加载表情文本列表失败: $e');
    }
  }

  void navigateToDetail({int? id, String? name}) {
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
    return EmoteTextFilterEntity(
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
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    try {
      final filter = _buildFilter();
      emotes.value = await repository.getEmoteTexts(
        page: page.value,
        filter: filter,
      );
      total.value = await repository.countEmoteTexts(filter: filter);
    } catch (e) {
      LoggerUtil.instance.e('刷新表情文本列表失败: $e');
      DialogUtil.instance.error('刷新表情文本列表失败: $e');
    }
  }
}
