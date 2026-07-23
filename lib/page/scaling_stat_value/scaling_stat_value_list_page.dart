import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ScalingStatValueListPage extends StatefulWidget {
  const ScalingStatValueListPage({super.key});

  @override
  State<ScalingStatValueListPage> createState() =>
      _ScalingStatValueListPageState();
}

class _ScalingStatValueListPageState extends State<ScalingStatValueListPage> {
  final viewModel = GetIt.instance.get<ScalingStatValueListViewModel>();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('缩放属性值列表'),
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
    var entryInput = FoxyStringInput(
      controller: viewModel.entryController,
      placeholder: '编号（ID）',
    );
    var charlevelInput = FoxyStringInput(
      controller: viewModel.charlevelController,
      placeholder: '角色等级',
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
      Expanded(child: charlevelInput),
      Expanded(child: row),
      Expanded(child: SizedBox()),
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: credentialChildren),
    );
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus, size: 16),
      onPressed: () => _navigateToDetail(),
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
    final toolbarChildren = [createButton, const Spacer(), pagination];
    final toolbar = Row(children: toolbarChildren);

    final headers = [
      '编号',
      '角色等级',
      '主要预算',
      '三级预算',
      '肩膀预算',
      '饰品预算',
      '单手武器预算',
      '远程武器预算',
    ];
    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth - 120;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final item = items[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.id.toString())),
              1 => ShadTableCell(child: Text(item.charlevel.toString())),
              2 => ShadTableCell(child: Text(item.primaryBudget.toString())),
              3 => ShadTableCell(child: Text(item.tertiaryBudget.toString())),
              4 => ShadTableCell(child: Text(item.shoulderBudget.toString())),
              5 => ShadTableCell(child: Text(item.trinketBudget.toString())),
              6 => ShadTableCell(child: Text(item.weaponBudget1H.toString())),
              7 => ShadTableCell(child: Text(item.rangedBudget.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              _ => FixedTableSpanExtent(width / 7),
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowDoubleTap: (row) {
            _navigateToDetail(key: items[row].key);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    _navigateToDetail(key: items[row].key);
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  enabled: !viewModel.submitting.value,
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () {
                    _copy(items[row].key);
                  },
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  enabled: !viewModel.submitting.value,
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () {
                    _destroy(items[row].key);
                  },
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

    var children = [toolbar, Expanded(child: layoutBuilder)];
    final column = Column(spacing: 16, children: children);
    return ShadCard(padding: EdgeInsets.fromLTRB(16, 16, 16, 0), child: column);
  }

  void _navigateToDetail({int? key}) {
    final label = key != null ? '缩放属性值 #$key' : '新建缩放属性值';
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      label: label,
      route: ScalingStatValueDetailRoute(scalingStatValueKey: key),
      parentMenu: RouterMenu.scalingStatValue,
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
