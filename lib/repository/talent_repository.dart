import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/entity/talent_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class TalentRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_talent';

  Future<List<BriefTalentEntity>> getBriefTalents({
    int page = 1,
    TalentFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'TabID', 'TierID', 'ColumnIndex', 'SpellRank0'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefTalentEntity.fromJson(e.toMap())).toList();
  }

  Future<List<TalentEntity>> getTalents() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => TalentEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countTalents({TalentFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<TalentEntity?> getTalent(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return TalentEntity.fromJson(results.first.toMap());
  }

  Future<TalentEntity> createTalent() async {
    return TalentEntity(id: await _getNextId());
  }

  Future<int> storeTalent(TalentEntity talent) async {
    var json = talent.toJson();
    final nextId = talent.id > 0 ? talent.id : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
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

  Future<void> saveTalent(TalentEntity talent) async {
    if (talent.id == 0) {
      await storeTalent(talent);
      return;
    }
    var existing = await getTalent(talent.id);
    if (existing != null) {
      await updateTalent(talent);
    } else {
      await laconic.table(_table).insert([talent.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }

  QueryBuilder _applyFilter(QueryBuilder builder, TalentFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
