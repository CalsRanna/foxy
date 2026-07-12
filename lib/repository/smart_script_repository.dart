import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/entity/smart_script_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SmartScriptRepository with RepositoryMixin {
  static const _table = 'smart_scripts';

  Future<List<BriefSmartScriptEntity>> getBriefSmartScripts({
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
        .orderBy('id')
        .orderBy('link');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSmartScriptEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SmartScriptEntity>> getSmartScripts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SmartScriptEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countSmartScripts({SmartScriptFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder.select(['entryorguid']);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SmartScriptEntity?> getSmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) async {
    var results = await laconic
        .table(_table)
        .where('entryorguid', entryOrGuid)
        .where('source_type', sourceType)
        .where('id', id)
        .where('link', link)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return SmartScriptEntity.fromJson(results.first.toMap());
  }

  Future<SmartScriptEntity> createSmartScript({
    int entryOrGuid = 0,
    int sourceType = 0,
  }) async {
    var nextId = await _getNextId(entryOrGuid, sourceType);
    return SmartScriptEntity(
      entryOrGuid: entryOrGuid,
      sourceType: sourceType,
      id: nextId,
    );
  }

  Future<void> storeSmartScript(SmartScriptEntity script) async {
    await laconic.table(_table).insert([script.toJson()]);
  }

  Future<void> updateSmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
    SmartScriptEntity script,
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

  Future<void> copySmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) async {
    var script = await getSmartScript(entryOrGuid, sourceType, id, link);
    if (script == null) return;
    var json = script.toJson();
    var nextId = await _getNextId(entryOrGuid, sourceType);
    json['id'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSmartScript(SmartScriptEntity script) async {
    var existing = await getSmartScript(
      script.entryOrGuid,
      script.sourceType,
      script.id,
      script.link,
    );
    if (existing != null) {
      await updateSmartScript(
        script.entryOrGuid,
        script.sourceType,
        script.id,
        script.link,
        script,
      );
    } else {
      await storeSmartScript(script);
    }
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SmartScriptFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entryOrGuid.isNotEmpty) {
      builder = builder.where('entryorguid', filter.entryOrGuid);
    }
    if (filter.comment.isNotEmpty) {
      builder = builder.where(
        'comment',
        '%${filter.comment}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
