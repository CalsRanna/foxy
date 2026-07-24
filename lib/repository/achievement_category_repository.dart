import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/achievement_category_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'achievement_category_repository.g.dart';

@FoxyRepository(AchievementCategoryEntity)
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
      throw StateError('原成就分类不存在，可能已被其他操作修改或删除');
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

  Future<List<DbcLocaleFieldValue>> getAchievementCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

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

  Future<void> saveAchievementCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeAchievementCategory(
    AchievementCategoryEntity category,
  ) async {
    if (category.id <= 0) {
      throw StateError('成就分类 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([category.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('成就分类 ${category.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    AchievementCategoryFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('Achievement_Category.dbc 已无可用 int32 ID');
    }
    return id;
  }
}
