import 'package:foxy/model/player_create_info.dart';
import 'package:foxy/model/player_create_info_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PlayerCreateInfoRepository with RepositoryMixin {
  Future<List<PlayerCreateInfo>> search({
    required PlayerCreateInfoFilterEntity filter,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('playercreateinfo');
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => PlayerCreateInfo.fromJson(e.toMap())).toList();
  }

  Future<int> count({required PlayerCreateInfoFilterEntity filter}) async {
    var builder = laconic.table('playercreateinfo');
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<PlayerCreateInfo> find(int race, int class_) async {
    var result = await laconic.table('playercreateinfo')
        .where('race', race)
        .where('class', class_)
        .first();
    return PlayerCreateInfo.fromJson(result.toMap());
  }

  Future<void> store(PlayerCreateInfo info) async {
    await laconic.table('playercreateinfo').insert([info.toJson()]);
  }

  Future<void> update(Map<String, dynamic> credential, PlayerCreateInfo info) async {
    var json = info.toJson();
    json.remove('race');
    json.remove('class');
    var builder = laconic.table('playercreateinfo');
    for (final entry in credential.entries) {
      builder = builder.where(entry.key, entry.value);
    }
    await builder.update(json);
  }

  Future<void> destroy(Map<String, dynamic> credential) async {
    var builder = laconic.table('playercreateinfo');
    for (final entry in credential.entries) {
      builder = builder.where(entry.key, entry.value);
    }
    await builder.delete();
  }

  Future<void> copy(Map<String, dynamic> credential) async {
    var source = await find(credential['race'] as int, credential['class'] as int);
    var json = source.toJson();
    json['class'] = (json['class'] as int) + 1;
    await laconic.table('playercreateinfo').insert([json]);
  }

  // ---- Sub-table: action ----
  Future<List<PlayerCreateInfoAction>> getActions(int race, int class_) async {
    var results = await laconic.table('playercreateinfo_action')
        .where('race', race)
        .where('class', class_)
        .get();
    return results.map((e) => PlayerCreateInfoAction.fromJson(e.toMap())).toList();
  }

  Future<void> storeAction(PlayerCreateInfoAction action) async {
    await laconic.table('playercreateinfo_action').insert([action.toJson()]);
  }

  Future<void> updateAction(PlayerCreateInfoAction action, {int? oldButton}) async {
    var json = action.toJson();
    json.remove('race');
    json.remove('class');
    await laconic.table('playercreateinfo_action')
        .where('race', action.race)
        .where('class', action.class_)
        .where('button', oldButton ?? action.button)
        .update(json);
  }

  Future<void> deleteAction(int race, int class_, int button) async {
    await laconic.table('playercreateinfo_action')
        .where('race', race)
        .where('class', class_)
        .where('button', button)
        .delete();
  }

  // ---- Sub-table: item ----
  Future<List<PlayerCreateInfoItem>> getItems(int race, int class_) async {
    var results = await laconic.table('playercreateinfo_item')
        .where('race', race)
        .where('class', class_)
        .get();
    return results.map((e) => PlayerCreateInfoItem.fromJson(e.toMap())).toList();
  }

  Future<void> storeItem(PlayerCreateInfoItem item) async {
    await laconic.table('playercreateinfo_item').insert([item.toJson()]);
  }

  Future<void> deleteItem(int race, int class_, int itemid) async {
    await laconic.table('playercreateinfo_item')
        .where('race', race)
        .where('class', class_)
        .where('itemid', itemid)
        .delete();
  }

  // ---- Sub-table: spell_custom ----
  Future<List<PlayerCreateInfoSpellCustom>> getSpellCustoms(int racemask, int classmask) async {
    var results = await laconic.table('playercreateinfo_spell_custom')
        .where('racemask', racemask)
        .where('classmask', classmask)
        .get();
    return results.map((e) => PlayerCreateInfoSpellCustom.fromJson(e.toMap())).toList();
  }

  Future<void> storeSpellCustom(PlayerCreateInfoSpellCustom spell) async {
    await laconic.table('playercreateinfo_spell_custom').insert([spell.toJson()]);
  }

  Future<void> deleteSpellCustom(int racemask, int classmask, int spell) async {
    await laconic.table('playercreateinfo_spell_custom')
        .where('racemask', racemask)
        .where('classmask', classmask)
        .where('spell', spell)
        .delete();
  }

  dynamic _applyFilter(dynamic builder, PlayerCreateInfoFilterEntity filter) {
    if (filter.race.isNotEmpty) {
      builder = builder.where('race', filter.race);
    }
    if (filter.class_.isNotEmpty) {
      builder = builder.where('class', filter.class_);
    }
    return builder;
  }
}
