import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/page/creature_template/creature_template_list_view_model.dart';
import 'package:foxy/widget/card.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/input.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:foxy/widget/table.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class CreatureTemplateListPage extends StatefulWidget {
  const CreatureTemplateListPage({super.key});

  @override
  State<CreatureTemplateListPage> createState() =>
      _CreatureTemplateListPageState();
}

class _CreatureTemplateListPageState extends State<CreatureTemplateListPage> {
  final viewModel = GetIt.instance.get<CreatureTemplateListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      _buildHeader(),
      _buildFilter(),
      Watch((_) => _buildTable()),
    ];
    return ListView(padding: EdgeInsets.all(16), children: children);
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  Widget _buildFilter() {
    final buttonChildren = [
      TextButton(onPressed: viewModel.search, child: Text('查询')),
      const SizedBox(width: 8),
      TextButton(onPressed: viewModel.reset, child: Text('重置')),
    ];
    var entryInput = FoxyInput(
      controller: viewModel.entryController,
      placeholder: '编号（entry）',
    );
    var nameInput = FoxyInput(
      controller: viewModel.nameController,
      placeholder: '姓名（name）',
    );
    var subNameInput = FoxyInput(
      controller: viewModel.subNameController,
      placeholder: '称号（subname）',
    );
    final credentialChildren = [
      Expanded(child: entryInput),
      const SizedBox(width: 16),
      Expanded(child: nameInput),
      const SizedBox(width: 16),
      Expanded(child: subNameInput),
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

  Widget _buildHeader() {
    const edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: FoxyHeader('生物列表'));
  }

  Widget _buildTable() {
    var row = Row(
      spacing: 4,
      children: [Icon(HugeIcons.strokeRoundedAdd01), Text('新增')],
    );
    var paddedRow = Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: row,
    );
    var filledButton = FilledButton(
      onPressed: () => viewModel.navigateCreatureTemplateDetailPage(context),
      child: paddedRow,
    );
    var pagination = FoxyPagination(
      page: viewModel.page.value,
      total: viewModel.total.value,
      onChange: viewModel.paginate,
    );
    final toolbarChildren = [filledButton, const Spacer(), pagination];
    final toolbar = Row(children: toolbarChildren);
    var tableHeaderChildren = [
      FoxyTableCell(width: 80, child: Text('编号')),
      FoxyTableCell(child: Text('姓名')),
      FoxyTableCell(child: Text('称号')),
      FoxyTableCell(width: 80, child: Text('最低等级')),
      FoxyTableCell(width: 80, child: Text('最高等级')),
    ];
    final header = FoxyTableHeader(children: tableHeaderChildren);
    var body = viewModel.templates.value.map(_buildTableTile).toList();
    var table = FoxyTable(header: header, body: body);
    if (viewModel.templates.value.isEmpty) {
      table = FoxyTable(header: header);
    }
    final column = Column(children: [toolbar, table]);
    return FoxyCard(child: Padding(padding: EdgeInsets.all(16), child: column));
  }

  FoxyTableRow _buildTableTile(BriefCreatureTemplate template) {
    final children = [
      FoxyTableCell(width: 80, child: Text(template.entry.toString())),
      FoxyTableCell(child: Text(template.name)),
      FoxyTableCell(child: Text(template.subName)),
      FoxyTableCell(width: 80, child: Text(template.minLevel.toString())),
      FoxyTableCell(width: 80, child: Text(template.maxLevel.toString())),
    ];
    return FoxyTableRow(
      onDoubleTap:
          () => viewModel.navigateCreatureTemplateDetailPage(
            context,
            entry: template.entry,
          ),
      children: children,
    );
  }
}
