import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GossipMenuDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final menuIdController = TextEditingController();
  final textIdController = TextEditingController();

  final menuId = signal(0);
  final textId = signal(0);
  final menu = signal(GossipMenu());
  final saving = signal(false);

  int? _originalMenuId;
  int? _originalTextId;

  Future<void> initSignals({int? menuId, int? textId}) async {
    if (menuId == null) {
      final nextMenuId = await GossipMenuRepository().getNextMenuId();
      this.menuId.value = nextMenuId;
      this.textId.value = 0;
      menu.value = GossipMenu(menuId: nextMenuId, textId: 0);
      _originalMenuId = null;
      _originalTextId = null;
      menuIdController.text = nextMenuId.toString();
      textIdController.text = '0';
      return;
    }
    _originalMenuId = menuId;
    _originalTextId = textId ?? 0;
    try {
      final existing = await GossipMenuRepository().getGossipMenu(
        menuId,
        textId ?? 0,
      );
      this.menuId.value = existing.menuId;
      this.textId.value = existing.textId;
      menu.value = existing;
      menuIdController.text = this.menuId.value.toString();
      textIdController.text = this.textId.value.toString();
    } catch (e, s) {
      logger.e(
        '加载对话菜单(menuId=$menuId, textId=$textId)失败',
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final t = _collectFromControllers();
      if (_originalMenuId == null) {
        await GossipMenuRepository().storeGossipMenu(t);
        menu.value = t;
        _logActivity(ActivityActionType.create, t);
        _originalMenuId = t.menuId;
        _originalTextId = t.textId;
      } else {
        await GossipMenuRepository().updateGossipMenu(
          _originalMenuId!,
          _originalTextId!,
          t,
        );
        menu.value = t;
        _logActivity(ActivityActionType.update, t);
        _originalTextId = t.textId;
      }
      menuId.value = t.menuId;
      textId.value = t.textId;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('对话菜单数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  GossipMenu _collectFromControllers() {
    return GossipMenu(
      menuId: int.tryParse(menuIdController.text) ?? 0,
      textId: int.tryParse(textIdController.text) ?? 0,
    );
  }

  void _logActivity(ActivityActionType action, GossipMenu t) {
    final log = ActivityLogEntity(
      module: 'gossip_menu',
      actionType: action,
      entityId: t.menuId,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    menuIdController.dispose();
    textIdController.dispose();
  }
}
