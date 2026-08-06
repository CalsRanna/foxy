import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_loot_template_repository.g.dart';

@FoxyRepository(SpellLootTemplateEntity, linkKey: ['entry'], autoIncrementKey: 'item')
class SpellLootTemplateRepository
    with RepositoryMixin, _SpellLootTemplateRepositoryMixin {
  static const _table = 'spell_loot_template';
  static const primaryKeyColumns = {'Entry', 'Item'};

  @override
  Future<SpellLootTemplateKey> copySpellLootTemplate(
    SpellLootTemplateKey key,
  ) async {
    throw CopyNotSupportedException(
      'spell loot records cannot be auto-copied; add a new record and select a valid item or reference template',
    );
  }

  @override
  Future<int> countSpellLootTemplates(int entry) {
    return laconic.table(_table).where('Entry', entry).count();
  }

  @override
  Future<SpellLootTemplateEntity> createSpellLootTemplate(int entry) async {
    return SpellLootTemplateEntity(entry: entry);
  }

  @override
  Future<List<BriefSpellLootTemplateEntity>> getBriefSpellLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table as slt');
    final fields = <String>[
      'slt.Entry',
      'slt.Item',
      'slt.Reference',
      'slt.Chance',
      'slt.QuestRequired',
      'slt.LootMode',
      'slt.GroupId',
      'slt.MinCount',
      'slt.MaxCount',
      'slt.Comment',
      'it.name as itemName',
      if (localeEnabled) 'itl.Name as localeName',
      'it.Quality as quality',
      'didi.InventoryIcon0 as icon',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template as it',
      (join) => join.on('slt.Item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale as itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.where('slt.Entry', entry);
    builder = builder.orderBy('slt.Item');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefSpellLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }
}
