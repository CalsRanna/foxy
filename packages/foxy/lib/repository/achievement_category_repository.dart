import 'package:foxy/entity/achievement_category_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'achievement_category_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class AchievementCategoryRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _AchievementCategoryRepositoryMixin {
  static const _table = 'foxy.dbc_achievement_category';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyAchievementCategory(int key) async {
    final source = await getAchievementCategory(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeAchievementCategory(copied);
    return copied.id;
  }

  Future<int> countAchievementCategories({AchievementCategoryFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<AchievementCategoryEntity> createAchievementCategory() async {
    return AchievementCategoryEntity(id: await _getNextId());
  }

  Future<List<AchievementCategoryEntity>> getAchievementCategories() async {
    final rows = await laconic.table(_table).orderBy('ID').get();
    return rows
        .map((row) => AchievementCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<BriefAchievementCategoryEntity>> getBriefAchievementCategories({
    int page = 1,
    AchievementCategoryFilter? filter,
  }) async {
    var builder = _applyFilter(laconic.table(_table), filter);
    builder = builder
        .select(['ID', 'Parent', 'Name_lang_zhCN', 'Ui_order'])
        .orderBy('Ui_order')
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize);
    final rows = await builder.get();
    return rows
        .map((row) => BriefAchievementCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    AchievementCategoryFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw IdExhaustedException(
        'no free int32 ID left in Achievement_Category.dbc',
      );
    }
    return id;
  }
}
