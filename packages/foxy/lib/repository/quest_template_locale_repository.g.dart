// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_locale_repository.dart';

mixin _QuestTemplateLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestTemplateLocale(QuestTemplateLocaleKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('quest_template_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('quest_template_locale record not found');
    }
  }

  Future<QuestTemplateLocaleEntity?> getQuestTemplateLocale(
    QuestTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('quest_template_locale'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeQuestTemplateLocale(
    QuestTemplateLocaleEntity questTemplateLocale,
  ) async {
    await _beforeStore(questTemplateLocale);
    final json = prepareWriteJson(questTemplateLocale.toJson());
    try {
      await laconic.table('quest_template_locale').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questTemplateLocale.copyWith(
        id: await nextMaxPlusOne('quest_template_locale', '`ID`'),
      );
      try {
        await laconic.table('quest_template_locale').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in quest_template_locale');
        }
        rethrow;
      }
    }
  }

  Future<void> updateQuestTemplateLocale(
    QuestTemplateLocaleKey originalKey,
    QuestTemplateLocaleEntity questTemplateLocale,
  ) async {
    await _beforeUpdate(originalKey, questTemplateLocale);
    final json = prepareWriteJson(questTemplateLocale.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('quest_template_locale'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in quest_template_locale');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('quest_template_locale record not found');
    }
  }

  Future<void> _beforeDestroy(QuestTemplateLocaleKey key) async {}

  Future<void> _beforeStore(
    QuestTemplateLocaleEntity questTemplateLocale,
  ) async {}

  Future<void> _beforeUpdate(
    QuestTemplateLocaleKey originalKey,
    QuestTemplateLocaleEntity questTemplateLocale,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, QuestTemplateLocaleKey key) {
    var query = builder;
    query = query.where('`ID`', key.id);
    query = query.where('`locale`', key.locale);
    return query;
  }
}
