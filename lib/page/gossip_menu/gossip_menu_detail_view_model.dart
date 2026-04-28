import 'package:flutter/widgets.dart';
import 'package:foxy/model/activity_log.dart';
import 'package:foxy/model/gossip_menu.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GossipMenuDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final menuIdController = TextEditingController();
  final textIdController = TextEditingController();

  final menuId = signal(0);
  final textId = signal(0);
  final template = signal(GossipMenu());
  final saving = signal(false);

  int? _originalMenuId;
  int? _originalTextId;

  Future<void> initSignals({int? menuId, int? textId}) async {
    if (menuId == null) {
      // 新建：自动获取下一个 MenuID
      final next = await GossipMenuRepository().getNextMenuId();
      this.menuId.value = next.menuId;
      this.textId.value = 0;
      template.value = next;
      _originalMenuId = null;
      _originalTextId = null;
      menuIdController.text = this.menuId.value.toString();
      textIdController.text = '0';
    } else {
      // 编辑：从数据库加载
      final existing = await GossipMenuRepository().getGossipMenu({
        'MenuID': menuId,
        'TextID': textId ?? 0,
      });
      if (existing != null) {
        this.menuId.value = existing.menuId;
        this.textId.value = existing.textId;
        template.value = existing;
      } else {
        this.menuId.value = menuId;
        this.textId.value = textId ?? 0;
        template.value = GossipMenu()
          ..menuId = menuId
          ..textId = textId ?? 0;
      }
      _originalMenuId = menuId;
      _originalTextId = textId ?? 0;
      menuIdController.text = this.menuId.value.toString();
      textIdController.text = this.textId.value.toString();
    }
  }

  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final t = _collectFromControllers();
      if (_originalMenuId == null) {
        // 新建
        if (t.menuId == 0) {
          final next = await GossipMenuRepository().getNextMenuId();
          t.menuId = next.menuId;
        }
        await GossipMenuRepository().storeGossipMenu(t);
        template.value = t;
        _logActivity(ActivityActionType.create, t);
        _originalMenuId = t.menuId;
        _originalTextId = t.textId;
      } else {
        // 更新
        await GossipMenuRepository().updateGossipMenu({
          'MenuID': _originalMenuId!,
          'TextID': _originalTextId!,
        }, t);
        template.value = t;
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
    final t = GossipMenu()
      ..menuId = int.tryParse(menuIdController.text) ?? 0
      ..textId = int.tryParse(textIdController.text) ?? 0;
    return t;
  }

  void _logActivity(ActivityActionType action, GossipMenu t) {
    final log = ActivityLog(
      module: 'gossip_menu',
      actionType: action,
      entityId: t.menuId,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().store(log);
  }

  void dispose() {
    menuIdController.dispose();
    textIdController.dispose();
  }
}
