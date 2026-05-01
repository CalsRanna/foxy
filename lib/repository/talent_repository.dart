import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/entity/talent_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class TalentRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_talent';

  Future<List<TalentEntity>> getTalents({
    int page = 1,
    TalentFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => TalentEntity.fromJson(e.toMap())).toList();
  }

  Future<List<BriefTalentEntity>> getBriefTalents({
    int page = 1,
    TalentFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'TabID', 'TierID', 'ColumnIndex', 'SpellRank0'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefTalentEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countTalents({TalentFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<TalentEntity?> getTalent(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return TalentEntity.fromJson(result.toMap());
  }

  Future<void> storeTalent(TalentEntity talent) async {
    var json = talent.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateTalent(TalentEntity talent) async {
    var json = talent.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', talent.id).update(json);
  }

  Future<void> destroyTalent(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyTalent(int id) async {
    var source = await getTalent(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select(['MAX(ID) as max_id']).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, TalentFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
