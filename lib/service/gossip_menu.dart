import 'package:foxy/model/gossip_menu.dart';
import 'package:foxy/service/service.dart';
import 'package:mysql_client/mysql_client.dart';

class GossipMenuService with Service {
  Future<int> count() async {
    const clause = [
      'SELECT count(*)',
      'FROM gossip_menu',
    ];
    final sql = clause.join(' ');
    var result = await execute(sql);
    return result.rows.first.typedColAt<int>(0) ?? 0;
  }

  Future<List<GossipMenu>> search({
    int page = 1,
    int pageSize = 50,
  }) async {
    const fields = [
      'gm.MenuID',
      'nt.text0_0',
      'nt.text0_1',
      'ntl.Text0_0',
      'ntl.Text0_1',
    ];
    final clauses = [
      'SELECT ${fields.join(', ')}',
      'FROM gossip_menu AS gm',
      'LEFT JOIN npc_text AS nt',
      'ON gm.TextID = nt.ID',
      'LEFT JOIN npc_text_locale AS ntl',
      'ON gm.TextID = ntl.ID AND ntl.Locale = "zhCN"',
      'LIMIT $pageSize',
      'OFFSET ${(page - 1) * pageSize}',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    return result.rows.map(_getGossipMenu).toList();
  }

  GossipMenu _getGossipMenu(ResultSetRow row) {
    final entry = row.typedColAt<int>(0) ?? 0;
    final rawText0 = row.typedColAt<String>(1) ?? '';
    final rawText1 = row.typedColAt<String>(2) ?? '';
    final localeText0 = row.typedColAt<String>(3) ?? '';
    final localeText1 = row.typedColAt<String>(4) ?? '';
    final text0 = localeText0.isNotEmpty ? localeText0 : rawText0;
    final text1 = localeText1.isNotEmpty ? localeText1 : rawText1;
    return GossipMenu()
      ..entry = entry
      ..text = text0.isNotEmpty ? text0 : text1;
  }
}
