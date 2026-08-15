import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/constant/smart_script_constants.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/smart_script_list_view_model.dart';
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
class SmartScriptListPage extends StatefulWidget {
  const SmartScriptListPage({super.key});

  @override
  State<SmartScriptListPage> createState() => _SmartScriptListPageState();
}

class _SmartScriptListPageState extends State<SmartScriptListPage> {
  final viewModel = GetIt.instance.get<SmartScriptListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('脚本列表'),
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
      controller: viewModel.entryOrGuidController,
      placeholder: '实体编号（entryorguid）',
    );
    var commentInput = FoxyStringInput(
      controller: viewModel.commentController,
      placeholder: '备注（comment）',
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
      Expanded(child: commentInput),
      Expanded(flex: 2, child: row),
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
    final templates = viewModel.items.value;
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

    final table = FoxyDataTable<BriefSmartScriptEntity>(
      queryVersion: viewModel.queryVersion.value,
      loading: viewModel.loading.value,
      pinnedRowCount: 1,
      rows: templates,
      columns: [
        FoxyTableColumn.fixed(
          label: '编号',
          width: 120,
          cell: (_, script) => Text(script.entryOrGuid.toString()),
        ),
        FoxyTableColumn.fixed(
          label: 'ID',
          width: 120,
          cell: (_, script) => Text(script.id.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '事件类型',
          width: 120,
          cell: (_, script) => Text(
            SmartScriptConstants.eventTypes[script.eventType] ??
                script.eventType.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        FoxyTableColumn.fixed(
          label: '动作类型',
          width: 120,
          cell: (_, script) => Text(
            SmartScriptConstants.actionTypes[script.actionType] ??
                script.actionType.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        FoxyTableColumn.fixed(
          label: '目标类型',
          width: 120,
          cell: (_, script) => Text(
            SmartScriptConstants.targetTypes[script.targetType] ??
                script.targetType.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        FoxyTableColumn.flex(
          label: '备注',
          cell: (_, script) => Text(
            script.comment,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
      onRowDoubleTap: (script) => _navigateToDetail(key: script.key),
      onRowSecondaryTapDownWithDetails: (script, details) {
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () => _navigateToDetail(key: script.key),
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              enabled: !viewModel.submitting.value,
              leading: Icon(LucideIcons.copy, size: 16),
              onPressed: () => _copy(script.key),
              child: Text('复制'),
            ),
            ShadContextMenuItem(
              enabled: !viewModel.submitting.value,
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(script.key),
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

  Future<void> _copy(SmartScriptKey key) async {
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

  Future<void> _destroy(SmartScriptKey key) async {
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

  void _navigateToDetail({SmartScriptKey? key}) {
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      route: SmartScriptDetailRoute(scriptKey: key),
      parentMenu: RouterMenu.smartScript,
    );
  }
}
