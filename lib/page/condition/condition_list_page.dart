import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/condition/condition_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
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
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

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
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: ShadInput(
              controller: viewModel.sourceTypeController,
              placeholder: Text('SourceTypeOrReferenceId'),
            ),
          ),
          Expanded(
            child: ShadInput(
              controller: viewModel.sourceEntryController,
              placeholder: Text('SourceEntry'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              spacing: 16,
              children: [
                ShadButton(
                  onPressed: viewModel.search,
                  size: ShadButtonSize.sm,
                  child: Text('查询'),
                ),
                ShadButton.ghost(
                  onPressed: viewModel.reset,
                  size: ShadButtonSize.sm,
                  child: Text('重置'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus, size: 16),
      onPressed: () => viewModel.navigateToDetail(),
      child: Text('新增'),
    );
    final conditions = viewModel.conditions.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;
    var pagination = FoxyPagination(
      page: page,
      pageSize: 50,
      total: total,
      onChange: viewModel.paginate,
    );
    final toolbar = Row(children: [createButton, const Spacer(), pagination]);

    final headers = ['来源条目', '来源类型', '条件类型', '参数1', '说明'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var flexWidth = constraints.maxWidth - 120;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final condition = conditions[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(condition.sourceEntry.toString())),
              1 => ShadTableCell(child: Text(condition.sourceTypeLabel)),
              2 => ShadTableCell(child: Text(condition.conditionTypeLabel)),
              3 => ShadTableCell(
                child: Text(condition.conditionValue1.toString()),
              ),
              4 => ShadTableCell(
                child: Text(
                  condition.comment,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(flexWidth / 4),
              2 => FixedTableSpanExtent(flexWidth / 4),
              3 => FixedTableSpanExtent(flexWidth / 4),
              4 => FixedTableSpanExtent(flexWidth / 4),
              _ => null,
            };
          },
          header: (context, index) =>
              ShadTableCell.header(child: Text(headers[index])),
          onRowDoubleTap: (row) =>
              viewModel.navigateToDetail(condition: conditions[row]),
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () =>
                      viewModel.navigateToDetail(condition: conditions[row]),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.copyCondition(conditions[row]),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.deleteCondition(conditions[row]),
                  child: Text('删除'),
                ),
              ],
            );
          },
          pinnedRowCount: 1,
          rowCount: conditions.length,
        );
      },
    );

    return ShadCard(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        spacing: 16,
        children: [
          toolbar,
          Expanded(child: layoutBuilder),
        ],
      ),
    );
  }
}
