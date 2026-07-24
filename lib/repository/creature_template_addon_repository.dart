import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_template_addon_repository.g.dart';

@FoxyRepository(CreatureTemplateAddonEntity)
class CreatureTemplateAddonRepository
    with RepositoryMixin, _CreatureTemplateAddonRepositoryMixin {
  static const _table = 'creature_template_addon';

  Future<int> copyCreatureTemplateAddon(int key) async {
    final source = await getCreatureTemplateAddon(key);
    if (source == null) {
      throw StateError('原生物模板附加数据不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(
      entry: await nextMaxPlusOne(_table, 'entry'),
    );
    await storeCreatureTemplateAddon(copied);
    return copied.entry;
  }

  Future<int> countCreatureTemplateAddons() {
    return laconic.table(_table).count();
  }

  Future<CreatureTemplateAddonEntity> createCreatureTemplateAddon([
    int? entry,
  ]) async {
    return CreatureTemplateAddonEntity(
      entry: entry ?? await nextMaxPlusOne(_table, 'entry'),
    );
  }

  Future<List<BriefCreatureTemplateAddonEntity>>
  getBriefCreatureTemplateAddons({int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['entry', 'path_id', 'mount', 'emote', 'auras'])
        .orderBy('entry')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefCreatureTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<CreatureTemplateAddonEntity>> getCreatureTemplateAddons() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => CreatureTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }
}
