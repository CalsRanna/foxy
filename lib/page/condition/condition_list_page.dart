import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/condition/condition_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ConditionListPage extends StatefulWidget {
  const ConditionListPage({super.key});

  @override
  State<ConditionListPage> createState() => _ConditionListPageState();
}

class _ConditionListPageState extends State<ConditionListPage> {
  final viewModel = GetIt.instance.get<ConditionListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyHeader('条件列表'),
          _buildFilter(),
          Expanded(child: Watch((_) => _buildTable())),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  Widget _buildFilter() {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: [
        Expanded(child: ShadInput(
          controller: viewModel.sourceTypeController,
          placeholder: Text('SourceTypeOrReferenceId'),
        )),
        Expanded(child: ShadInput(
          controller: viewModel.sourceEntryController,
          placeholder: Text('SourceEntry'),
        )),
        Expanded(flex: 2, child: Row(spacing: 16, children: [
          ShadButton(onPressed: viewModel.search, size: ShadButtonSize.sm, child: Text('查询')),
          ShadButton.ghost(onPressed: viewModel.reset, size: ShadButtonSize.sm, child: Text('重置')),
        ])),
      ]),
    );
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus),
      onPressed: () => viewModel.navigateToDetail(context),
      child: Text('新增'),
    );
    final items = viewModel.items.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;
    var pagination = FoxyPagination(page: page, pageSize: 50, total: total, onChange: viewModel.paginate);
    final toolbar = Row(children: [createButton, const Spacer(), pagination]);

    final headers = ['SourceType', 'SourceGroup', 'SourceEntry', 'SourceId', 'ElseGroup',
                     'ConditionType', 'CondTarget', 'Value1', 'Value2', 'Value3'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        return FoxyShadTable(
          builder: (context, vicinity) {
            final item = items[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.sourceTypeOrReferenceId.toString())),
              1 => ShadTableCell(child: Text(item.sourceGroup.toString())),
              2 => ShadTableCell(child: Text(item.sourceEntry.toString())),
              3 => ShadTableCell(child: Text(item.sourceId.toString())),
              4 => ShadTableCell(child: Text(item.elseGroup.toString())),
              5 => ShadTableCell(child: Text(item.conditionTypeOrReference.toString())),
              6 => ShadTableCell(child: Text(item.conditionTarget.toString())),
              7 => ShadTableCell(child: Text(item.conditionValue1.toString())),
              8 => ShadTableCell(child: Text(item.conditionValue2.toString())),
              9 => ShadTableCell(child: Text(item.conditionValue3.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(130),
              1 => FixedTableSpanExtent(130),
              2 => FixedTableSpanExtent(130),
              3 => FixedTableSpanExtent(100),
              4 => FixedTableSpanExtent(100),
              5 => FixedTableSpanExtent(130),
              6 => FixedTableSpanExtent(100),
              7 => FixedTableSpanExtent(100),
              8 => FixedTableSpanExtent(100),
              9 => FixedTableSpanExtent(100),
              _ => null,
            };
          },
          header: (context, index) => ShadTableCell.header(child: Text(headers[index])),
          onRowDoubleTap: (row) => viewModel.navigateToDetail(context, condition: items[row]),
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => viewModel.navigateToDetail(context, condition: items[row]),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.copyCondition(items[row]),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.deleteCondition(items[row]),
                  child: Text('删除'),
                ),
              ],
            );
          },
          pinnedRowCount: 1,
          rowCount: items.length,
        );
      },
    );

    return ShadCard(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(spacing: 16, children: [toolbar, Expanded(child: layoutBuilder)]),
    );
  }
}
