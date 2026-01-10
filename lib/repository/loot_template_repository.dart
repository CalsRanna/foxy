import 'package:foxy/model/loot_template.dart';
import 'package:foxy/repository/repository_mixin.dart';

enum LootTableType {
  creature('creature_loot_template'),
  pickpocket('pickpocketing_loot_template'),
  skinning('skinning_loot_template');

  final String tableName;
  const LootTableType(this.tableName);
}

class LootTemplateRepository with RepositoryMixin {
  final LootTableType tableType;

  LootTemplateRepository(this.tableType);

  String get _table => tableType.tableName;

  Future<int> count({String? entry}) async {
    try {
      var builder = laconic.table(_table);
      builder = builder.select(['DISTINCT Entry']);
      if (entry != null && entry.isNotEmpty) {
        builder = builder.where('Entry', entry);
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 获取不同的 Entry 列表（用于选择器）
  Future<List<LootTemplate>> searchDistinctEntries({
    String? entry,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table);
      builder = builder.select(['Entry', 'COUNT(*) as ItemCount']);
      if (entry != null && entry.isNotEmpty) {
        builder = builder.where('Entry', entry);
      }
      builder = builder.groupBy('Entry');
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) {
        var loot = LootTemplate();
        var map = e.toMap();
        loot.entry = (map['Entry'] ?? 0) as int;
        return loot;
      }).toList();
    } catch (e) {
      return [];
    }
  }

  /// 获取指定 Entry 的所有掉落项
  Future<List<LootTemplate>> getByEntry(int entry) async {
    try {
      var results = await laconic.table(_table).where('Entry', entry).get();
      return results.map((e) => LootTemplate.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }
}
