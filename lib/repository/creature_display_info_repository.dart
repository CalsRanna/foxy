import 'package:foxy/model/creature_display_info.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureDisplayInfoRepository with RepositoryMixin {
  // DBC 表在 foxy 数据库中
  final String _table = 'foxy.dbc_creature_display_info';
  final String _modelDataTable = 'foxy.dbc_creature_model_data';

  Future<int> count({String? id, String? modelName}) async {
    try {
      var builder = laconic.table('$_table AS cdi');
      builder = builder.leftJoin(
        '$_modelDataTable AS cmd',
        (join) => join.on('cdi.ModelID', 'cmd.ID'),
      );
      if (id != null && id.isNotEmpty) {
        builder = builder.where('cdi.ID', id);
      }
      if (modelName != null && modelName.isNotEmpty) {
        builder = builder.where(
          'cmd.ModelName',
          '%$modelName%',
          comparator: 'like',
        );
      }
      return await builder.count();
    } catch (e) {
      // 表可能不存在
      return 0;
    }
  }

  Future<List<CreatureDisplayInfo>> search({
    String? id,
    String? modelName,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table('$_table AS cdi');
      builder = builder.select([
        'cdi.ID',
        'cdi.ModelID',
        'cdi.SoundID',
        'cdi.ExtendedDisplayInfoID',
        'cdi.CreatureModelScale',
        'cmd.ModelName',
      ]);
      builder = builder.leftJoin(
        '$_modelDataTable AS cmd',
        (join) => join.on('cdi.ModelID', 'cmd.ID'),
      );
      if (id != null && id.isNotEmpty) {
        builder = builder.where('cdi.ID', id);
      }
      if (modelName != null && modelName.isNotEmpty) {
        builder = builder.where(
          'cmd.ModelName',
          '%$modelName%',
          comparator: 'like',
        );
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results
          .map((e) => CreatureDisplayInfo.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      // 表可能不存在
      return [];
    }
  }

  Future<CreatureDisplayInfo?> getById(int id) async {
    try {
      var builder = laconic.table('$_table AS cdi');
      builder = builder.select([
        'cdi.ID',
        'cdi.ModelID',
        'cdi.SoundID',
        'cdi.ExtendedDisplayInfoID',
        'cdi.CreatureModelScale',
        'cmd.ModelName',
      ]);
      builder = builder.leftJoin(
        '$_modelDataTable AS cmd',
        (join) => join.on('cdi.ModelID', 'cmd.ID'),
      );
      var result = await builder.where('cdi.ID', id).first();
      return CreatureDisplayInfo.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }
}
