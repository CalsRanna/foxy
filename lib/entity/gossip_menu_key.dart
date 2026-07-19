import 'package:foxy/entity/gossip_menu_entity.dart';

class GossipMenuKey {
  final int menuId;
  final int textId;

  const GossipMenuKey({required this.menuId, required this.textId});

  factory GossipMenuKey.fromEntity(GossipMenuEntity entity) {
    return GossipMenuKey(menuId: entity.menuId, textId: entity.textId);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GossipMenuKey &&
          other.menuId == menuId &&
          other.textId == textId;

  @override
  int get hashCode => Object.hash(menuId, textId);
}
