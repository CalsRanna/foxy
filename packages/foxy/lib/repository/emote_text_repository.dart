import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'emote_text_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class EmoteTextRepository with RepositoryMixin, _EmoteTextRepositoryMixin {
  // The generated query layer inlines the table-name literal (mixins cannot
  // access class statics); this only serves as a contract check.
  // ignore: unused_field
  static const _table = 'foxy.dbc_emotes_text';

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, EmoteTextFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name',
        '%${escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
