import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'gossip_menu_option_locale_repository.g.dart';

@FoxyRepository(GossipMenuOptionLocaleEntity)
class GossipMenuOptionLocaleRepository
    with RepositoryMixin, _GossipMenuOptionLocaleRepositoryMixin {
  static const _table = 'gossip_menu_option_locale';
  static const primaryKeyColumns = {'MenuID', 'OptionID', 'Locale'};

  Future<void> copyGossipMenuOptionLocales(
    GossipMenuOptionKey sourceKey,
    GossipMenuOptionKey targetKey,
  ) async {
    final results = await laconic
        .table(_table)
        .where('MenuID', sourceKey.menuId)
        .where('OptionID', sourceKey.optionId)
        .get();
    if (results.isEmpty) return;
    final jsons = results.map((row) {
      final json = row.toMap();
      json['MenuID'] = targetKey.menuId;
      json['OptionID'] = targetKey.optionId;
      return json;
    }).toList();
    try {
      await laconic.table(_table).insert(jsons);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('复制后的本地化主键已存在，无法保存');
      }
      rethrow;
    }
  }

  Future<int> countGossipMenuOptionLocales() {
    return laconic.table(_table).count();
  }

  Future<GossipMenuOptionLocaleEntity> createGossipMenuOptionLocale({
    int menuId = 0,
    int optionId = 0,
    String locale = 'zhCN',
  }) async {
    return GossipMenuOptionLocaleEntity(
      menuId: menuId,
      optionId: optionId,
      locale: locale,
    );
  }

  Future<List<BriefGossipMenuOptionLocaleEntity>>
  getBriefGossipMenuOptionLocales({int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['MenuID', 'OptionID', 'Locale', 'OptionText'])
        .orderBy('MenuID')
        .orderBy('OptionID')
        .orderBy('Locale')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map(
          (result) =>
              BriefGossipMenuOptionLocaleEntity.fromJson(result.toMap()),
        )
        .toList();
  }

  Future<List<GossipMenuOptionLocaleEntity>>
  getGossipMenuOptionLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((result) => GossipMenuOptionLocaleEntity.fromJson(result.toMap()))
        .toList();
  }

  Future<List<GossipMenuOptionLocaleEntity>> getGossipMenuOptionLocales(
    int menuId,
  ) async {
    final results = await laconic.table(_table).where('MenuID', menuId).get();
    return results
        .map((result) => GossipMenuOptionLocaleEntity.fromJson(result.toMap()))
        .toList();
  }

  Future<List<GossipMenuOptionLocaleEntity>>
  getGossipMenuOptionLocalesForOption(GossipMenuOptionKey key) async {
    final results = await laconic
        .table(_table)
        .where('MenuID', key.menuId)
        .where('OptionID', key.optionId)
        .get();
    return results
        .map((result) => GossipMenuOptionLocaleEntity.fromJson(result.toMap()))
        .toList();
  }
}
