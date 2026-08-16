import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/reference_loot_template_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/reference_loot_template_list_view_model.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:foxy/widget/item_quality_color.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ReferenceLootTemplateListPage extends StatefulWidget {
  const ReferenceLootTemplateListPage({super.key});

  @override
  State<ReferenceLootTemplateListPage> createState() =>
      _ReferenceLootTemplateListPageState();
}

class _ReferenceLootTemplateListPageState
    extends State<ReferenceLootTemplateListPage> {
  final viewModel = GetIt.instance.get<ReferenceLootTemplateListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('关联掉落列表'),
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
      controller: viewModel.entryController,
      placeholder: 'Entry',
    );
    var nameInput = FoxyStringInput(
      controller: viewModel.nameController,
      placeholder: 'Item',
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
      Expanded(child: nameInput),
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

    final table = FoxyDataTable<BriefReferenceLootTemplateEntity>(
      queryVersion: viewModel.queryVersion.value,
      loading: viewModel.loading.value,
      pinnedRowCount: 1,
      rows: templates,
      columns: [
        FoxyTableColumn.fixed(
          label: 'Entry',
          width: 120,
          cell: (_, template) => Text(template.entry.toString()),
        ),
        FoxyTableColumn.flex(
          label: '物品/行标识',
          cell: (context, template) {
            final qualityColor = ItemQualityColor.of(template.itemQuality);
            return Text(
              template.reference == 0
                  ? (template.displayName.isEmpty
                        ? template.item.toString()
                        : template.displayName)
                  : template.item.toString(),
              style: TextStyle(color: qualityColor),
            );
          },
        ),
        FoxyTableColumn.fixed(
          label: '关联',
          width: 120,
          cell: (_, template) => Text(template.reference.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '几率',
          width: 120,
          cell: (_, template) => Text('${template.chance}%'),
        ),
        FoxyTableColumn.fixed(
          label: '需要任务',
          width: 120,
          cell: (_, template) => Text(template.questRequired ? '是' : '否'),
        ),
        FoxyTableColumn.fixed(
          label: '最小数量',
          width: 120,
          cell: (_, template) => Text(template.minCount.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '最大数量',
          width: 120,
          cell: (_, template) => Text(template.maxCount.toString()),
        ),
      ],
      onRowDoubleTap: (template) => _navigateToDetail(key: template.key),
      onRowSecondaryTapDownWithDetails: (template, details) {
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () => _navigateToDetail(key: template.key),
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              enabled: !viewModel.submitting.value,
              leading: Icon(LucideIcons.copy, size: 16),
              onPressed: () => _copy(template.key),
              child: Text('复制'),
            ),
            ShadContextMenuItem(
              enabled: !viewModel.submitting.value,
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(template.key),
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

  Future<void> _copy(ReferenceLootTemplateKey key) async {
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

  Future<void> _destroy(ReferenceLootTemplateKey key) async {
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

  void _navigateToDetail({ReferenceLootTemplateKey? key}) {
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      route: ReferenceLootTemplateDetailRoute(referenceLootTemplateKey: key),
      parentMenu: RouterMenu.referenceLootTemplate,
    );
  }
}
