import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'smart_script_repository.g.dart';

@FoxyRepository(SmartScriptEntity)
@FoxyFilter.text('entryOrGuid')
@FoxyFilter.text('comment')
class SmartScriptRepository with RepositoryMixin, _SmartScriptRepositoryMixin {
  static const _table = 'smart_scripts';
  static const primaryKeyColumns = {'entryorguid', 'source_type', 'id', 'link'};

  Future<SmartScriptKey> copySmartScript(SmartScriptKey key) async {
    final script = await getSmartScript(key);
    if (script == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final nextId = await nextMaxPlusOne(
      _table,
      'id',
      where: {
        'entryorguid': script.entryOrGuid,
        'source_type': script.sourceType,
      },
    );
    final candidate = script.copyWith(id: nextId);
    await storeSmartScript(candidate);
    return SmartScriptKey.fromEntity(candidate);
  }

  Future<int> countSmartScripts({SmartScriptFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SmartScriptEntity> createSmartScript({
    int entryOrGuid = 0,
    int sourceType = 0,
  }) async {
    var nextId = await nextMaxPlusOne(
      _table,
      'id',
      where: {'entryorguid': entryOrGuid, 'source_type': sourceType},
    );
    return SmartScriptEntity(
      entryOrGuid: entryOrGuid,
      sourceType: sourceType,
      id: nextId,
    );
  }

  Future<List<BriefSmartScriptEntity>> getBriefSmartScripts({
    int page = 1,
    SmartScriptFilter? filter,
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

  QueryBuilder _applyFilter(QueryBuilder builder, SmartScriptFilter? filter) {
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
