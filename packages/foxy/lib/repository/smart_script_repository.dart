import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'smart_script_repository.g.dart';

@FoxyRepository(
  autoIncrementKey: 'id',
  autoIncrementScope: ['entryOrGuid', 'sourceType'],
)
@FoxyFilter.text('entryOrGuid')
@FoxyFilter.text('comment')
class SmartScriptRepository with RepositoryMixin, _SmartScriptRepositoryMixin {
  static const primaryKeyColumns = {'entryorguid', 'source_type', 'id', 'link'};

  @override
  Future<SmartScriptKey> copySmartScript(SmartScriptKey key) async {
    final script = await getSmartScript(key);
    if (script == null) {
      throw RecordNotFoundException('record not found');
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

  @override
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

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, SmartScriptFilter? filter) {
    if (filter == null) return builder;
    if (filter.entryOrGuid.isNotEmpty) {
      builder = builder.where(
        'entryorguid',
        int.tryParse(filter.entryOrGuid) ?? 0,
      );
    }
    if (filter.comment.isNotEmpty) {
      builder = builder.where(
        'comment',
        '%${escapeLike(filter.comment)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
