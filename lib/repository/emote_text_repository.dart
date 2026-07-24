import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'emote_text_repository.g.dart';

@FoxyRepository(EmoteTextEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class EmoteTextRepository with RepositoryMixin, _EmoteTextRepositoryMixin {
  static const _table = 'foxy.dbc_emotes_text';

  Future<int> copyEmoteText(int key) async {
    final source = await getEmoteText(key);
    if (source == null) {
      throw StateError('原表情文本不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeEmoteText(copied);
    return copied.id;
  }

  Future<int> countEmoteTexts({EmoteTextFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<EmoteTextEntity> createEmoteText() async {
    return EmoteTextEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefEmoteTextEntity>> getBriefEmoteTexts({
    int page = 1,
    EmoteTextFilter? filter,
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

  Future<List<EmoteTextEntity>> getEmoteTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => EmoteTextEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, EmoteTextFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('Name', '%${filter.name}%', comparator: 'like');
    }
    return builder;
  }
}
