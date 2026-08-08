import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/talent_tab_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'talent_tab_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class TalentTabRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _TalentTabRepositoryMixin {
  static const _table = 'foxy.dbc_talent_tab';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyTalentTab(int key) async {
    final source = await getTalentTab(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeTalentTab(copied);
    return copied.id;
  }

  Future<int> countTalentTabs({TalentTabFilter? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<TalentTabEntity> createTalentTab() async {
    return TalentTabEntity(id: await _getNextId());
  }

  Future<List<BriefTalentTabEntity>> getBriefTalentTabs({
    int page = 1,
    TalentTabFilter? filter,
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

  QueryBuilder _applyFilter(QueryBuilder builder, TalentTabFilter? filter) {
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
      throw IdExhaustedException('TalentTab ID exceeds DBC int32 range');
    }
    return id;
  }
}
