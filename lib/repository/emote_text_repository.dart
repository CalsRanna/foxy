import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/entity/emote_text_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class EmoteTextRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_emotes_text';

  Future<void> copyEmoteText(int id) async {
    var source = await getEmoteText(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countEmoteTexts({EmoteTextFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<EmoteTextEntity> createEmoteText() async {
    return EmoteTextEntity(id: await _getNextId());
  }

  Future<void> destroyEmoteText(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefEmoteTextEntity>> getBriefEmoteTexts({
    int page = 1,
    EmoteTextFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'Name', 'EmoteID'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefEmoteTextEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<EmoteTextEntity?> getEmoteText(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return EmoteTextEntity.fromJson(results.first.toMap());
  }

  Future<List<EmoteTextEntity>> getEmoteTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => EmoteTextEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveEmoteText(EmoteTextEntity emoteText) async {
    if (emoteText.id == 0) {
      await storeEmoteText(emoteText);
      return;
    }
    var existing = await getEmoteText(emoteText.id);
    if (existing != null) {
      await updateEmoteText(emoteText);
    } else {
      await laconic.table(_table).insert([emoteText.toJson()]);
    }
  }

  Future<int> storeEmoteText(EmoteTextEntity emoteText) async {
    var json = emoteText.toJson();
    final nextId = emoteText.id > 0 ? emoteText.id : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateEmoteText(EmoteTextEntity emoteText) async {
    var json = emoteText.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', emoteText.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    EmoteTextFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('Name', '%${filter.name}%', comparator: 'like');
    }
    return builder;
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }
}
