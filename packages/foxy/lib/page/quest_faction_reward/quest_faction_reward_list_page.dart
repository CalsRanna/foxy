import 'package:auto_route/auto_route.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/quest_faction_reward_list_view_model.dart';
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
class QuestFactionRewardListPage extends StatefulWidget {
  const QuestFactionRewardListPage({super.key});

  @override
  State<QuestFactionRewardListPage> createState() =>
      _QuestFactionRewardListPageState();
}

class _QuestFactionRewardListPageState
    extends State<QuestFactionRewardListPage> {
  final viewModel = GetIt.instance.get<QuestFactionRewardListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('任务声望列表'),
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
    var entryInput = FoxyStringInput(
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
      Expanded(child: entryInput),
      Expanded(flex: 3, child: row),
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: credentialChildren),
    );
  }

  Widget _buildTable() {
    final rewards = viewModel.items.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;
    final canCreate =
        !rewards.any((reward) => reward.id == 1) ||
        !rewards.any((reward) => reward.id == 2);
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus, size: 16),
      onPressed: canCreate ? () => _navigateToDetail() : null,
      child: Text('新增'),
    );
    var pagination = FoxyPagination(
      page: page,
      pageSize: 50,
      total: total,
      onChange: viewModel.paginate,
    );
    final toolbarChildren = [createButton, const Spacer(), pagination];
    final toolbar = Row(children: toolbarChildren);

    final table = FoxyDataTable<BriefQuestFactionRewardEntity>(
      queryVersion: viewModel.queryVersion.value,
      loading: viewModel.loading.value,
      pinnedRowCount: 1,
      rows: rewards,
      columns: [
        FoxyTableColumn.fixed(
          label: '编号',
          width: 120,
          cell: (_, item) => Text(item.id.toString()),
        ),
        FoxyTableColumn.flex(
          label: '难度 0 声望值',
          cell: (_, item) => Text(item.difficulty0.toString()),
        ),
        FoxyTableColumn.flex(
          label: '难度 1 声望值',
          cell: (_, item) => Text(item.difficulty1.toString()),
        ),
        FoxyTableColumn.flex(
          label: '难度 2 声望值',
          cell: (_, item) => Text(item.difficulty2.toString()),
        ),
        FoxyTableColumn.flex(
          label: '难度 3 声望值',
          cell: (_, item) => Text(item.difficulty3.toString()),
        ),
        FoxyTableColumn.flex(
          label: '难度 4 声望值',
          cell: (_, item) => Text(item.difficulty4.toString()),
        ),
        FoxyTableColumn.flex(
          label: '难度 5 声望值',
          cell: (_, item) => Text(item.difficulty5.toString()),
        ),
        FoxyTableColumn.flex(
          label: '难度 6 声望值',
          cell: (_, item) => Text(item.difficulty6.toString()),
        ),
        FoxyTableColumn.flex(
          label: '难度 7 声望值',
          cell: (_, item) => Text(item.difficulty7.toString()),
        ),
        FoxyTableColumn.flex(
          label: '难度 8 声望值',
          cell: (_, item) => Text(item.difficulty8.toString()),
        ),
        FoxyTableColumn.flex(
          label: '难度 9 声望值',
          cell: (_, item) => Text(item.difficulty9.toString()),
        ),
      ],
      onRowDoubleTap: (item) => _navigateToDetail(key: item.key),
      onRowSecondaryTapDownWithDetails: (item, details) {
        ContextMenu.show(
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
      DialogUtil.instance.error('删除失败：${FoxyExceptions.message(error)}');
    }
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
      DialogUtil.instance.error('复制失败：${FoxyExceptions.message(error)}');
    }
  }

  void _navigateToDetail({int? key}) {
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      route: QuestFactionRewardDetailRoute(questFactionRewardKey: key),
      parentMenu: RouterMenu.questFactionReward,
    );
  }
}
