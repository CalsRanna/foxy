import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/skill_line_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'skill_line_repository.g.dart';

@FoxyRepository(SkillLineEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class SkillLineRepository with RepositoryMixin, _SkillLineRepositoryMixin {
  static const _table = 'foxy.dbc_skill_line';

  Future<int> copySkillLine(int key) async {
    final source = await getSkillLine(key);
    if (source == null) {
      throw StateError('原技能线不存在，可能已被其他操作修改或删除');
    }
    final copied = SkillLineEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeSkillLine(copied);
    return copied.id;
  }

  Future<int> countSkillLines({SkillLineFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<SkillLineEntity> createSkillLine() async =>
      SkillLineEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefSkillLineEntity>> getBriefSkillLines({
    int page = 1,
    SkillLineFilter? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'CategoryID',
      'DisplayName_lang_zhCN AS displayNameZhCN',
    ]);
    builder = _applyFilter(builder, filter).orderBy('ID');
    final rows = await builder
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefSkillLineEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<SkillLineEntity>> getSkillLines() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => SkillLineEntity.fromJson(row.toMap())).toList();
  }

  Future<void> storeSkillLine(SkillLineEntity skillLine) async {
    if (skillLine.id <= 0) {
      throw StateError('技能线 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([skillLine.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('技能线 ${skillLine.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SkillLineFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'DisplayName_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
