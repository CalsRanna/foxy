import 'package:flutter/widgets.dart';
import 'package:foxy/model/gossip_menu.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// 对话菜单详情页父 ViewModel（Factory）
class GossipMenuDetailViewModel {
  final _routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GossipMenuRepository();

  final menuIdController = TextEditingController();
  final textIdController = TextEditingController();

  /// 共享 signal：子 Tab 监听 textId 变化触发自身加载
  final menuId = signal(0);
  final textId = signal(0);

  /// 是否为新建模式
  final creating = signal(true);

  /// 当前正在编辑的主表记录（用于更新时作为 old key）
  int _originalMenuId = 0;
  int _originalTextId = 0;

  final loading = signal(false);
  final saving = signal(false);

  /// 初始化：创建模式 (menuId == null) 或编辑模式
  Future<void> initSignals({int? menuId, int? textId}) async {
    loading.value = true;
    try {
      if (menuId == null) {
        creating.value = true;
        final suggested = await _repository.getNextMenuId();
        this.menuId.value = suggested.menuId;
        this.textId.value = 0;
        menuIdController.text = suggested.menuId.toString();
        textIdController.text = '0';
      } else {
        creating.value = false;
        _originalMenuId = menuId;
        _originalTextId = textId ?? 0;
        final existing = await _repository.getGossipMenu({
          'MenuID': menuId,
          'TextID': textId ?? 0,
        });
        if (existing != null) {
          this.menuId.value = existing.menuId;
          this.textId.value = existing.textId;
        } else {
          this.menuId.value = menuId;
          this.textId.value = textId ?? 0;
        }
        menuIdController.text = this.menuId.value.toString();
        textIdController.text = this.textId.value.toString();
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> onSave() async {
    saving.value = true;
    try {
      final newMenuId = int.tryParse(menuIdController.text) ?? 0;
      final newTextId = int.tryParse(textIdController.text) ?? 0;
      final model = GossipMenu()
        ..menuId = newMenuId
        ..textId = newTextId;
      if (creating.value) {
        await _repository.storeGossipMenu(model);
        creating.value = false;
      } else {
        await _repository.updateGossipMenu(
          {'MenuID': _originalMenuId, 'TextID': _originalTextId},
          model,
        );
      }
      _originalMenuId = newMenuId;
      _originalTextId = newTextId;
      menuId.value = newMenuId;
      textId.value = newTextId;
      DialogUtil.instance.success('保存成功');
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('保存失败: ${e.toString()}');
    } finally {
      saving.value = false;
    }
  }

  void pop() {
    _routerFacade.goBack();
  }

  void dispose() {
    menuIdController.dispose();
    textIdController.dispose();
  }
}
