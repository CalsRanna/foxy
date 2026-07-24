import 'package:foxy/entity/talent_tab_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/talent_tab_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class TalentTabRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_talent_tab';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyTalentTab(int key) async {
    final source = await getTalentTab(key);
    if (source == null) {
      throw StateError('原天赋页不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeTalentTab(copied);
    return copied.id;
  }

  Future<int> countTalentTabs({TalentTabFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<TalentTabEntity> createTalentTab() async {
    return TalentTabEntity(id: await _getNextId());
  }

  Future<void> destroyTalentTab(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原天赋页不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefTalentTabEntity>> getBriefTalentTabs({
    int page = 1,
    TalentTabFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'Name_lang_zhCN',
      'ClassMask',
      'CategoryEnumID',
      'OrderIndex',
    ]);
    builder = _applyFilter(builder, filter);
    final rows = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefTalentTabEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<TalentTabEntity?> getTalentTab(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty ? null : TalentTabEntity.fromJson(rows.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getTalentTabLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<TalentTabEntity>> getTalentTabs() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => TalentTabEntity.fromJson(row.toMap())).toList();
  }

  Future<void> saveTalentTabLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeTalentTab(TalentTabEntity talentTab) async {
    if (talentTab.id <= 0) {
      throw StateError('天赋页 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([talentTab.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('天赋页 ${talentTab.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateTalentTab(
    int originalKey,
    TalentTabEntity talentTab,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(talentTab.toJson());
      if (matchedRows == 0) {
        throw StateError('原天赋页不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的天赋页 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    TalentTabFilterEntity? filter,
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
      throw StateError('TalentTab ID 已超出 DBC int32 范围');
    }
    return id;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
