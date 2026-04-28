import 'package:foxy/model/spell_bonus_data.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellBonusDataRepository with RepositoryMixin {
  static const _table = 'spell_bonus_data';

  Future<SpellBonusData?> getSpellBonusData(int entry) async {
    try {
      var result = await laconic.table(_table).where('entry', entry).first();
      return SpellBonusData.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> storeSpellBonusData(SpellBonusData data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellBonusData(SpellBonusData data) async {
    var json = data.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', data.entry).update(json);
  }

  Future<void> saveSpellBonusData(SpellBonusData data) async {
    var existing = await getSpellBonusData(data.entry);
    if (existing != null) {
      await updateSpellBonusData(data);
    } else {
      await storeSpellBonusData(data);
    }
  }
}
