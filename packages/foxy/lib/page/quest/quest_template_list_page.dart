import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/quest_template_list_view_model.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_string_input.dart';
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
    final idInput = FoxyStringInput(
      controller: viewModel.idController,
      placeholder: '编号（Entry）',
    );
    final titleInput = FoxyStringInput(
      controller: viewModel.titleController,
      placeholder: '标题（Title）',
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
      Expanded(child: idInput),
      Expanded(child: titleInput),
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

    final table = FoxyDataTable<BriefQuestTemplateEntity>(
      queryVersion: viewModel.queryVersion.value,
      loading: viewModel.loading.value,
      pinnedRowCount: 1,
      rows: templates,
      columns: [
        FoxyTableColumn.fixed(
          label: '编号',
          width: 120,
          cell: (_, item) => Text(item.id.toString()),
        ),
        FoxyTableColumn.flex(
          label: '标题',
          cell: (_, item) => Text(
            item.displayTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        FoxyTableColumn.flex(
          label: '描述',
          cell: (_, item) => Text(
            item.displayDescription,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        FoxyTableColumn.fixed(
          label: '类型',
          width: 120,
          cell: (_, item) => Text(item.typeLabel),
        ),
        FoxyTableColumn.fixed(
          label: '等级',
          width: 120,
          cell: (_, item) => Text(item.questLevel.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '最低等级',
          width: 120,
          cell: (_, item) => Text(item.minLevel.toString()),
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

  void _navigateToDetail({int? key}) {
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      route: QuestTemplateDetailRoute(questTemplateKey: key),
      parentMenu: RouterMenu.questTemplate,
    );
  }
}
