import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/player_create_info/player_create_info_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class PlayerCreateInfoListPage extends StatefulWidget {
  const PlayerCreateInfoListPage({super.key});

  @override
  State<PlayerCreateInfoListPage> createState() => _PlayerCreateInfoListPageState();
}

class _PlayerCreateInfoListPageState extends State<PlayerCreateInfoListPage> {
  final viewModel = GetIt.instance.get<PlayerCreateInfoListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyHeader('玩家出生信息列表'),
          _buildFilter(),
          Expanded(child: Watch((_) => _buildTable())),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  Widget _buildFilter() {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: [
        Expanded(child: ShadInput(
          controller: viewModel.raceController,
          placeholder: Text('种族 (race)'),
        )),
        Expanded(child: ShadInput(
          controller: viewModel.classController,
          placeholder: Text('职业 (class)'),
        )),
        Expanded(flex: 2, child: Row(spacing: 16, children: [
          ShadButton(onPressed: viewModel.search, size: ShadButtonSize.sm, child: Text('查询')),
          ShadButton.ghost(onPressed: viewModel.reset, size: ShadButtonSize.sm, child: Text('重置')),
        ])),
      ]),
    );
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus),
      onPressed: () => viewModel.navigateToDetail(),
      child: Text('新增'),
    );
    final infos = viewModel.infos.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;
    var pagination = FoxyPagination(page: page, pageSize: 50, total: total, onChange: viewModel.paginate);
    final toolbar = Row(children: [createButton, const Spacer(), pagination]);

    final headers = ['种族', '职业', '地图', '区域', 'X坐标', 'Y坐标', 'Z坐标', '朝向'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        return FoxyShadTable(
          builder: (context, vicinity) {
            final info = infos[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(info.race.toString())),
              1 => ShadTableCell(child: Text(info.class_.toString())),
              2 => ShadTableCell(child: Text(info.map.toString())),
              3 => ShadTableCell(child: Text(info.zone.toString())),
              4 => ShadTableCell(child: Text(info.positionX.toStringAsFixed(2))),
              5 => ShadTableCell(child: Text(info.positionY.toStringAsFixed(2))),
              6 => ShadTableCell(child: Text(info.positionZ.toStringAsFixed(2))),
              7 => ShadTableCell(child: Text(info.orientation.toStringAsFixed(2))),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(100),
              1 => FixedTableSpanExtent(100),
              2 => FixedTableSpanExtent(100),
              3 => FixedTableSpanExtent(100),
              4 => FixedTableSpanExtent(100),
              5 => FixedTableSpanExtent(100),
              6 => FixedTableSpanExtent(100),
              7 => FixedTableSpanExtent(100),
              _ => null,
            };
          },
          header: (context, index) => ShadTableCell.header(child: Text(headers[index])),
          onRowDoubleTap: (row) => viewModel.navigateToDetail(info: infos[row]),
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => viewModel.navigateToDetail(info: infos[row]),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.copyPlayerCreateInfo(infos[row]),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.deletePlayerCreateInfo(infos[row]),
                  child: Text('删除'),
                ),
              ],
            );
          },
          pinnedRowCount: 1,
          rowCount: infos.length,
        );
      },
    );

    return ShadCard(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(spacing: 16, children: [toolbar, Expanded(child: layoutBuilder)]),
    );
  }
}
