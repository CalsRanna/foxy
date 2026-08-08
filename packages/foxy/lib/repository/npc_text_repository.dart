import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'npc_text_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('text')
class NpcTextRepository with RepositoryMixin, _NpcTextRepositoryMixin {

  Future<int> copyNpcText(int key) async {
    final source = await getNpcText(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
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
      'text0_0 as text0',
      'text0_1 as text1',
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
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.text.isNotEmpty) {
      builder = builder.whereAny(
        ['text0_0', 'text0_1'],
        '%${escapeLike(filter.text)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
