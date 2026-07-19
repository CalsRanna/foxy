import 'package:foxy/entity/map_info_entity.dart';

class MapInfoKey {
  final int id;

  const MapInfoKey({required this.id});

  factory MapInfoKey.fromEntity(MapInfoEntity entity) =>
      MapInfoKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MapInfoKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
