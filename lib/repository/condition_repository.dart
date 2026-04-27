import 'package:foxy/model/condition.dart';
import 'package:foxy/model/condition_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ConditionRepository with RepositoryMixin {
  static const _table = 'conditions';

  Future<List<Condition>> search({
    required ConditionFilterEntity filter,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => Condition.fromJson(e.toMap())).toList();
  }

  Future<int> count({required ConditionFilterEntity filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<Condition> find(Map<String, dynamic> credential) async {
    var builder = laconic.table(_table);
    for (final entry in credential.entries) {
      builder = builder.where(entry.key, entry.value);
    }
    var result = await builder.first();
    return Condition.fromJson(result.toMap());
  }

  Future<void> store(Condition condition) async {
    await laconic.table(_table).insert([condition.toJson()]);
  }

  Future<void> update(Map<String, dynamic> credential, Condition condition) async {
    var json = condition.toJson();
    // 移除主键字段，只更新非键字段
    json.remove('SourceTypeOrReferenceId');
    json.remove('SourceGroup');
    json.remove('SourceEntry');
    json.remove('SourceId');
    json.remove('ElseGroup');
    json.remove('ConditionTypeOrReference');
    json.remove('ConditionTarget');
    json.remove('ConditionValue1');
    json.remove('ConditionValue2');
    json.remove('ConditionValue3');

    var builder = laconic.table(_table);
    for (final entry in credential.entries) {
      builder = builder.where(entry.key, entry.value);
    }
    await builder.update(json);
  }

  Future<void> destroy(Map<String, dynamic> credential) async {
    var builder = laconic.table(_table);
    for (final entry in credential.entries) {
      builder = builder.where(entry.key, entry.value);
    }
    await builder.delete();
  }

  Future<void> copy(Map<String, dynamic> credential) async {
    var source = await find(credential);
    var json = source.toJson();
    json['ConditionValue3'] = (json['ConditionValue3'] as int) + 1;
    await laconic.table(_table).insert([json]);
  }

  dynamic _applyFilter(dynamic builder, ConditionFilterEntity filter) {
    if (filter.sourceTypeOrReferenceId.isNotEmpty) {
      builder = builder.where('SourceTypeOrReferenceId', filter.sourceTypeOrReferenceId);
    }
    if (filter.sourceEntry.isNotEmpty) {
      builder = builder.where('SourceEntry', filter.sourceEntry);
    }
    return builder;
  }
}
