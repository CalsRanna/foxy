import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_string_input.dart';
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
  void dispose() {
    viewModel.dispose();
    super.dispose();
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
    final menuIdInput = FoxyStringInput(
      controller: viewModel.menuIdController,
      placeholder: '编号（MenuID）',
    );
    final textInput = FoxyStringInput(
      controller: viewModel.textController,
      placeholder: '文本（Text）',
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
    final row = Row(spacing: 16, children: [searchBtn, resetBtn]);
    final children = [
      Expanded(child: menuIdInput),
      Expanded(child: textInput),
      Expanded(flex: 2, child: row),
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: children),
    );
  }

  Widget _buildTable() {
    final templates = viewModel.items.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;

    final createBtn = ShadButton(
      leading: Icon(LucideIcons.plus, size: 16),
      onPressed: () => _navigateToDetail(),
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
            _navigateToDetail(key: item.key);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            final item = templates[row];
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => _navigateToDetail(key: item.key),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  enabled: !viewModel.submitting.value,
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => _copy(item.key),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  enabled: !viewModel.submitting.value,
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => _destroy(item.key),
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
      child: Column(
        spacing: 16,
        children: [
          toolbar,
          Expanded(child: table),
        ],
      ),
    );
  }

  void _navigateToDetail({GossipMenuKey? key}) {
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      label: key != null ? '对话 ${key.menuId}' : '新建对话',
      route: GossipMenuDetailRoute(gossipMenuKey: key),
      parentMenu: RouterMenu.gossipMenu,
    );
  }

  Future<void> _copy(GossipMenuKey key) async {
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

  Future<void> _destroy(GossipMenuKey key) async {
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
