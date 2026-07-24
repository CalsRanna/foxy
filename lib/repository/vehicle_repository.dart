import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/vehicle_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'vehicle_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'VehicleFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class VehicleRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_vehicle';

  Future<int> copyVehicle(int key) async {
    final source = await getVehicle(key);
    if (source == null) {
      throw StateError('原载具不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeVehicle(copied);
    return copied.id;
  }

  Future<int> countVehicles({VehicleFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<VehicleEntity> createVehicle() async {
    return VehicleEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyVehicle(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原载具不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefVehicleEntity>> getBriefVehicles({
    int page = 1,
    VehicleFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Flags', 'TurnSpeed']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefVehicleEntity.fromJson(e.toMap())).toList();
  }

  Future<VehicleEntity?> getVehicle(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return VehicleEntity.fromJson(results.first.toMap());
  }

  Future<List<VehicleEntity>> getVehicles() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => VehicleEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeVehicle(VehicleEntity vehicle) async {
    if (vehicle.id <= 0) {
      throw StateError('载具 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([vehicle.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('载具 ${vehicle.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateVehicle(int originalKey, VehicleEntity vehicle) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(vehicle.toJson());
      if (matchedRows == 0) {
        throw StateError('原载具不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的载具 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, VehicleFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
