import 'package:foxy/model/emote_text.dart';
import 'package:foxy/model/emote_text_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class EmoteTextRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_emotes_text';

  Future<List<EmoteText>> search({
    required EmoteTextFilterEntity filter,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => EmoteText.fromJson(e.toMap())).toList();
  }

  Future<int> count({required EmoteTextFilterEntity filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<EmoteText?> find(int id) async {
    try {
      var result = await laconic.table(_table).where('ID', id).first();
      return EmoteText.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> store(EmoteText data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> update(EmoteText data) async {
    var json = data.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', data.id).update(json);
  }

  Future<void> destroy(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copy(int id) async {
    var source = await find(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, EmoteTextFilterEntity filter) {
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name',
        '%${filter.name}%',
        operator: 'like',
      );
    }
    return builder;
  }
}
