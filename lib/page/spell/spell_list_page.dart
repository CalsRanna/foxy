import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/model/spell.dart';
import 'package:foxy/page/spell/spell_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class SpellListPage extends StatefulWidget {
  const SpellListPage({super.key});

  @override
  State<SpellListPage> createState() => _SpellListPageState();
}

class _SpellListPageState extends State<SpellListPage> {
  final viewModel = GetIt.instance.get<SpellListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('法术列表'),
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
    var idInput = ShadInput(
      controller: viewModel.idController,
      placeholder: Text('编号（ID）'),
    );
    var nameInput = ShadInput(
      controller: viewModel.nameController,
      placeholder: Text('名称（name）'),
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
      Expanded(child: idInput),
      Expanded(child: nameInput),
      Expanded(flex: 2, child: row),
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: credentialChildren),
    );
  }

  Widget _buildIconAndName(BriefSpell spell) {
    final icon = spell.textureFilename
        .toLowerCase()
        .replaceAll('\\', '/')
        .replaceAll('interface/icons', 'asset/icon');
    var image = Image.asset(
      '$icon.png',
      height: 40,
      width: 40,
      fit: BoxFit.cover,
    );
    var children = [
      ClipRRect(borderRadius: BorderRadius.circular(6), child: image),
      Text(spell.displayName),
    ];
    return Row(children: children);
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus),
      onPressed: () => viewModel.navigateSpellDetailPage(context),
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

    final headers = ['编号', '名称', '子名称', '持续时间'];
    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var flexWidth = constraints.maxWidth - 200;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final spell = templates[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(spell.id.toString())),
              1 => ShadTableCell(child: _buildIconAndName(spell)),
              2 => ShadTableCell(child: Text(spell.displaySubtext)),
              3 => ShadTableCell(child: Text(spell.duration)),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(80),
              1 => FixedTableSpanExtent(flexWidth / 2),
              2 => FixedTableSpanExtent(flexWidth / 2),
              3 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowDoubleTap: (row) {
            viewModel.navigateSpellDetailPage(
              context,
              id: templates[row].id,
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
                    viewModel.navigateSpellDetailPage(
                      context,
                      id: templates[row].id,
                      name: templates[row].displayName,
                    );
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () {
                    viewModel.copySpell(templates[row].id);
                  },
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () {
                    viewModel.deleteSpell(templates[row].id);
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
