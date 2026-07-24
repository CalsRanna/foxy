import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/page/page_text/page_text_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_string_input.dart';
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
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('页面文本列表'),
      _buildFilter(),
      Expanded(child: Watch((_) => _buildTable())),
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: children,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  Widget _buildFilter() {
    var idInput = FoxyStringInput(
      controller: viewModel.idController,
      placeholder: 'ID',
    );
    var textInput = FoxyStringInput(
      controller: viewModel.textController,
      placeholder: '文本',
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
      child: Row(
        spacing: 16,
        children: [
          Expanded(child: idInput),
          Expanded(child: textInput),
          Expanded(flex: 2, child: row),
        ],
      ),
    );
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus, size: 16),
      onPressed: () => _navigateToDetail(),
      child: Text('新增'),
    );
    final pages = viewModel.items.value;
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
        var width = constraints.maxWidth - 240;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final pageText = pages[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(pageText.id.toString())),
              1 => ShadTableCell(
                child: Text(
                  pageText.displayText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              2 => ShadTableCell(child: Text(pageText.nextPageId.toString())),
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
            _navigateToDetail(
              key: pages[row].key,
              label: pages[row].displayText,
            );
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => _navigateToDetail(
                    key: pages[row].key,
                    label: pages[row].displayText,
                  ),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  enabled: !viewModel.submitting.value,
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => _copy(pages[row].key),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  enabled: !viewModel.submitting.value,
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => _destroy(pages[row].key),
                  child: Text('删除'),
                ),
              ],
            );
          },
          pinnedRowCount: 1,
          rowCount: pages.length,
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

  void _navigateToDetail({int? key, String? label}) {
    final name = label?.isNotEmpty == true ? label! : '新建页面文本';
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      label: name,
      route: TextContentDetailRoute(pageTextKey: key),
      parentMenu: RouterMenu.more,
    );
  }

  Future<void> _copy(int key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认复制',
      description: '确定要复制这条记录吗？',
      confirmText: '复制',
    );
    if (!confirmed) return;
    try {
      await viewModel.copy(key);
      if (!mounted) return;
      DialogUtil.instance.success('复制成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('复制失败：$error');
    }
  }

  Future<void> _destroy(int key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '确定要删除这条记录吗？此操作不可撤销。',
      confirmText: '删除',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await viewModel.destroy(key);
      if (!mounted) return;
      DialogUtil.instance.success('删除成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('删除失败：$error');
    }
  }
}
