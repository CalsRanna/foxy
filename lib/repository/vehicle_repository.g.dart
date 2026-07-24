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

  Future<void> updateVehicle(int originalKey, VehicleEntity vehicle) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_vehicle'),
        originalKey,
      ).update(vehicle.toJson());
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
