import 'package:foxy/entity/creature_model_info.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureModelInfoRepository with RepositoryMixin {
  static const _table = 'creature_model_info';

  Future<List<CreatureModelInfo>> getCreatureModelInfos({
    String? id,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, id: id);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => CreatureModelInfo.fromJson(e.toMap())).toList();
  }

  Future<int> countCreatureModelInfos({String? id}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, id: id);
    return builder.count();
  }

  dynamic _applyFilter(dynamic builder, {String? id}) {
    if (id != null && id.isNotEmpty) {
      builder = builder.where('DisplayID', id);
    }
    return builder;
  }
}
