import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_waypoint_data_entity.dart';
import 'package:foxy/entity/waypoint_data_key.dart';

void main() {
  test('The waypoint picker uses a read-only group identifier', () {
    expect(
      BriefWaypointDataEntity.fromJson({'id': 10, 'points': 3}).key,
      const WaypointDataKey(id: 10),
    );
  });
}
