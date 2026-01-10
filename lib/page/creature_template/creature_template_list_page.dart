import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
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
      FoxyHeader('生物列表'),
      _buildFilter(),
      Expanded(child: Watch((_) => _buildTable())),
    ];
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: children,
    );
    return Padding(padding: const EdgeInsets.all(16.0), child: column);
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  Widget _buildFilter() {
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
    final buttonChildren = [
      ShadButton(onPressed: viewModel.search, child: Text('查询')),
      ShadButton.ghost(onPressed: viewModel.reset, child: Text('重置')),
    ];
    var row = Row(spacing: 16, children: buttonChildren);
    final credentialChildren = [
      Expanded(child: entryInput),
      Expanded(child: nameInput),
      Expanded(child: subNameInput),
      Expanded(child: row),
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: credentialChildren),
    );
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus),
      onPressed: () => viewModel.navigateCreatureTemplateDetailPage(context),
      child: Text('新增'),
    );
    final templates = viewModel.templates.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;
    var pagination = FoxyPagination(
      page: page,
      pageSize: 50,
      total: total,
      onChange: viewModel.paginate,
    );
    final toolbarChildren = [createButton, const Spacer(), pagination];
    final toolbar = Row(children: toolbarChildren);

    final headers = ['编号', '姓名', '称号', '最低等级', '最高等级'];
    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth - 360;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final template = templates[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(template.entry.toString())),
              1 => ShadTableCell(child: Text(template.displayName)),
              2 => ShadTableCell(child: Text(template.displaySubName)),
              3 => ShadTableCell(child: Text(template.minLevel.toString())),
              4 => ShadTableCell(child: Text(template.maxLevel.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(width / 2),
              2 => FixedTableSpanExtent(width / 2),
              3 => FixedTableSpanExtent(120),
              4 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowDoubleTap: (row) {
            viewModel.navigateCreatureTemplateDetailPage(
              context,
              entry: templates[row].entry,
            );
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    viewModel.navigateCreatureTemplateDetailPage(
                      context,
                      entry: templates[row].entry,
                    );
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () {
                    viewModel.copyCreatureTemplate(templates[row].entry);
                  },
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () {
                    viewModel.deleteCreatureTemplate(templates[row].entry);
                  },
                  child: Text('删除'),
                ),
              ],
            );
          },
          pinnedRowCount: 1,
          rowCount: templates.length,
        );
      },
    );

    var children = [toolbar, Expanded(child: layoutBuilder)];
    final column = Column(spacing: 16, children: children);
    return ShadCard(padding: EdgeInsets.fromLTRB(16, 16, 16, 0), child: column);
  }
}
