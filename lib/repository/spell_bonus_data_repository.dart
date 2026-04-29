import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellBonusDataRepository with RepositoryMixin {
  static const _table = 'spell_bonus_data';

  Future<SpellBonusDataEntity?> getSpellBonusData(int entry) async {
    try {
      var result = await laconic.table(_table).where('entry', entry).first();
      return SpellBonusDataEntity.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> storeSpellBonusData(SpellBonusDataEntity data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellBonusData(SpellBonusDataEntity data) async {
    var json = data.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', data.entry).update(json);
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
