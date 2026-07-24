import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/broadcast_text_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'broadcast_text_repository.g.dart';

@FoxyRepository(BroadcastTextEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('text')
class BroadcastTextRepository
    with RepositoryMixin, _BroadcastTextRepositoryMixin {
  static const _table = 'broadcast_text';

  Future<int> copyBroadcastText(int key) async {
    final source = await getBroadcastText(key);
    if (source == null) {
      throw StateError('原广播文本不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeBroadcastText(copied);
    return copied.id;
  }

  Future<int> countBroadcastTexts({BroadcastTextFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<BroadcastTextEntity> createBroadcastText() async {
    return BroadcastTextEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefBroadcastTextEntity>> getBriefBroadcastTexts({
    int page = 1,
    BroadcastTextFilter? filter,
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

  Future<List<BroadcastTextEntity>> getBroadcastTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => BroadcastTextEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, BroadcastTextFilter? filter) {
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
