import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
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

    final headers = ['编号', '标题', '描述', '类型', '等级', '最低等级'];

    final table = LayoutBuilder(
      builder: (context, constraints) {
        final descriptionWidth = constraints.maxWidth - 720;
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
              1 => FixedTableSpanExtent(240),
              2 => FixedTableSpanExtent(descriptionWidth),
              3 => FixedTableSpanExtent(120),
              4 => FixedTableSpanExtent(120),
              5 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= templates.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = templates[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.id.toString())),
              1 => ShadTableCell(child: Text(item.displayTitle)),
              2 => ShadTableCell(
                child: Text(
                  item.displayDescription,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              3 => ShadTableCell(child: Text(item.questType.toString())),
              4 => ShadTableCell(child: Text(item.questLevel.toString())),
              5 => ShadTableCell(child: Text(item.minLevel.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          onRowDoubleTap: (row) {
            final item = templates[row];
            _navigateToDetail(key: item.key, name: item.displayTitle);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            final item = templates[row];
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () =>
                      _navigateToDetail(key: item.key, name: item.displayTitle),
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

  void _navigateToDetail({int? key, String? name}) {
    final label = key == null
        ? '新建任务'
        : name?.isNotEmpty == true
        ? name!
        : '任务 #$key';
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      label: label,
      route: QuestTemplateDetailRoute(questTemplateKey: key),
      parentMenu: RouterMenu.questTemplate,
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
