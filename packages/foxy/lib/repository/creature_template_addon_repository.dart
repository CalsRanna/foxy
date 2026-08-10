import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_template_addon_repository.g.dart';

@FoxyRepository()
class CreatureTemplateAddonRepository
    with RepositoryMixin, _CreatureTemplateAddonRepositoryMixin {
  Future<int> copyCreatureTemplateAddon(int key) async {
    final source = await getCreatureTemplateAddon(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
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
