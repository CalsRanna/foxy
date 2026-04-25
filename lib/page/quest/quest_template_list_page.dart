import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class QuestTemplateListPage extends StatefulWidget {
  const QuestTemplateListPage({super.key});

  @override
  State<QuestTemplateListPage> createState() => _QuestTemplateListPageState();
}

class _QuestTemplateListPageState extends State<QuestTemplateListPage> {
  final viewModel = GetIt.instance.get<QuestTemplateListViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('任务列表'),
      _buildFilter(),
      Expanded(child: Watch((_) => _buildTable())),
    ];
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: children,
    );
    return Padding(padding: const EdgeInsets.all(16.0), child: column);
  }

  Widget _buildFilter() {
    final idInput = ShadInput(
      controller: viewModel.idController,
      placeholder: Text('编号（Entry）'),
    );
    final titleInput = ShadInput(
      controller: viewModel.titleController,
      placeholder: Text('标题（Title）'),
    );
    final searchBtn = ShadButton(
      onPressed: viewModel.search,
      size: ShadButtonSize.sm,
      child: Text('查询'),
    );
    final resetBtn = ShadButton.ghost(
      onPressed: viewModel.reset,
      size: ShadButtonSize.sm,
      child: Text('重置'),
    );
    final row = Row(spacing: 8, children: [searchBtn, resetBtn]);
    final children = [
      Expanded(child: idInput),
      Expanded(child: titleInput),
      row,
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: children),
    );
  }

  Widget _buildTable() {
    final items = viewModel.items.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;

    final createBtn = ShadButton(
      leading: Icon(LucideIcons.plus),
      onPressed: () => viewModel.navigateToDetail(),
      child: Text('新增'),
    );
    final pagination = FoxyPagination(
      page: page,
      pageSize: 50,
      total: total,
      onChange: viewModel.paginate,
    );
    final toolbar = Row(children: [createBtn, const Spacer(), pagination]);

    final headers = ['编号', '标题', '描述', '类型', '等级', '最低等级'];
    final fixedWidths = [80, 200, null, 80, 80, 80];
    final fixedTotal = fixedWidths
        .where((w) => w != null)
        .fold<int>(0, (sum, w) => sum + w!);

    final table = LayoutBuilder(
      builder: (context, constraints) {
        final descriptionWidth =
            constraints.maxWidth - fixedTotal;
        final columnExtents = [
          FixedTableSpanExtent(80),
          FixedTableSpanExtent(200),
          FixedTableSpanExtent(descriptionWidth),
          FixedTableSpanExtent(80),
          FixedTableSpanExtent(80),
          FixedTableSpanExtent(80),
        ];
        return FoxyShadTable(
          columnCount: headers.length,
          rowCount: items.length,
          pinnedRowCount: 1,
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          columnSpanExtent: (index) {
            return columnExtents[index];
          },
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = items[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.id.toString())),
              1 => ShadTableCell(child: Text(item.displayTitle)),
              2 => ShadTableCell(
                child: Text(
                  item.questDescription,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              3 => ShadTableCell(child: Text(item.questType.toString())),
              4 => ShadTableCell(child: Text(item.questLevel.toString())),
              5 => ShadTableCell(child: Text(item.minLevel.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          onRowDoubleTap: (row) {
            final item = items[row];
            viewModel.navigateToDetail(id: item.id);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            final item = items[row];
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () =>
                      viewModel.navigateToDetail(id: item.id),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.onCopy(item.id),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.onDestroy(item.id),
                  child: Text('删除'),
                ),
              ],
            );
          },
        );
      },
    );

    return ShadCard(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(spacing: 16, children: [toolbar, Expanded(child: table)]),
    );
  }
}