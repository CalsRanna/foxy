import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/model/game_object_template.dart';
import 'package:foxy/widget/card.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/input.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:foxy/widget/table.dart';

@RoutePage()
class GameObjectTemplateListPage extends StatelessWidget {
  const GameObjectTemplateListPage({super.key});

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
    return Padding(padding: edgeInsets, child: FoxyHeader('游戏对象列表'));
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

  Widget _buildData(List<GameObjectTemplate> templates) {
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
    return FoxyTableHeader(
      children: [
        FoxyTableCell(width: 80, child: Text('编号')),
        FoxyTableCell(child: Text('名称')),
        FoxyTableCell(width: 80, child: Text('类型')),
        FoxyTableCell(width: 80, child: Text('尺寸')),
      ],
    );
  }

  FoxyTableRow _buildRow(GameObjectTemplate template) {
    final children = [
      FoxyTableCell(width: 80, child: Text(template.entry.toString())),
      FoxyTableCell(child: Text(template.name)),
      FoxyTableCell(width: 80, child: Text(template.type.toString())),
      FoxyTableCell(width: 80, child: Text(template.size.toString())),
    ];
    return FoxyTableRow(children: children);
  }
}
