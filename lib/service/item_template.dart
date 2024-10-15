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
      'it.class',
      'it.subclass',
      'it.name',
      'it.displayid',
      'it.InventoryType',
      'it.ItemLevel',
      'it.RequiredLevel',
      'itl.Name',
    ];
    final clauses = [
      'SELECT ${fields.join(', ')}',
      'FROM item_template AS it',
      'LEFT JOIN item_template_locale AS itl',
      'ON it.entry = itl.ID AND ctl.locale = "zhCN"',
      'LIMIT $pageSize',
      'OFFSET ${(page - 1) * pageSize}',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    return result.rows.map(_getCreatureTemplate).toList();
  }

  ItemTemplate _getCreatureTemplate(ResultSetRow row) {
    final entry = row.typedColAt<int>(0) ?? 0;
    final className = row.typedColAt<int>(1) ?? 0;
    final subclass = row.typedColAt<int>(2) ?? 0;
    final rawName = row.typedColAt<String>(3) ?? '';
    final displayId = row.typedColAt<int>(4) ?? 0;
    final inventoryType = row.typedColAt<int>(5) ?? 0;
    final itemLevel = row.typedColAt<int>(6) ?? 0;
    final requiredLevel = row.typedColAt<int>(7) ?? 0;
    final localeName = row.typedColAt<String>(8) ?? '';
    final name = localeName.isNotEmpty ? localeName : rawName;
    return ItemTemplate()
      ..entry = entry
      ..className = className
      ..subclass = subclass
      ..displayId = displayId
      ..itemLevel = itemLevel
      ..quality = 0
      ..name = name;
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
