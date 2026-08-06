// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_repository.dart';

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

mixin _VehicleRepositoryMixin on RepositoryMixin {
  Future<void> destroyVehicle(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_vehicle'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_vehicle record not found');
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(vehicle);
    final json = prepareWriteJson(vehicle.toJson());
    try {
      await laconic.table('foxy.dbc_vehicle').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = vehicle.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_vehicle', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_vehicle').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_vehicle');
        }
        rethrow;
      }
    }
  }

  Future<void> updateVehicle(int originalKey, VehicleEntity vehicle) async {
    await _beforeUpdate(originalKey, vehicle);
    final json = prepareWriteJson(vehicle.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_vehicle'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_vehicle');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_vehicle record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(VehicleEntity vehicle) async {}

  Future<void> _beforeUpdate(int originalKey, VehicleEntity vehicle) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
