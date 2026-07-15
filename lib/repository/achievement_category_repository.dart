import 'package:foxy/entity/achievement_category_entity.dart';
import 'package:foxy/entity/achievement_category_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class AchievementCategoryRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_achievement_category';

  @override
  String get dbcLocaleTableName => _table;

  Future<List<BriefAchievementCategoryEntity>> getBriefAchievementCategories({
    int page = 1,
    AchievementCategoryFilterEntity? filter,
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

  Future<List<AchievementCategoryEntity>> getAchievementCategories() async {
    final rows = await laconic.table(_table).orderBy('ID').get();
    return rows
        .map((row) => AchievementCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<int> countAchievementCategories({
    AchievementCategoryFilterEntity? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<AchievementCategoryEntity?> getAchievementCategory(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    if (rows.isEmpty) return null;
    return AchievementCategoryEntity.fromJson(rows.first.toMap());
  }

  Future<AchievementCategoryEntity> createAchievementCategory() async {
    return AchievementCategoryEntity(id: await _getNextId());
  }

  Future<int> storeAchievementCategory(
    AchievementCategoryEntity category,
  ) async {
    final stored = category.id > 0
        ? category
        : category.copyWith(id: await _getNextId());
    await _validateParent(stored.parent);
    await _validateNoCycle(stored.id, stored.parent);
    await laconic.table(_table).insert([stored.toJson()]);
    return stored.id;
  }

  Future<void> updateAchievementCategory(
    AchievementCategoryEntity category,
  ) async {
    if (await getAchievementCategory(category.id) == null) {
      throw StateError('成就分类 ${category.id} 不存在');
    }
    await _validateParent(category.parent);
    await _validateNoCycle(category.id, category.parent);
    final json = category.toJson()..remove('ID');
    await laconic.table(_table).where('ID', category.id).update(json);
  }

  Future<void> destroyAchievementCategory(int id) async {
    final childCount = await laconic.table(_table).where('Parent', id).count();
    if (childCount > 0) {
      throw StateError('成就分类 $id 仍被 $childCount 个子分类引用，不能删除');
    }
    final achievementCount = await laconic
        .table('foxy.dbc_achievement')
        .where('Category', id)
        .count();
    if (achievementCount > 0) {
      throw StateError('成就分类 $id 仍被 $achievementCount 个成就引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyAchievementCategory(int id) async {
    final source = await getAchievementCategory(id);
    if (source == null) return;
    await storeAchievementCategory(source.copyWith(id: await _getNextId()));
  }

  Future<void> saveAchievementCategory(
    AchievementCategoryEntity category,
  ) async {
    if (category.id == 0 || await getAchievementCategory(category.id) == null) {
      await storeAchievementCategory(category);
      return;
    }
    await updateAchievementCategory(category);
  }

  Future<List<DbcLocaleFieldValue>> getAchievementCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveAchievementCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('Achievement_Category.dbc 已无可用 int32 ID');
    }
    return id;
  }

  Future<void> _validateParent(int parent) async {
    if (parent == -1) return;
    if (await getAchievementCategory(parent) == null) {
      throw ArgumentError.value(parent, 'Parent', '引用的成就分类不存在');
    }
  }

  Future<void> _validateNoCycle(int id, int firstParent) async {
    var current = firstParent;
    final visited = <int>{id};
    while (current != -1) {
      if (!visited.add(current)) {
        throw ArgumentError('Parent 形成循环引用');
      }
      final rows = await laconic
          .table(_table)
          .select(['Parent'])
          .where('ID', current)
          .limit(1)
          .get();
      if (rows.isEmpty) return;
      current = rows.first.toMap()['Parent'] as int? ?? -1;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    AchievementCategoryFilterEntity? filter,
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
}
