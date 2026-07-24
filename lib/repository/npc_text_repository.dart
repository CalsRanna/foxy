import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'npc_text_repository.g.dart';

@FoxyRepository(NpcTextEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('text')
class NpcTextRepository with RepositoryMixin, _NpcTextRepositoryMixin {
  static const _table = 'npc_text';

  Future<int> copyNpcText(int key) async {
    final source = await getNpcText(key);
    if (source == null) {
      throw StateError('原 NPC 文本不存在，可能已被其他操作修改或删除');
    }
    final json = source.toJson();
    json['ID'] = await nextMaxPlusOne(_table, 'ID');
    final copied = NpcTextEntity.fromJson(json);
    await storeNpcText(copied);
    return copied.id;
  }

  Future<int> countNpcTexts({NpcTextFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<NpcTextEntity> createNpcText([int? id]) async {
    return NpcTextEntity(id: id ?? await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefNpcTextEntity>> getBriefNpcTexts({
    int page = 1,
    NpcTextFilter? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'text0_0 AS text0',
      'text0_1 AS text1',
    ]);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefNpcTextEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<NpcTextEntity>> getNpcTexts() async {
    final results = await laconic.table(_table).get();
    return results.map((row) => NpcTextEntity.fromJson(row.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, NpcTextFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.text.isNotEmpty) {
      builder = builder.whereAny(
        ['text0_0', 'text0_1'],
        '%${filter.text}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
