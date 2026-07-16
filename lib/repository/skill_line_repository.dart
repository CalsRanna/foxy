import 'package:foxy/entity/skill_line_entity.dart';
import 'package:foxy/entity/skill_line_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SkillLineRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_skill_line';

  Future<void> copySkillLine(int id) async {
    final source = await getSkillLine(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<int> countSkillLines({SkillLineFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<SkillLineEntity> createSkillLine() async =>
      SkillLineEntity(id: await _getNextId());

  Future<void> destroySkillLine(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefSkillLineEntity>> getBriefSkillLines({
    int page = 1,
    SkillLineFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'CategoryID',
      'DisplayName_lang_zhCN',
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

  Future<SkillLineEntity?> getSkillLine(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty ? null : SkillLineEntity.fromJson(rows.first.toMap());
  }

  Future<List<SkillLineEntity>> getSkillLines() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => SkillLineEntity.fromJson(row.toMap())).toList();
  }

  Future<void> saveSkillLine(SkillLineEntity skillLine) async {
    if (await getSkillLine(skillLine.id) == null) {
      await storeSkillLine(skillLine);
    } else {
      await updateSkillLine(skillLine);
    }
  }

  Future<int> storeSkillLine(SkillLineEntity skillLine) async {
    final json = skillLine.toJson();
    final id = skillLine.id > 0 ? skillLine.id : await _getNextId();
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateSkillLine(SkillLineEntity skillLine) async {
    final json = skillLine.toJson()..remove('ID');
    await laconic.table(_table).where('ID', skillLine.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SkillLineFilterEntity? filter,
  ) {
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

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');
}
