import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/reference_loot_template_entity.dart';
import 'package:foxy/page/reference_loot_template/reference_loot_template_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/item_quality_color.dart';
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
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

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
      Expanded(child: SizedBox()),
      Expanded(child: row),
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

    final headers = ['Entry', '物品/行标识', '关联', '几率', '需要任务', '最小数量', '最大数量'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth - 720;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final template = templates[vicinity.row];
            final qualityColor =
                kItemQualityColors[template.itemQuality] ?? Colors.white;
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(template.entry.toString())),
              1 => ShadTableCell(
                child: Text(
                  template.reference == 0
                      ? (template.displayName.isEmpty
                            ? template.item.toString()
                            : template.displayName)
                      : template.item.toString(),
                  style: TextStyle(color: qualityColor),
                ),
              ),
              2 => ShadTableCell(child: Text(template.reference.toString())),
              3 => ShadTableCell(child: Text('${template.chance}%')),
              4 => ShadTableCell(
                child: Text(template.questRequired ? '是' : '否'),
              ),
              5 => ShadTableCell(child: Text(template.minCount.toString())),
              6 => ShadTableCell(child: Text(template.maxCount.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(width),
              2 => FixedTableSpanExtent(120),
              3 => FixedTableSpanExtent(120),
              4 => FixedTableSpanExtent(120),
              5 => FixedTableSpanExtent(120),
              6 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowDoubleTap: (row) {
            _navigateToDetail(key: templates[row].key);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    _navigateToDetail(key: templates[row].key);
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  enabled: !viewModel.submitting.value,
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => _copy(templates[row].key),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  enabled: !viewModel.submitting.value,
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => _destroy(templates[row].key),
                  child: Text('删除'),
                ),
              ],
            );
          },
          pinnedRowCount: 1,
          rowCount: templates.length,
        );
      },
    );

    var children = [toolbar, Expanded(child: layoutBuilder)];
    final column = Column(spacing: 16, children: children);
    return ShadCard(padding: EdgeInsets.fromLTRB(16, 16, 16, 0), child: column);
  }

  void _navigateToDetail({ReferenceLootTemplateKey? key}) {
    final name = key == null ? '新建关联掉落' : '关联掉落 ${key.entry}-${key.item}';
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      label: name,
      route: ReferenceLootTemplateDetailRoute(referenceLootTemplateKey: key),
      parentMenu: RouterMenu.more,
    );
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
      DialogUtil.instance.error('复制失败：$error');
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
      DialogUtil.instance.error('删除失败：$error');
    }
  }
}
