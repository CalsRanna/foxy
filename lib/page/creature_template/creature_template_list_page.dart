import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_list_view_model.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
      const SizedBox(height: 16),
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
      ShadButton(onPressed: viewModel.search, child: Text('查询')),
      const SizedBox(width: 8),
      ShadButton.ghost(onPressed: viewModel.reset, child: Text('重置')),
    ];
    var entryInput = ShadInput(
      controller: viewModel.entryController,
      placeholder: Text('编号（entry）'),
    );
    var nameInput = ShadInput(
      controller: viewModel.nameController,
      placeholder: Text('姓名（name）'),
    );
    var subNameInput = ShadInput(
      controller: viewModel.subNameController,
      placeholder: Text('称号（subname）'),
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
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(children: credentialChildren),
    );
  }

  Widget _buildHeader() {
    const edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: FoxyHeader('生物列表'));
  }

  Widget _buildTable() {
    final templates = viewModel.templates.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;

    var filledButton = ShadButton(
      leading: Icon(LucideIcons.plus),
      onPressed: () => viewModel.navigateCreatureTemplateDetailPage(context),
      child: Text('新增'),
    );
    var pagination = FoxyPagination(
      page: page,
      total: total,
      onChange: viewModel.paginate,
    );
    final toolbarChildren = [filledButton, const Spacer(), pagination];
    final toolbar = Row(children: toolbarChildren);

    Widget table;
    if (templates.isEmpty) {
      table = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.inbox, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              '暂无数据',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    } else {
      table = LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth - 560;
          return ShadTable.list(
            columnSpanExtent: (index) {
              return switch (index) {
                0 => FixedTableSpanExtent(80),
                1 => FixedTableSpanExtent(240),
                2 => FixedTableSpanExtent(width),
                3 => FixedTableSpanExtent(120),
                4 => FixedTableSpanExtent(120),
                _ => null,
              };
            },
            header: const [
              ShadTableCell.header(child: Text('编号')),
              ShadTableCell.header(child: Text('姓名')),
              ShadTableCell.header(child: Text('称号')),
              ShadTableCell.header(child: Text('最低等级')),
              ShadTableCell.header(child: Text('最高等级')),
            ],
            onRowTap: (row) {
              viewModel.navigateCreatureTemplateDetailPage(context);
            },
            pinnedRowCount: 1,
            children: templates.map((template) {
              return [
                ShadTableCell(child: Text(template.entry.toString())),
                ShadTableCell(child: Text(template.name)),
                ShadTableCell(child: Text(template.subName)),
                ShadTableCell(child: Text(template.minLevel.toString())),
                ShadTableCell(child: Text(template.maxLevel.toString())),
              ];
            }),
          );
        },
      );
    }

    final column = Column(
      spacing: 16,
      children: [
        toolbar,
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 300,
          ),
          child: table,
        ),
      ],
    );
    return ShadCard(padding: EdgeInsets.all(16), child: column);
  }
}
