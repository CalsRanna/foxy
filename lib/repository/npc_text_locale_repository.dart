import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class NpcTextLocaleRepository with RepositoryMixin {
  static const _table = 'npc_text_locale';
  static const primaryKeyColumns = {'ID', 'Locale'};

  Future<int> countNpcTextLocales({required int id}) async {
    return laconic.table(_table).where('ID', id).count();
  }

  Future<NpcTextLocaleEntity> createNpcTextLocale(
    int id, {
    String locale = '',
  }) async {
    return NpcTextLocaleEntity(id: id, locale: locale);
  }

  Future<void> destroyNpcTextLocale(NpcTextLocaleKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原 NPC 文本本地化记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefNpcTextLocaleEntity>> getBriefNpcTextLocales({
    required int id,
    int page = 1,
  }) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'Locale'])
        .where('ID', id)
        .orderBy('Locale')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefNpcTextLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<NpcTextLocaleEntity?> getNpcTextLocale(NpcTextLocaleKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return NpcTextLocaleEntity.fromJson(results.first.toMap());
  }

  Future<List<NpcTextLocaleEntity>> getNpcTextLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results.map((e) => NpcTextLocaleEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeNpcTextLocale(NpcTextLocaleEntity model) async {
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('NPC 文本本地化主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateNpcTextLocale(
    NpcTextLocaleKey originalKey,
    NpcTextLocaleEntity model,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(model.toJson());
      if (matchedRows == 0) {
        throw StateError('原 NPC 文本本地化记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的 NPC 文本本地化主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, NpcTextLocaleKey key) {
    return builder.where('ID', key.id).where('Locale', key.locale);
  }
}
