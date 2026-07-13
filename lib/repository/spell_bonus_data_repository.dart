import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellBonusDataRepository with RepositoryMixin {
  static const _table = 'spell_bonus_data';

  Future<List<BriefSpellBonusDataEntity>> getBriefSpellBonusDatas({
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'entry',
      'direct_bonus',
      'dot_bonus',
      'ap_bonus',
      'ap_dot_bonus',
      'comments',
    ]);
    builder = builder.orderBy('entry');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellBonusDataEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SpellBonusDataEntity>> getSpellBonusDatas() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => SpellBonusDataEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countSpellBonusDatas() async {
    return laconic.table(_table).count();
  }

  Future<SpellBonusDataEntity?> getSpellBonusData(int entry) async {
    var results = await laconic
        .table(_table)
        .where('entry', entry)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return SpellBonusDataEntity.fromJson(results.first.toMap());
  }

  Future<SpellBonusDataEntity> createSpellBonusData([int entry = 0]) async {
    return SpellBonusDataEntity(entry: entry);
  }

  Future<void> storeSpellBonusData(SpellBonusDataEntity data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellBonusData(SpellBonusDataEntity data) async {
    var json = data.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', data.entry).update(json);
  }

  Future<void> destroySpellBonusData(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }

  Future<void> copySpellBonusData(int entry) async {
    throw UnsupportedError('法术加成记录不能自动复制，请为有效法术新增记录。');
  }

  Future<void> saveSpellBonusData(SpellBonusDataEntity data) async {
    var existing = await getSpellBonusData(data.entry);
    if (existing != null) {
      await updateSpellBonusData(data);
    } else {
      await storeSpellBonusData(data);
    }
  }
}
