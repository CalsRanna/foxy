// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_addon_repository.dart';

mixin _QuestTemplateAddonRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestTemplateAddon(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('quest_template_addon'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('quest_template_addon record not found');
    }
  }

  Future<QuestTemplateAddonEntity?> getQuestTemplateAddon(int key) async {
    final results = await _whereKey(
      laconic.table('quest_template_addon'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<int> storeQuestTemplateAddon(
    QuestTemplateAddonEntity questTemplateAddon,
  ) async {
    if (questTemplateAddon.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(questTemplateAddon);
    final json = prepareWriteJson(questTemplateAddon.toJson());
    try {
      await laconic.table('quest_template_addon').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questTemplateAddon.copyWith(
        id: await nextMaxPlusOne('quest_template_addon', '`ID`'),
      );
      try {
        await laconic.table('quest_template_addon').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in quest_template_addon');
        }
        rethrow;
      }
    }
    return questTemplateAddon.id;
  }

  Future<void> updateQuestTemplateAddon(
    int originalKey,
    QuestTemplateAddonEntity questTemplateAddon,
  ) async {
    await _beforeUpdate(originalKey, questTemplateAddon);
    final json = prepareWriteJson(questTemplateAddon.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('quest_template_addon'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in quest_template_addon');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('quest_template_addon record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    QuestTemplateAddonEntity questTemplateAddon,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestTemplateAddonEntity questTemplateAddon,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
