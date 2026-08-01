// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_detail_view_model.dart';

mixin _GossipMenuDetailViewModelMixin on FieldControllerMixin {
  late final menuIdController = registerController(IntFieldController());
  late final textIdController = registerController(IntFieldController());

  void _afterApplyCandidate(GossipMenuEntity gossipMenu) {}

  void _applyCandidate(GossipMenuEntity gossipMenu) {
    menuIdController.init(gossipMenu.menuId);
    textIdController.init(gossipMenu.textId);
    _afterApplyCandidate(gossipMenu);
  }

  GossipMenuEntity _collectCandidate() {
    return GossipMenuEntity(
      menuId: menuIdController.collect(),
      textId: textIdController.collect(),
    );
  }
}
