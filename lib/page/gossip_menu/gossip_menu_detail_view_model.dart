import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_key.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/router/router_facade.dart';
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

  final menu = signal(GossipMenuEntity());
  final persistedKey = signal<GossipMenuKey?>(null);
  int? _reservedTextId;

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({GossipMenuKey? key}) async {
    try {
      if (key == null) {
        persistedKey.value = null;
        final reservedText = await _npcTextRepository.createNpcText();
        final blank = (await _repository.createGossipMenu()).copyWith(
          textId: reservedText.id,
        );
        _reservedTextId = reservedText.id;
        menu.value = blank;
        menuIdController.init(blank.menuId);
        textIdController.init(blank.textId);
        return;
      }
      persistedKey.value = key;
      final existing = await _repository.getGossipMenu(key);
      if (existing == null) {
        throw StateError('原对话菜单不存在，可能已被其他操作修改或删除');
      }
      textIdController.init(existing.textId);
      menu.value = existing;
      menuIdController.init(existing.menuId);
    } catch (e) {
      LoggerUtil.instance.e('加载对话菜单详情失败: $e');
      DialogUtil.instance.error('加载对话菜单详情失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> persist() async {
    final candidate = _collectFromControllers();
    if (candidate.menuId <= 0) throw StateError('请输入有效的 MenuID');
    if (candidate.textId <= 0) throw StateError('请选择有效的 NPC 文本');
    final originalKey = persistedKey.value;
    final action = originalKey == null
        ? ActivityActionType.create
        : ActivityActionType.update;
    if (originalKey == null && candidate.textId == _reservedTextId) {
      await _npcTextRepository.storeNpcText(
        NpcTextEntity(id: candidate.textId),
      );
    }
    if (originalKey == null) {
      await _repository.storeGossipMenu(candidate);
    } else {
      await _repository.updateGossipMenu(originalKey, candidate);
    }
    persistedKey.value = GossipMenuKey.fromEntity(candidate);
    menu.value = candidate;
    routerFacade.updateCurrentLabel('对话 ${candidate.menuId}');
    _logActivity(action, candidate);
  }

  Future<void> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('对话菜单数据已保存'));
      ShadSonner.of(context).show(toast);
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
