import 'package:flutter/foundation.dart';

/// 只读路径选择器中的 path 分组标识，不是单个 waypoint_data 物理行主键。
@immutable
final class WaypointDataKey {
  final int id;

  const WaypointDataKey({required this.id});

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is WaypointDataKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
