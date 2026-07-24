// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_repository.dart';

mixin _VehicleRepositoryMixin on RepositoryMixin {
  Future<void> destroyVehicle(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_vehicle'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<VehicleEntity?> getVehicle(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_vehicle'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return VehicleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeVehicle(VehicleEntity vehicle) async {
    if (vehicle.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(vehicle);
    final json = _prepareWriteJson(vehicle.toJson());
    try {
      await laconic.table('foxy.dbc_vehicle').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateVehicle(int originalKey, VehicleEntity vehicle) async {
    await _beforeUpdate(originalKey, vehicle);
    final json = _prepareWriteJson(vehicle.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_vehicle'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(VehicleEntity vehicle) async {}

  Future<void> _beforeUpdate(int originalKey, VehicleEntity vehicle) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class VehicleFilter {
  final String id;

  const VehicleFilter({this.id = ''});

  factory VehicleFilter.fromJson(Map<String, dynamic> json) {
    return VehicleFilter(id: json['id']?.toString() ?? '');
  }

  VehicleFilter copyWith({String? id}) {
    return VehicleFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
