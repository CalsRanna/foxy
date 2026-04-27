import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/page_text/page_text_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class TextContentListPage extends StatefulWidget {
  const TextContentListPage({super.key});

  @override
  State<TextContentListPage> createState() => _TextContentListPageState();
}

class _TextContentListPageState extends State<TextContentListPage> {
  final viewModel = GetIt.instance.get<PageTextListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('页面文本列表'),
      _buildFilter(),
      Expanded(child: Watch((_) => _buildTable())),
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 16, children: children),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  Widget _buildFilter() {
    var idInput = ShadInput(
      controller: viewModel.idController,
      placeholder: Text('ID'),
    );
    var textInput = ShadInput(
      controller: viewModel.textController,
      placeholder: Text('文本'),
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
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: [
        Expanded(child: idInput),
        Expanded(child: textInput),
        Expanded(flex: 2, child: row),
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
    var pagination = FoxyPagination(
      page: page,
      pageSize: 50,
      total: total,
      onChange: viewModel.paginate,
    );
    final toolbar = Row(children: [createButton, const Spacer(), pagination]);
    final headers = ['编号', '文本', '下一页编号'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth - 360;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final item = items[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.id.toString())),
              1 => ShadTableCell(child: Text(item.displayText)),
              2 => ShadTableCell(child: Text(item.nextPageId.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(width),
              2 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowDoubleTap: (row) {
            viewModel.navigateToDetail(
              context,
              id: items[row].id,
              label: items[row].displayText,
            );
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => viewModel.navigateToDetail(context, id: items[row].id, label: items[row].displayText),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.onCopy(items[row].id),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.onDelete(items[row].id),
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
