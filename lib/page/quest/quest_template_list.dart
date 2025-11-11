import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/model/quest_template.dart';
import 'package:foxy/widget/card.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/input.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:foxy/widget/table.dart';

@RoutePage()
class QuestTemplateListPage extends StatelessWidget {
  const QuestTemplateListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [_Header(), _Filter(), _Table()];
    return ListView(padding: EdgeInsets.all(16), children: children);
  }
}

class _Filter extends StatelessWidget {
  const _Filter();

  @override
  Widget build(BuildContext context) {
    final buttonChildren = [
      TextButton(onPressed: () {}, child: Text('查询')),
      const SizedBox(width: 8),
      TextButton(onPressed: () => reset(), child: Text('重置')),
    ];
    final credentialChildren = [
      Expanded(child: FoxyInput(placeholder: '编号（Entry）')),
      const SizedBox(width: 16),
      Expanded(child: FoxyInput(placeholder: '名称（Name）')),
      const SizedBox(width: 16),
      Expanded(child: FoxyInput(placeholder: '称号（Sub Name）')),
      const SizedBox(width: 16),
      Expanded(child: Row(children: buttonChildren)),
    ];
    final filter = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: credentialChildren),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FoxyCard(child: filter),
    );
  }

  Future<void> reset() async {}
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: FoxyHeader('任务列表'));
  }
}

class _Pagination extends StatelessWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context) {
    return FoxyPagination(total: 0, onChange: (page) => handleChange(page));
  }

  void handleChange(int page) {}
}

class _Table extends StatelessWidget {
  const _Table();

  @override
  Widget build(BuildContext context) {
    return _buildData([]);
  }

  Widget _buildData(List<QuestTemplate> templates) {
    final children = [
      FilledButton(onPressed: () {}, child: Text('新增')),
      const Spacer(),
      _Pagination(),
    ];
    final toolbar = Row(children: children);
    final header = _buildHeader();
    final body = templates.map(_buildRow).toList();
    final table = FoxyTable(header: header, body: body);
    final column = Column(children: [toolbar, table]);
    return FoxyCard(
      child: Padding(padding: EdgeInsets.all(16), child: column),
    );
  }

  FoxyTableHeader _buildHeader() {
    var children = [
      FoxyTableCell(width: 80, child: Text('编号')),
      FoxyTableCell(width: 120, child: Text('标题')),
      FoxyTableCell(child: Text('描述')),
      FoxyTableCell(width: 80, child: Text('类型')),
      FoxyTableCell(width: 80, child: Text('等级')),
      FoxyTableCell(width: 80, child: Text('最低等级')),
    ];
    return FoxyTableHeader(children: children);
  }

  FoxyTableRow _buildRow(QuestTemplate template) {
    final children = [
      FoxyTableCell(width: 80, child: Text(template.entry.toString())),
      FoxyTableCell(width: 120, child: Text(template.title)),
      FoxyTableCell(child: Text(template.description)),
      FoxyTableCell(width: 80, child: Text(template.type.toString())),
      FoxyTableCell(width: 80, child: Text(template.level.toString())),
      FoxyTableCell(width: 80, child: Text(template.minLevel.toString())),
    ];
    return FoxyTableRow(children: children);
  }
}
