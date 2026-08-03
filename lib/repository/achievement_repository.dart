import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'achievement_repository.g.dart';

@FoxyRepository(AchievementEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('title', column: 'Title_lang_zhCN')
class AchievementRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _AchievementRepositoryMixin {
  static const _table = 'foxy.dbc_achievement';

  @override
  String get dbcLocaleTableName => _table;

  @override
  Future<int> copyAchievement(int key) async {
    final source = await getAchievement(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeAchievement(copied);
    return copied.id;
  }

  @override
  Future<AchievementEntity> createAchievement() async {
    return AchievementEntity(id: await _getNextId());
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, AchievementFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.title.isNotEmpty) {
      builder = builder.where(
        'Title_lang_zhCN',
        '%${escapeLike(filter.title)}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0xffff) {
      throw IdExhaustedException(
        'no free smallint unsigned ID left in Achievement.dbc',
      );
    }
    return id;
  }
}
