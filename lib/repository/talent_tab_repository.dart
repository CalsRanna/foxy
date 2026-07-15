import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/talent_tab_entity.dart';
import 'package:foxy/entity/talent_tab_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class TalentTabRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_talent_tab';

  @override
  String get dbcLocaleTableName => _table;

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

  Future<List<TalentTabEntity>> getTalentTabs() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => TalentTabEntity.fromJson(row.toMap())).toList();
  }

  Future<int> countTalentTabs({TalentTabFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<TalentTabEntity?> getTalentTab(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty ? null : TalentTabEntity.fromJson(rows.first.toMap());
  }

  Future<TalentTabEntity> createTalentTab() async {
    return TalentTabEntity(id: await _getNextId());
  }

  Future<int> storeTalentTab(TalentTabEntity talentTab) async {
    final id = talentTab.id > 0 ? talentTab.id : await _getNextId();
    final stored = talentTab.copyWith(id: id);
    stored.validate();
    await _validateSpellIcon(stored, preserveExisting: false);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateTalentTab(TalentTabEntity talentTab) async {
    talentTab.validate();
    await _validateSpellIcon(talentTab, preserveExisting: true);
    final json = talentTab.toJson()..remove('ID');
    await laconic.table(_table).where('ID', talentTab.id).update(json);
  }

  Future<void> destroyTalentTab(int id) async {
    final references = await laconic
        .table('foxy.dbc_talent')
        .where('TabID', id)
        .count();
    if (references > 0) {
      throw StateError('天赋页 $id 仍被 $references 条天赋引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyTalentTab(int id) async {
    final source = await getTalentTab(id);
    if (source == null) return;
    await storeTalentTab(source.copyWith(id: await _getNextId()));
  }

  Future<void> saveTalentTab(TalentTabEntity talentTab) async {
    final existing = talentTab.id == 0
        ? null
        : await getTalentTab(talentTab.id);
    if (existing == null) {
      await storeTalentTab(talentTab);
    } else {
      await updateTalentTab(talentTab);
    }
  }

  Future<List<DbcLocaleFieldValue>> getTalentTabLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveTalentTabLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('TalentTab ID 已超出 DBC int32 范围');
    }
    return id;
  }

  Future<void> _validateSpellIcon(
    TalentTabEntity talentTab, {
    required bool preserveExisting,
  }) async {
    if (talentTab.spellIconId == 0) return;
    final references = await laconic
        .table('foxy.dbc_spell_icon')
        .where('ID', talentTab.spellIconId)
        .count();
    if (references > 0) return;
    if (preserveExisting) {
      final existing = await getTalentTab(talentTab.id);
      if (existing?.spellIconId == talentTab.spellIconId) return;
    }
    throw StateError('SpellIconID 引用的法术图标 ${talentTab.spellIconId} 不存在');
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
}
