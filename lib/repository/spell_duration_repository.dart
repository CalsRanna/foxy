import 'package:foxy/entity/spell_duration_entity.dart';
import 'package:foxy/entity/spell_duration_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellDurationRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell_duration';

  Future<List<BriefSpellDurationEntity>> getBriefSpellDurations({
    int page = 1,
    SpellDurationFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'Duration',
      'DurationPerLevel',
      'MaxDuration',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellDurationEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SpellDurationEntity>> getSpellDurations() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellDurationEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countSpellDurations({SpellDurationFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellDurationEntity?> getSpellDuration(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return SpellDurationEntity.fromJson(results.first.toMap());
  }

  Future<SpellDurationEntity> createSpellDuration() async {
    return const SpellDurationEntity();
  }

  Future<int> storeSpellDuration(SpellDurationEntity duration) async {
    var json = duration.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateSpellDuration(SpellDurationEntity duration) async {
    var json = duration.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', duration.id).update(json);
  }

  Future<void> destroySpellDuration(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copySpellDuration(int id) async {
    var source = await getSpellDuration(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellDuration(SpellDurationEntity duration) async {
    if (duration.id == 0) {
      await storeSpellDuration(duration);
      return;
    }
    var existing = await getSpellDuration(duration.id);
    if (existing != null) {
      await updateSpellDuration(duration);
    } else {
      await laconic.table(_table).insert([duration.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellDurationFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
