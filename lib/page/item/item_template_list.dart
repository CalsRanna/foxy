import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/constant/item_constants.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/page/item/item_template_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ItemTemplateListPage extends StatefulWidget {
  const ItemTemplateListPage({super.key});

  @override
  State<ItemTemplateListPage> createState() => _ItemTemplateListPageState();
}

class _ItemTemplateListPageState extends State<ItemTemplateListPage> {
  final viewModel = GetIt.instance.get<ItemTemplateListViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('物品列表'),
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

  Widget _buildFilter() {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClassButtons(),
          _buildSubclassButtons(),
          _buildSearchInputs(),
        ],
      ),
    );
  }

  Widget _buildClassButtons() {
    final selectedClassId = viewModel.selectedClassId.watch(context);
    final children = kItemClasses.asMap().entries.map((entry) {
      final isSelected = entry.key == selectedClassId;
      return ShadButton.raw(
        variant: isSelected
            ? ShadButtonVariant.secondary
            : ShadButtonVariant.ghost,
        onPressed: () => viewModel.selectClass(entry.key),
        size: ShadButtonSize.sm,
        child: Text(entry.value),
      );
    }).toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(spacing: 8, children: children),
    );
  }

  Widget _buildSubclassButtons() {
    final selectedClassId = viewModel.selectedClassId.watch(context);
    if (selectedClassId < 0) return const SizedBox.shrink();

    final selectedSubclass = viewModel.selectedSubclass.watch(context);
    final subclasses = viewModel.currentSubclasses;
    if (subclasses.isEmpty) return const SizedBox.shrink();

    final children = [
      ShadButton.raw(
        variant: selectedSubclass < 0
            ? ShadButtonVariant.secondary
            : ShadButtonVariant.ghost,
        onPressed: viewModel.clearSubclass,
        size: ShadButtonSize.sm,
        child: Text('全部'),
      ),
      ...subclasses.asMap().entries.map((entry) {
        final isSelected = entry.key == selectedSubclass;
        return ShadButton.raw(
          variant: isSelected
              ? ShadButtonVariant.secondary
              : ShadButtonVariant.ghost,
          onPressed: () => viewModel.selectSubclass(entry.key),
          size: ShadButtonSize.sm,
          child: Text(entry.value),
        );
      }),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(spacing: 8, children: children),
    );
  }

  Widget _buildSearchInputs() {
    var entryInput = ShadInput(
      controller: viewModel.entryController,
      placeholder: Text('编号（entry）'),
    );
    var nameInput = ShadInput(
      controller: viewModel.nameController,
      placeholder: Text('名称（name）'),
    );
    var descriptionInput = ShadInput(
      controller: viewModel.descriptionController,
      placeholder: Text('描述（description）'),
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
    var row = Row(spacing: 8, children: [searchButton, resetButton]);
    final children = [
      Expanded(child: entryInput),
      Expanded(child: nameInput),
      Expanded(child: descriptionInput),
      row,
    ];
    return Row(spacing: 16, children: children);
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus),
      onPressed: () {
        // TODO: 导航到物品详情页新建
      },
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

    final headers = ['编号', '名称', '类别', '子类别', '佩戴位置', '物品等级', '需求等级'];
    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth - 720;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = items[vicinity.row];
            final qualityColor =
                kItemQualityColors[item.quality] ?? Colors.black;
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.entry.toString())),
              1 => ShadTableCell(
                child: Text(
                  item.displayName,
                  style: TextStyle(color: qualityColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              2 => ShadTableCell(child: Text(getItemClassName(item.classId))),
              3 => ShadTableCell(
                child: Text(getItemSubclassName(item.classId, item.subclass)),
              ),
              4 => ShadTableCell(
                child: Text(getItemInventoryTypeName(item.inventoryType)),
              ),
              5 => ShadTableCell(child: Text(item.itemLevel.toString())),
              6 => ShadTableCell(child: Text(item.requiredLevel.toString())),
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
            _openDetail(items[row].entry, items[row].displayName);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    _openDetail(items[row].entry, items[row].displayName);
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () {
                    _copyItem(items[row].entry);
                  },
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () {
                    _deleteItem(items[row].entry);
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

  void _openDetail(int entry, String name) {
    // TODO: 导航到物品详情页
  }

  void _copyItem(int entry) {
    viewModel.copyItemTemplate(entry);
  }

  void _deleteItem(int entry) {
    viewModel.deleteItemTemplate(entry);
  }
}
