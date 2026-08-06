// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_addon_repository.dart';

mixin _CreatureTemplateAddonRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureTemplateAddon(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_template_addon'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('creature_template_addon record not found');
    }
  }

  Future<CreatureTemplateAddonEntity?> getCreatureTemplateAddon(int key) async {
    final results = await _whereKey(
      laconic.table('creature_template_addon'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<int> storeCreatureTemplateAddon(
    CreatureTemplateAddonEntity creatureTemplateAddon,
  ) async {
    if (creatureTemplateAddon.entry <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(creatureTemplateAddon);
    final json = prepareWriteJson(creatureTemplateAddon.toJson());
    try {
      await laconic.table('creature_template_addon').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureTemplateAddon.copyWith(
        entry: await nextMaxPlusOne('creature_template_addon', '`entry`'),
      );
      try {
        await laconic.table('creature_template_addon').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.entry;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in creature_template_addon',
          );
        }
        rethrow;
      }
    }
    return creatureTemplateAddon.entry;
  }

  Future<void> updateCreatureTemplateAddon(
    int originalKey,
    CreatureTemplateAddonEntity creatureTemplateAddon,
  ) async {
    await _beforeUpdate(originalKey, creatureTemplateAddon);
    final json = prepareWriteJson(creatureTemplateAddon.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_template_addon'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in creature_template_addon');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('creature_template_addon record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    CreatureTemplateAddonEntity creatureTemplateAddon,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureTemplateAddonEntity creatureTemplateAddon,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`entry`', key);
  }
}
