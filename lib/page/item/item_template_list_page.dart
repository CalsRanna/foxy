import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/util/item_helpers.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/page/item/item_template_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_game_asset_icon.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
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
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('物品列表'),
      Watch((_) => _buildFilter()),
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
      child: _buildSearchInputs(),
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
    var row = Row(spacing: 16, children: [searchButton, resetButton]);
    final children = [
      Expanded(child: entryInput),
      Expanded(child: nameInput),
      Expanded(child: descriptionInput),
      Expanded(child: row),
    ];
    return Row(spacing: 16, children: children);
  }

  Widget _buildIconAndName(BriefItemTemplateEntity item, Color qualityColor) {
    var children = [
      ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: FoxyGameAssetIcon(rawPath: item.inventoryIcon),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          item.displayName,
          style: TextStyle(color: qualityColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];
    return Row(children: children);
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus, size: 16),
      onPressed: () => viewModel.navigateToDetail(),
      child: Text('新增'),
    );
    final templates = viewModel.templates.value;
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
            if (vicinity.row < 0 || vicinity.row >= templates.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = templates[vicinity.row];
            final qualityColor =
                kItemQualityColors[item.quality] ?? Colors.black;
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.entry.toString())),
              1 => ShadTableCell(child: _buildIconAndName(item, qualityColor)),
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
            viewModel.navigateToDetail(
              entry: templates[row].entry,
              name: templates[row].displayName,
            );
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    viewModel.navigateToDetail(
                      entry: templates[row].entry,
                      name: templates[row].displayName,
                    );
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () {
                    viewModel.copyItemTemplate(templates[row].entry);
                  },
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () {
                    viewModel.deleteItemTemplate(templates[row].entry);
                  },
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
}
