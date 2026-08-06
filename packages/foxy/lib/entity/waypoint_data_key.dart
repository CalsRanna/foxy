import 'package:meta/meta.dart';

/// Path-group identifier in the read-only waypoint picker; not the primary
/// key of a single waypoint_data row.
@immutable
final class WaypointDataKey {
  final int id;

  const WaypointDataKey({required this.id});

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is WaypointDataKey && id == other.id;
  }
}
