import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/page/spell/spell_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_game_asset_icon.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_string_input.dart';
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
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

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
    var idInput = FoxyStringInput(
      controller: viewModel.idController,
      placeholder: '编号（ID）',
    );
    var nameInput = FoxyStringInput(
      controller: viewModel.nameController,
      placeholder: '名称（name）',
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

  Widget _buildIconAndName(BriefSpellEntity spell) {
    var children = [
      ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: FoxyGameAssetIcon(rawPath: spell.textureFilename),
      ),
      Expanded(
        child: Text(
          spell.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];
    return Row(spacing: 8, children: children);
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus, size: 16),
      onPressed: () => viewModel.navigateToDetail(),
      child: Text('新增'),
    );
    final templates = viewModel.spells.value;
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

    final headers = ['编号', '名称', '子名称', '描述', 'Buff描述'];
    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var flexWidth = constraints.maxWidth - 360;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= templates.length) {
              return ShadTableCell(child: SizedBox());
            }
            final spell = templates[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(spell.id.toString())),
              1 => ShadTableCell(child: _buildIconAndName(spell)),
              2 => ShadTableCell(child: Text(spell.displaySubtext)),
              3 => ShadTableCell(
                child: Text(
                  spell.displayDescription,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              4 => ShadTableCell(
                child: Text(
                  spell.displayAuraDescription,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(flexWidth / 3),
              2 => FixedTableSpanExtent(240),
              3 => FixedTableSpanExtent(flexWidth / 3),
              4 => FixedTableSpanExtent(flexWidth / 3),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowDoubleTap: (row) {
            viewModel.navigateToDetail(
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
                    viewModel.navigateToDetail(
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
