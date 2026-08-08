import 'package:foxy/entity/taxi_path_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'taxi_path_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
class TaxiPathRepository with RepositoryMixin, _TaxiPathRepositoryMixin {

  Future<int> copyTaxiPath(int key) async {
    final source = await getTaxiPath(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = TaxiPathEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeTaxiPath(copied);
    return copied.id;
  }

  Future<int> countTaxiPaths({TaxiPathFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<TaxiPathEntity> createTaxiPath() async =>
      TaxiPathEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefTaxiPathEntity>> getBriefTaxiPaths({
    int page = 1,
    TaxiPathFilter? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select([
        'ID',
        'FromTaxiNode',
        'ToTaxiNode',
        'Cost',
      ]),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefTaxiPathEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<TaxiPathEntity>> getTaxiPaths() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => TaxiPathEntity.fromJson(row.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, TaxiPathFilter? filter) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    return builder;
  }
}
