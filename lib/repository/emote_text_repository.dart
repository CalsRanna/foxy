import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'emote_text_repository.g.dart';

@FoxyRepository(EmoteTextEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class EmoteTextRepository with RepositoryMixin, _EmoteTextRepositoryMixin {
  // 生成版查询层内联表名字面量（mixin 无法访问类静态成员），此处仅作契约校验。
  // ignore: unused_field
  static const _table = 'foxy.dbc_emotes_text';

  @override
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
