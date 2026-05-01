import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/item_set/item_set_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ItemSetListPage extends StatefulWidget {
  const ItemSetListPage({super.key});

  @override
  State<ItemSetListPage> createState() => _ItemSetListPageState();
}

class _ItemSetListPageState extends State<ItemSetListPage> {
  final viewModel = GetIt.instance.get<ItemSetListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('套装列表'),
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
    var entryInput = ShadInput(
      controller: viewModel.entryController,
      placeholder: Text('编号（ID）'),
    );
    var nameInput = ShadInput(
      controller: viewModel.nameController,
      placeholder: Text('名称'),
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
      Expanded(child: row),
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: credentialChildren),
    );
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus),
      onPressed: () => viewModel.navigateToDetail(),
      child: Text('新增'),
    );
    final items = viewModel.itemSets.value;
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

    final headers = ['编号', '名称', '需求技能', '需求等级'];
    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth - 360;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final item = items[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.id.toString())),
              1 =>
                ShadTableCell(child: Text(item.nameLangZhCN.toString())),
              2 =>
                ShadTableCell(child: Text(item.requiredSkill.toString())),
              3 =>
                ShadTableCell(child: Text(item.requiredSkillRank.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(width / 3),
              2 => FixedTableSpanExtent(120),
              3 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowDoubleTap: (row) {
            viewModel.navigateToDetail(id: items[row].id);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    viewModel.navigateToDetail(id: items[row].id);
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () {
                    viewModel.copyItemSet(items[row].id);
                  },
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () {
                    viewModel.deleteItemSet(items[row].id);
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
}
