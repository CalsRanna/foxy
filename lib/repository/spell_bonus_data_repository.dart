import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellBonusDataRepository with RepositoryMixin {
  static const _table = 'spell_bonus_data';

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
    var source = await getSpellBonusData(entry);
    if (source == null) return;
    var json = source.toJson();
    var nextEntry = await _getNextEntry();
    json['entry'] = nextEntry;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellBonusData(SpellBonusDataEntity data) async {
    var existing = await getSpellBonusData(data.entry);
    if (existing != null) {
      await updateSpellBonusData(data);
    } else {
      await storeSpellBonusData(data);
    }
  }

  Future<int> _getNextEntry() async {
    var result = await laconic.table(_table).select([
      'MAX(entry) as max_entry',
    ]).first();
    var maxEntry = result.toMap()['max_entry'] as int?;
    return (maxEntry ?? 0) + 1;
  }
}
