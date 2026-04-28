import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/reference_loot_template/reference_loot_template_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ReferenceLootTemplateListPage extends StatefulWidget {
  const ReferenceLootTemplateListPage({super.key});

  @override
  State<ReferenceLootTemplateListPage> createState() =>
      _ReferenceLootTemplateListPageState();
}

class _ReferenceLootTemplateListPageState
    extends State<ReferenceLootTemplateListPage> {
  final viewModel = GetIt.instance.get<ReferenceLootTemplateListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('关联掉落列表'),
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
      placeholder: Text('Entry'),
    );
    var nameInput = ShadInput(
      controller: viewModel.nameController,
      placeholder: Text('Item'),
    );
    var searchButton = ShadButton(
      onPressed: viewModel.search,
      size: ShadButtonSize.sm,
      child: Text('查询'),
    );
    var resetButton = ShadButton.ghost(
      onPressed: viewModel.reset,
      size: ShadButtonSize.sm,
      child: Text('重置'),
    );
    var row = Row(spacing: 16, children: [searchButton, resetButton]);
    final credentialChildren = [
      Expanded(child: entryInput),
      Expanded(child: nameInput),
      Expanded(child: SizedBox()),
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
      onPressed: () => viewModel.navigateToDetail(),
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

    final headers = ['Entry', '物品ID', '物品名称', '几率', '数量', '任务', '组'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var width = maxWidth - 600;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final template = templates[vicinity.row];
            final qualityColor =
                kItemQualityColors[template.itemQuality] ?? Colors.white;
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(template.entry.toString())),
              1 => ShadTableCell(child: Text(template.item.toString())),
              2 => ShadTableCell(
                child: Text(
                  template.displayName,
                  style: TextStyle(color: qualityColor),
                ),
              ),
              3 => ShadTableCell(child: Text('${template.chance}%')),
              4 => ShadTableCell(
                child: Text('${template.minCount}-${template.maxCount}'),
              ),
              5 => ShadTableCell(child: Text(template.questRequired ? '是' : '否')),
              6 => ShadTableCell(child: Text(template.groupId.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(120),
              2 => FixedTableSpanExtent(width),
              3 => FixedTableSpanExtent(120),
              4 => FixedTableSpanExtent(120),
              5 => FixedTableSpanExtent(120),
              6 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowDoubleTap: (row) {
            viewModel.navigateToDetail(
              entry: templates[row].entry,
              item: templates[row].item,
              label: '${templates[row].entry}-${templates[row].item}',
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
                    viewModel.navigateToDetail(
                      entry: templates[row].entry,
                      item: templates[row].item,
                      label: '${templates[row].entry}-${templates[row].item}',
                    );
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.copyReferenceLootTemplate(templates[row].entry, templates[row].item),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () =>
                      viewModel.deleteReferenceLootTemplate(templates[row].entry, templates[row].item),
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
