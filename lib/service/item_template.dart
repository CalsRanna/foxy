import 'package:foxy/model/item_template.dart';
import 'package:foxy/service/service.dart';
import 'package:mysql_client/mysql_client.dart';

class ItemTemplateService with Service {
  Future<List<ItemTemplate>> search({
    int page = 1,
    int pageSize = 50,
  }) async {
    const fields = [
      'it.entry',
      'it.name',
      'it.Quality',
      'it.class',
      'it.subclass',
      'it.InventoryType',
      'it.ItemLevel',
      'it.RequiredLevel',
      'itl.Name',
      // 'didi.InventoryIcon_1',
    ];
    final clauses = [
      'SELECT ${fields.join(', ')}',
      'FROM item_template AS it',
      'LEFT JOIN item_template_locale AS itl',
      'ON it.entry = itl.ID AND itl.locale = "zhCN"',
      // 'LEFT JOIN foxy.dbc_item_display_info as didi',
      // 'ON it.displayid = didi.ID',
      'LIMIT $pageSize',
      'OFFSET ${(page - 1) * pageSize}',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    return result.rows.map(_getCreatureTemplate).toList();
  }

  ItemTemplate _getCreatureTemplate(ResultSetRow row) {
    final entry = row.typedColAt<int>(0) ?? 0;
    final rawName = row.typedColAt<String>(1) ?? '';
    final quality = row.typedColAt<int>(2) ?? 0;
    final className = row.typedColAt<int>(3) ?? 0;
    final subclass = row.typedColAt<int>(4) ?? 0;
    final inventoryType = row.typedColAt<int>(5) ?? 0;
    final itemLevel = row.typedColAt<int>(6) ?? 0;
    final requiredLevel = row.typedColAt<int>(7) ?? 0;
    final localeName = row.typedColAt<String>(8) ?? '';
    // final inventoryIcon = row.typedColAt<String>(9) ?? '';
    final name = localeName.isNotEmpty ? localeName : rawName;
    return ItemTemplate()
      ..entry = entry
      ..name = name
      ..quality = quality
      ..className = className
      ..subclass = subclass
      ..inventoryType = inventoryType
      ..itemLevel = itemLevel
      ..requiredLevel = requiredLevel;
    // ..inventoryIcon = inventoryIcon;
  }

  Future<int> count() async {
    const clause = [
      'SELECT count(*)',
      'FROM item_template',
    ];
    final sql = clause.join(' ');
    var result = await execute(sql);
    return result.rows.first.typedColAt<int>(0) ?? 0;
  }
}
