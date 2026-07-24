// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_repository.dart';

mixin _PlayerCreateInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyPlayerCreateInfo(PlayerCreateInfoKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('playercreateinfo'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<PlayerCreateInfoEntity?> getPlayerCreateInfo(
    PlayerCreateInfoKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('playercreateinfo'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoEntity.fromJson(results.first.toMap());
  }

  Future<void> storePlayerCreateInfo(
    PlayerCreateInfoEntity playerCreateInfo,
  ) async {
    await _beforeStore(playerCreateInfo);
    final json = _prepareWriteJson(playerCreateInfo.toJson());
    try {
      await laconic.table('playercreateinfo').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfo(
    PlayerCreateInfoKey originalKey,
    PlayerCreateInfoEntity playerCreateInfo,
  ) async {
    await _beforeUpdate(originalKey, playerCreateInfo);
    final json = _prepareWriteJson(playerCreateInfo.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('playercreateinfo'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(PlayerCreateInfoEntity playerCreateInfo) async {}

  Future<void> _beforeUpdate(
    PlayerCreateInfoKey originalKey,
    PlayerCreateInfoEntity playerCreateInfo,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoKey key) {
    var query = builder;
    query = query.where('race', key.race);
    query = query.where('class', key.class_);
    return query;
  }
}

final class PlayerCreateInfoFilter {
  final String race;
  final String class_;

  const PlayerCreateInfoFilter({this.race = '', this.class_ = ''});

  factory PlayerCreateInfoFilter.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoFilter(
      race: json['race']?.toString() ?? '',
      class_: json['class_']?.toString() ?? '',
    );
  }

  PlayerCreateInfoFilter copyWith({String? race, String? class_}) {
    return PlayerCreateInfoFilter(
      race: race ?? this.race,
      class_: class_ ?? this.class_,
    );
  }

  Map<String, dynamic> toJson() {
    return {'race': race, 'class_': class_};
  }
}
