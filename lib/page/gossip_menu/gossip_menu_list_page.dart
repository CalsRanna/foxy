import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class GossipMenuListPage extends StatefulWidget {
  const GossipMenuListPage({super.key});

  @override
  State<GossipMenuListPage> createState() => _GossipMenuListPageState();
}

class _GossipMenuListPageState extends State<GossipMenuListPage> {
  final viewModel = GetIt.instance.get<GossipMenuListViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('对话列表'),
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
    final menuIdInput = ShadInput(
      controller: viewModel.menuIdController,
      placeholder: Text('编号（MenuID）'),
    );
    final textInput = ShadInput(
      controller: viewModel.textController,
      placeholder: Text('文本（Text）'),
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
      Expanded(child: menuIdInput),
      Expanded(child: textInput),
      row,
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: children),
    );
  }

  Widget _buildTable() {
    final templates = viewModel.templates.value;
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

    final headers = ['编号', '文本编号', '文本'];
    final table = LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth - 240;
        return FoxyShadTable(
          columnCount: headers.length,
          rowCount: templates.length,
          pinnedRowCount: 1,
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(120),
              2 => FixedTableSpanExtent(width),
              _ => null,
            };
          },
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= templates.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = templates[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.menuId.toString())),
              1 => ShadTableCell(child: Text(item.textId.toString())),
              2 => ShadTableCell(
                child: Text(
                  item.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          onRowDoubleTap: (row) {
            final item = templates[row];
            viewModel.navigateToDetail(
              menuId: item.menuId,
              textId: item.textId,
            );
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            final item = templates[row];
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => viewModel.navigateToDetail(
                    menuId: item.menuId,
                    textId: item.textId,
                  ),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.onCopy(item.menuId, item.textId),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.onDestroy(item.menuId, item.textId),
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
