import 'package:foxy/model/scaling_stat_distribution.dart';
import 'package:foxy/model/scaling_stat_distribution_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ScalingStatDistributionSoloRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_scaling_stat_distribution';

  Future<List<ScalingStatDistribution>> search({
    required ScalingStatDistributionFilterEntity filter,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => ScalingStatDistribution.fromJson(e.toMap())).toList();
  }

  Future<int> count({required ScalingStatDistributionFilterEntity filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ScalingStatDistribution?> find(int id) async {
    try {
      var result = await laconic.table(_table).where('ID', id).first();
      return ScalingStatDistribution.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> store(ScalingStatDistribution item) async {
    await laconic.table(_table).insert([item.toJson()]);
  }

  Future<void> update(ScalingStatDistribution item) async {
    var json = item.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', item.id).update(json);
  }

  Future<void> destroy(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copy(int id) async {
    var source = await find(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, ScalingStatDistributionFilterEntity filter) {
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
