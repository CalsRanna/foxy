// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_repository.dart';

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

mixin _PlayerCreateInfoRepositoryMixin on RepositoryMixin {
  Future<PlayerCreateInfoKey> copyPlayerCreateInfo(
    PlayerCreateInfoKey key,
  ) async {
    final source = await getPlayerCreateInfo(key);
    if (source == null) {
      throw RecordNotFoundException('playercreateinfo record not found');
    }
    final blank = await createPlayerCreateInfo();
    final copied = source.copyWith(race: blank.race, class_: blank.class_);
    await storePlayerCreateInfo(copied);
    return PlayerCreateInfoKey.fromEntity(copied);
  }

  Future<int> countPlayerCreateInfos({PlayerCreateInfoFilter? filter}) async {
    return _applyFilter(laconic.table('playercreateinfo'), filter).count();
  }

  Future<PlayerCreateInfoEntity> createPlayerCreateInfo() async {
    return PlayerCreateInfoEntity(
      race: await nextMaxPlusOne('playercreateinfo', '`race`'),
      class_: await nextMaxPlusOne('playercreateinfo', '`class`'),
    );
  }

  Future<void> destroyPlayerCreateInfo(PlayerCreateInfoKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('playercreateinfo'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('playercreateinfo record not found');
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

  Future<List<BriefPlayerCreateInfoEntity>> getBriefPlayerCreateInfos({
    int page = 1,
    PlayerCreateInfoFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('playercreateinfo').select([
      '`race`',
      '`class`',
      '`map`',
      '`zone`',
      '`position_x`',
      '`position_y`',
      '`position_z`',
      '`orientation`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`race`').orderBy('`class`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefPlayerCreateInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<PlayerCreateInfoEntity>> getPlayerCreateInfos() async {
    var builder = laconic
        .table('playercreateinfo')
        .orderBy('`race`')
        .orderBy('`class`');
    final results = await builder.get();
    return results
        .map((e) => PlayerCreateInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storePlayerCreateInfo(
    PlayerCreateInfoEntity playerCreateInfo,
  ) async {
    await _beforeStore(playerCreateInfo);
    final json = prepareWriteJson(playerCreateInfo.toJson());
    try {
      await laconic.table('playercreateinfo').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      throw DuplicateKeyException('duplicate key in playercreateinfo');
    }
  }

  Future<void> updatePlayerCreateInfo(
    PlayerCreateInfoKey originalKey,
    PlayerCreateInfoEntity playerCreateInfo,
  ) async {
    await _beforeUpdate(originalKey, playerCreateInfo);
    final json = prepareWriteJson(playerCreateInfo.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('playercreateinfo'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in playercreateinfo');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('playercreateinfo record not found');
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    PlayerCreateInfoFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.race.isNotEmpty) {
      builder = builder.where('`race`', filter.race);
    }
    if (filter.class_.isNotEmpty) {
      builder = builder.where('`class`', filter.class_);
    }
    return builder;
  }

  Future<void> _beforeDestroy(PlayerCreateInfoKey key) async {}

  Future<void> _beforeStore(PlayerCreateInfoEntity playerCreateInfo) async {}

  Future<void> _beforeUpdate(
    PlayerCreateInfoKey originalKey,
    PlayerCreateInfoEntity playerCreateInfo,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoKey key) {
    var query = builder;
    query = query.where('`race`', key.race);
    query = query.where('`class`', key.class_);
    return query;
  }
}
