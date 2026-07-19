import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GossipMenuDetailViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<GossipMenuRepository>();
  final _npcTextRepository = GetIt.instance.get<NpcTextRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  late final menuIdController = registerController(IntFieldController());
  late final textIdController = registerController(IntFieldController());

  final menuId = signal(0);
  final menu = signal(GossipMenuEntity());
  int? _originalMenuId;
  int? _originalTextId;
  int? _reservedTextId;

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? menuId, int? textId}) async {
    try {
      if (menuId == null) {
        final reservedText = await _npcTextRepository.createNpcText();
        final blank = (await _repository.createGossipMenu()).copyWith(
          textId: reservedText.id,
        );
        _reservedTextId = reservedText.id;
        this.menuId.value = blank.menuId;
        menu.value = blank;
        _originalMenuId = null;
        _originalTextId = null;
        menuIdController.init(blank.menuId);
        textIdController.init(blank.textId);
        return;
      }
      _originalMenuId = menuId;
      _originalTextId = textId ?? 0;
      final existing = await _repository.getGossipMenu(menuId, textId ?? 0);
      if (existing == null) return;
      this.menuId.value = existing.menuId;
      textIdController.init(existing.textId);
      menu.value = existing;
      menuIdController.init(this.menuId.value);
    } catch (e) {
      LoggerUtil.instance.e('加载对话菜单详情失败: $e');
      DialogUtil.instance.error('加载对话菜单详情失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> save(
    BuildContext context, {
    required void Function(int menuId, int textId) onSaved,
  }) async {
    try {
      final t = _collectFromControllers();
      if (t.textId <= 0) throw StateError('请选择有效的 NPC 文本');
      final npcText = await _npcTextRepository.getNpcText(t.textId);
      if (npcText == null) {
        if (t.textId != _reservedTextId) {
          throw StateError('TextID ${t.textId} 在 npc_text 中不存在');
        }
        await _npcTextRepository.storeNpcText(NpcTextEntity(id: t.textId));
      }
      final wasNew = _originalMenuId == null;
      final prevTextId = _originalTextId;
      if (wasNew) {
        final id = await _repository.storeGossipMenu(t);
        menuIdController.init(id);
        menuId.value = id;
        menu.value = t.copyWith(menuId: id);
        _logActivity(ActivityActionType.create, menu.value);
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
      final saved = menu.value;
      menuId.value = saved.menuId;
      textIdController.init(saved.textId);
      onSaved(saved.menuId, saved.textId);
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('对话菜单数据已保存'));
      ShadSonner.of(context).show(toast);
      // 新建保存后，或 TextID 变更后：替换路由参数，让各 Tab 用真实 ID 重新初始化
      if (wasNew || prevTextId != saved.textId) {
        routerFacade.replaceCurrentDetail(
          id: '${saved.menuId}',
          label: '对话 ${saved.menuId}',
          route: GossipMenuDetailRoute(
            menuId: saved.menuId,
            textId: saved.textId,
          ),
          parentMenu: RouterMenu.gossipMenu,
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  GossipMenuEntity _collectFromControllers() {
    return GossipMenuEntity(
      menuId: menuIdController.collect(),
      textId: textIdController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, GossipMenuEntity t) {
    final log = ActivityLogEntity(
      module: 'gossip_menu',
      actionType: action,
      entityName: 'GossipMenu ${t.menuId}/${t.textId}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
