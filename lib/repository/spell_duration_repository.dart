import 'package:foxy/entity/spell_duration_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellDurationRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell_duration';

  Future<List<SpellDurationEntity>> getSpellDurations({
    String? id,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, id: id);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => SpellDurationEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countSpellDurations({String? id}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, id: id);
    return builder.count();
  }

  dynamic _applyFilter(dynamic builder, {String? id}) {
    if (id != null && id.isNotEmpty) {
      builder = builder.where('ID', id);
    }
    return builder;
  }
}
