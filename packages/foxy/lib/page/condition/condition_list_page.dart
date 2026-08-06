import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/condition_list_view_model.dart';
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
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: FoxyStringInput(
              controller: viewModel.sourceTypeOrReferenceIdController,
              placeholder: 'SourceTypeOrReferenceId',
            ),
          ),
          Expanded(
            child: FoxyStringInput(
              controller: viewModel.sourceEntryController,
              placeholder: 'SourceEntry',
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
      onPressed: () => _navigateToDetail(),
      child: Text('新增'),
    );
    final conditions = viewModel.items.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;
    var pagination = FoxyPagination(
      page: page,
      pageSize: 50,
      total: total,
      onChange: viewModel.paginate,
    );
    final toolbar = Row(children: [createButton, const Spacer(), pagination]);

    final table = FoxyDataTable<BriefConditionEntity>(
      queryVersion: viewModel.queryVersion.value,
      loading: viewModel.loading.value,
      pinnedRowCount: 1,
      rows: conditions,
      columns: [
        FoxyTableColumn.fixed(
          label: '来源条目',
          width: 120,
          cell: (_, condition) => Text(condition.sourceEntry.toString()),
        ),
        FoxyTableColumn.flex(
          label: '来源类型',
          cell: (_, condition) => Text(condition.sourceTypeLabel),
        ),
        FoxyTableColumn.flex(
          label: '条件类型',
          cell: (_, condition) => Text(condition.conditionTypeLabel),
        ),
        FoxyTableColumn.flex(
          label: '参数1',
          cell: (_, condition) => Text(condition.conditionValue1.toString()),
        ),
        FoxyTableColumn.flex(
          label: '说明',
          cell: (_, condition) => Text(
            condition.comment,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
      onRowDoubleTap: (condition) => _navigateToDetail(condition: condition),
      onRowSecondaryTapDownWithDetails: (condition, details) {
        showFoxyContextMenu(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () => _navigateToDetail(condition: condition),
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              enabled: !viewModel.submitting.value,
              leading: Icon(LucideIcons.copy, size: 16),
              onPressed: () => _copy(condition.key),
              child: Text('复制'),
            ),
            ShadContextMenuItem(
              enabled: !viewModel.submitting.value,
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(condition.key),
              child: Text('删除'),
            ),
          ],
        );
      },
    );

    return ShadCard(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        spacing: 16,
        children: [
          if (viewModel.errorMessage.value != null)
            FoxyInlineError(message: viewModel.errorMessage.value),
          toolbar,
          Expanded(child: table),
        ],
      ),
    );
  }

  Future<void> _copy(ConditionKey key) async {
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

  Future<void> _destroy(ConditionKey key) async {
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

  void _navigateToDetail({BriefConditionEntity? condition}) {
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      route: ConditionDetailRoute(conditionKey: condition?.key),
      parentMenu: RouterMenu.condition,
    );
  }
}
