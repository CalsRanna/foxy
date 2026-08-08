import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/constant/scaling_stat_distribution_constants.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/util/table_layout_util.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/scaling_stat_distribution_list_view_model.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ScalingStatDistributionListPage extends StatefulWidget {
  const ScalingStatDistributionListPage({super.key});

  @override
  State<ScalingStatDistributionListPage> createState() =>
      _ScalingStatDistributionListPageState();
}

class _ScalingStatDistributionListPageState
    extends State<ScalingStatDistributionListPage> {
  final viewModel = GetIt.instance.get<ScalingStatDistributionListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('属性缩放分布列表'),
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
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  Widget _buildFilter() {
    var idInput = FoxyStringInput(
      controller: viewModel.idController,
      placeholder: '编号（ID）',
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
      Expanded(child: idInput),
      Expanded(flex: 3, child: row),
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

    final table = FoxyDataTable<BriefScalingStatDistributionEntity>(
      queryVersion: viewModel.queryVersion.value,
      loading: viewModel.loading.value,
      pinnedRowCount: 1,
      rows: items,
      columns: [
        FoxyTableColumn.fixed(
          label: '编号',
          width: 120,
          cell: (_, item) => Text(item.id.toString()),
        ),
        FoxyTableColumn.flex(
          label: '属性分布',
          cell: (context, item) => LayoutBuilder(
            builder: (context, constraints) =>
                _buildStatBadges(item, constraints.maxWidth),
          ),
        ),
      ],
      onRowDoubleTap: (item) => _navigateToDetail(key: item.key),
      onRowSecondaryTapDownWithDetails: (item, details) {
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

    var children = [
      if (viewModel.errorMessage.value != null)
        FoxyInlineError(message: viewModel.errorMessage.value),
      toolbar,
      Expanded(child: table),
    ];
    final column = Column(spacing: 16, children: children);
    return ShadCard(padding: EdgeInsets.fromLTRB(16, 16, 16, 0), child: column);
  }

  static const _badgePadding = EdgeInsets.symmetric(horizontal: 8);
  static const _badgeSpacing = 4.0;

  /// Badge 内部的固定文本样式（shadcn Badge 实现为 small + 12px + w600）。
  /// 宽度测量必须与渲染完全一致——加粗会影响字形宽度。
  TextStyle _badgeTextStyle(BuildContext context) =>
      ShadTheme.of(context).textTheme.small.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );

  /// 属性分布列：每个有效属性一个 Badge，按列实际宽度实时计算可容纳
  /// 数量，超出部分合并为 `+N`。
  Widget _buildStatBadges(
    BriefScalingStatDistributionEntity item,
    double maxWidth,
  ) {
    final entries = statEntries(
      [
        item.statId0,
        item.statId1,
        item.statId2,
        item.statId3,
        item.statId4,
        item.statId5,
        item.statId6,
        item.statId7,
        item.statId8,
        item.statId9,
      ],
      [
        item.bonus0,
        item.bonus1,
        item.bonus2,
        item.bonus3,
        item.bonus4,
        item.bonus5,
        item.bonus6,
        item.bonus7,
        item.bonus8,
        item.bonus9,
      ],
    );
    if (entries.isEmpty) return const Text('-');
    final direction = Directionality.of(context);
    final widths = [
      for (final (statId, bonus) in entries)
        _badgeWidth(context, _statLabel(statId, bonus), direction),
    ];
    final count = fittingBadgeCount(
      widths,
      (hidden) => _badgeWidth(context, '+$hidden', direction),
      _badgeSpacing,
      maxWidth,
    );
    final hidden = entries.length - count;
    return Wrap(
      spacing: _badgeSpacing,
      runSpacing: 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final (statId, bonus) in entries.take(count))
          ShadBadge.secondary(
            padding: _badgePadding,
            child: Text(_statLabel(statId, bonus)),
          ),
        if (hidden > 0)
          ShadBadge.outline(
            padding: _badgePadding,
            child: Text('+$hidden'),
          ),
      ],
    );
  }

  String _statLabel(int statId, int bonus) =>
      '${kScalingStatDistributionStatOptions[statId] ?? statId}($bonus)';

  /// 一个 Badge 的总宽度：文本 + 左右 padding。测量使用的字体样式和
  /// padding 与渲染完全一致，保证计数与实际布局吻合。
  double _badgeWidth(
    BuildContext context,
    String text,
    TextDirection direction,
  ) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: _badgeTextStyle(context)),
      maxLines: 1,
      textDirection: direction,
    )..layout();
    return painter.width + _badgePadding.horizontal;
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
      DialogUtil.instance.error('复制失败：${foxyErrorMessage(error)}');
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
      DialogUtil.instance.error('删除失败：${foxyErrorMessage(error)}');
    }
  }

  void _navigateToDetail({int? key}) {
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      route: ScalingStatDistributionDetailRoute(
        scalingStatDistributionKey: key,
      ),
      parentMenu: RouterMenu.scalingStatDistribution,
    );
  }
}
