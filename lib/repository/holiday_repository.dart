import 'package:foxy/entity/holiday_entity.dart';
import 'package:foxy/entity/holiday_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class HolidayRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_holidays';

  Future<int> countHolidays({HolidayFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<List<BriefHolidayEntity>> getBriefHolidays({
    int page = 1,
    HolidayFilterEntity? filter,
  }) async {
    var builder = _applyFilter(laconic.table(_table), filter);
    builder = builder
        .select(['ID', 'HolidayNameID', 'TextureFileName'])
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize);
    final rows = await builder.get();
    return rows.map((row) => BriefHolidayEntity.fromJson(row.toMap())).toList();
  }

  Future<List<HolidayEntity>> getHolidays() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => HolidayEntity.fromJson(row.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, HolidayFilterEntity? filter) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
