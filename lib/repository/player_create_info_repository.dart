import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PlayerCreateInfoRepository with RepositoryMixin {
  Future<List<PlayerCreateInfoEntity>> getPlayerCreateInfos({
    required PlayerCreateInfoFilterEntity filter,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('playercreateinfo');
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => PlayerCreateInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countPlayerCreateInfos({
    required PlayerCreateInfoFilterEntity filter,
  }) async {
    var builder = laconic.table('playercreateinfo');
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<PlayerCreateInfoEntity> getPlayerCreateInfo(
    int race,
    int class_,
  ) async {
    var result = await laconic
        .table('playercreateinfo')
        .where('race', race)
        .where('class', class_)
        .first();
    return PlayerCreateInfoEntity.fromJson(result.toMap());
  }

  Future<void> storePlayerCreateInfo(PlayerCreateInfoEntity info) async {
    await laconic.table('playercreateinfo').insert([info.toJson()]);
  }

  Future<void> updatePlayerCreateInfo(
    Map<String, dynamic> credential,
    PlayerCreateInfoEntity info,
  ) async {
    var json = info.toJson();
    json.remove('race');
    json.remove('class');
    var builder = laconic.table('playercreateinfo');
    for (final entry in credential.entries) {
      builder = builder.where(entry.key, entry.value);
    }
    await builder.update(json);
  }

  Future<void> destroyPlayerCreateInfo(Map<String, dynamic> credential) async {
    var builder = laconic.table('playercreateinfo');
    for (final entry in credential.entries) {
      builder = builder.where(entry.key, entry.value);
    }
    await builder.delete();
  }

  Future<void> copyPlayerCreateInfo(Map<String, dynamic> credential) async {
    var source = await getPlayerCreateInfo(
      credential['race'] as int,
      credential['class'] as int,
    );
    var json = source.toJson();
    json['class'] = (json['class'] as int) + 1;
    await laconic.table('playercreateinfo').insert([json]);
  }

  // ---- Sub-table: action ----
  Future<List<PlayerCreateInfoActionEntity>> getActions(
    int race,
    int class_,
  ) async {
    var results = await laconic
        .table('playercreateinfo_action')
        .where('race', race)
        .where('class', class_)
        .get();
    return results
        .map((e) => PlayerCreateInfoActionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeAction(PlayerCreateInfoActionEntity action) async {
    await laconic.table('playercreateinfo_action').insert([action.toJson()]);
  }

  Future<void> updateAction(
    PlayerCreateInfoActionEntity action, {
    int? oldButton,
  }) async {
    var json = action.toJson();
    json.remove('race');
    json.remove('class');
    await laconic
        .table('playercreateinfo_action')
        .where('race', action.race)
        .where('class', action.class_)
        .where('button', oldButton ?? action.button)
        .update(json);
  }

  Future<void> deleteAction(int race, int class_, int button) async {
    await laconic
        .table('playercreateinfo_action')
        .where('race', race)
        .where('class', class_)
        .where('button', button)
        .delete();
  }

  // ---- Sub-table: item ----
  Future<List<PlayerCreateInfoItemEntity>> getItems(
    int race,
    int class_,
  ) async {
    var results = await laconic
        .table('playercreateinfo_item')
        .where('race', race)
        .where('class', class_)
        .get();
    return results
        .map((e) => PlayerCreateInfoItemEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeItem(PlayerCreateInfoItemEntity item) async {
    await laconic.table('playercreateinfo_item').insert([item.toJson()]);
  }

  Future<void> deleteItem(int race, int class_, int itemid) async {
    await laconic
        .table('playercreateinfo_item')
        .where('race', race)
        .where('class', class_)
        .where('itemid', itemid)
        .delete();
  }

  // ---- Sub-table: spell_custom ----
  Future<List<PlayerCreateInfoSpellCustomEntity>> getSpellCustoms(
    int racemask,
    int classmask,
  ) async {
    var results = await laconic
        .table('playercreateinfo_spell_custom')
        .where('racemask', racemask)
        .where('classmask', classmask)
        .get();
    return results
        .map((e) => PlayerCreateInfoSpellCustomEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeSpellCustom(PlayerCreateInfoSpellCustomEntity spell) async {
    await laconic.table('playercreateinfo_spell_custom').insert([
      spell.toJson(),
    ]);
  }

  Future<void> deleteSpellCustom(int racemask, int classmask, int spell) async {
    await laconic
        .table('playercreateinfo_spell_custom')
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
