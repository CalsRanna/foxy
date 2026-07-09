import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GossipMenuDetailViewModel {
  final _repository = GetIt.instance.get<GossipMenuRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final menuIdController = TextEditingController();

  final menuId = signal(0);
  final textIdController = TextEditingController();
  final menu = signal(GossipMenuEntity());
  int? _originalMenuId;
  int? _originalTextId;

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> initSignals({int? menuId, int? textId}) async {
    try {
      if (menuId == null) {
        final nextMenuId = await _repository.getNextMenuId();
        this.menuId.value = nextMenuId;
        textIdController.text = _fmt(0);
        menu.value = GossipMenuEntity(menuId: nextMenuId, textId: 0);
        _originalMenuId = null;
        _originalTextId = null;
        menuIdController.text = nextMenuId.toString();
        textIdController.text = _fmt(0);
        return;
      }
      _originalMenuId = menuId;
      _originalTextId = textId ?? 0;
      final existing = await _repository.getGossipMenu(menuId, textId ?? 0);
      if (existing == null) return;
      this.menuId.value = existing.menuId;
      textIdController.text = _fmt(existing.textId);
      menu.value = existing;
      menuIdController.text = this.menuId.value.toString();
    } catch (e) {
      LoggerUtil.instance.e('加载对话菜单详情失败: $e');
      DialogUtil.instance.error('加载对话菜单详情失败: $e');
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (_originalMenuId == null) {
        final id = await _repository.storeGossipMenu(t);
        menuIdController.text = '$id';
        menuId.value = id;
        menu.value = t;
        _logActivity(ActivityActionType.create, t);
        _originalMenuId = id;
        _originalTextId = t.textId;
      } else {
        await _repository.updateGossipMenu(
          _originalMenuId!,
          _originalTextId!,
          t,
        );
        menu.value = t;
        _logActivity(ActivityActionType.update, t);
        _originalTextId = t.textId;
      }
      menuId.value = t.menuId;
      textIdController.text = _fmt(t.textId);
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('对话菜单数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  GossipMenuEntity _collectFromControllers() {
    return GossipMenuEntity(
      menuId: int.tryParse(menuIdController.text) ?? 0,
      textId: _pi(textIdController.text),
    );
  }

  void _logActivity(ActivityActionType action, GossipMenuEntity t) {
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
