import 'package:foxy/model/smart_script.dart';
import 'package:foxy/model/smart_script_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SmartScriptRepository with RepositoryMixin {
  final String _table = 'smart_scripts';

  Future<int> count({SmartScriptFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder.select(['entryorguid']);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<void> destroySmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) async {
    await laconic
        .table(_table)
        .where('entryorguid', entryOrGuid)
        .where('source_type', sourceType)
        .where('id', id)
        .where('link', link)
        .delete();
  }

  Future<List<BriefSmartScript>> getBriefSmartScripts({
    int page = 1,
    SmartScriptFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'entryorguid',
      'source_type',
      'id',
      'link',
      'comment',
      'event_type',
      'action_type',
      'target_type',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder
        .orderBy('entryorguid')
        .orderBy('source_type')
        .orderBy('id');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefSmartScript.fromJson(e.toMap())).toList();
  }

  Future<SmartScript> getSmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) async {
    var result = await laconic
        .table(_table)
        .where('entryorguid', entryOrGuid)
        .where('source_type', sourceType)
        .where('id', id)
        .where('link', link)
        .first();
    return SmartScript.fromJson(result.toMap());
  }

  Future<void> storeSmartScript(SmartScript script) async {
    var json = script.toJson();
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateSmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
    SmartScript script,
  ) async {
    var json = script.toJson();
    json.remove('entryorguid');
    json.remove('source_type');
    json.remove('id');
    json.remove('link');
    await laconic
        .table(_table)
        .where('entryorguid', entryOrGuid)
        .where('source_type', sourceType)
        .where('id', id)
        .where('link', link)
        .update(json);
  }

  Future<void> copySmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) async {
    var script = await getSmartScript(entryOrGuid, sourceType, id, link);
    var json = script.toJson();
    var nextId = await _getNextId(entryOrGuid, sourceType);
    json['id'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextId(int entryOrGuid, int sourceType) async {
    var result = await laconic
        .table(_table)
        .select(['MAX(id) as max_id'])
        .where('entryorguid', entryOrGuid)
        .where('source_type', sourceType)
        .first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, SmartScriptFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.entryOrGuid.isNotEmpty) {
      builder = builder.where('entryorguid', filter.entryOrGuid);
    }
    if (filter.comment.isNotEmpty) {
      builder = builder.where('comment', '%${filter.comment}%');
    }
    return builder;
  }
}
