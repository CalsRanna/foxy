// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_addon_repository.dart';

mixin _QuestTemplateAddonRepositoryMixin on RepositoryMixin {
  String get _table => 'quest_template_addon';

  Future<void> destroyQuestTemplateAddon(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException('quest_template_addon record not found');
    }
  }

  Future<QuestTemplateAddonEntity?> getQuestTemplateAddon(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
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
      await trackActivityWrite(
        _table,
        afterKey: activityKey(questTemplateAddon.id),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questTemplateAddon.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(retried.id),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
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
    final values = questTemplateAddon.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(questTemplateAddon.id),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
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

  Map<String, Object?> activityKey(int key) => {'ID': key};

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
