import 'package:foxy/entity/broadcast_text_entity.dart';
import 'package:foxy/entity/broadcast_text_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class BroadcastTextRepository with RepositoryMixin {
  static const _table = 'broadcast_text';

  Future<void> copyBroadcastText(int id) async {
    var source = await getBroadcastText(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await nextMaxPlusOne(_table, 'ID');
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countBroadcastTexts({BroadcastTextFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<BroadcastTextEntity> createBroadcastText() async {
    return BroadcastTextEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyBroadcastText(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefBroadcastTextEntity>> getBriefBroadcastTexts({
    int page = 1,
    BroadcastTextFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'LanguageID',
      "COALESCE(NULLIF(MaleText, ''), FemaleText) as display_text",
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) {
      final map = e.toMap();
      final displayText = map['display_text'] as String? ?? '';
      map['MaleText'] = displayText;
      return BriefBroadcastTextEntity.fromJson(map);
    }).toList();
  }

  Future<BroadcastTextEntity?> getBroadcastText(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return BroadcastTextEntity.fromJson(results.first.toMap());
  }

  Future<List<BroadcastTextEntity>> getBroadcastTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => BroadcastTextEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveBroadcastText(BroadcastTextEntity text) async {
    if (text.id == 0) {
      await storeBroadcastText(text);
      return;
    }
    var existing = await getBroadcastText(text.id);
    if (existing != null) {
      await updateBroadcastText(text);
    } else {
      await laconic.table(_table).insert([text.toJson()]);
    }
  }

  Future<int> storeBroadcastText(BroadcastTextEntity text) async {
    var json = text.toJson();
    final nextId = text.id > 0 ? text.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateBroadcastText(BroadcastTextEntity text) async {
    var json = text.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', text.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    BroadcastTextFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.text.isNotEmpty) {
      builder = builder.whereAny(
        ['MaleText', 'FemaleText'],
        '%${filter.text}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
