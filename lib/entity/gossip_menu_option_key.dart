import 'package:flutter/foundation.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';

@immutable
final class GossipMenuOptionKey {
  final int menuId;
  final int optionId;

  const GossipMenuOptionKey({required this.menuId, required this.optionId});

  factory GossipMenuOptionKey.fromEntity(GossipMenuOptionEntity value) {
    return GossipMenuOptionKey(menuId: value.menuId, optionId: value.optionId);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GossipMenuOptionKey &&
            menuId == other.menuId &&
            optionId == other.optionId;
  }

  @override
  int get hashCode => Object.hash(menuId, optionId);
}
