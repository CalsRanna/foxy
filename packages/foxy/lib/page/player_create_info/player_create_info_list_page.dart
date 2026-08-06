import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/player_create_info_list_view_model.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class PlayerCreateInfoListPage extends StatefulWidget {
  const PlayerCreateInfoListPage({super.key});

  @override
  State<PlayerCreateInfoListPage> createState() =>
      _PlayerCreateInfoListPageState();
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
          FoxyHeader('出生信息列表'),
          _buildFilter(),
          Expanded(child: Watch((_) => _buildTable())),
        ],
      ),
    );
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
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: FoxyStringInput(
              controller: viewModel.raceController,
              placeholder: '种族 (race)',
            ),
          ),
          Expanded(
            child: FoxyStringInput(
              controller: viewModel.classController,
              placeholder: '职业 (class)',
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              spacing: 16,
              children: [
                ShadButton(
                  onPressed: viewModel.search,
                  size: ShadButtonSize.sm,
                  child: Text('查询'),
                ),
                ShadButton.ghost(
                  onPressed: viewModel.reset,
                  size: ShadButtonSize.sm,
                  child: Text('重置'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus, size: 16),
      onPressed: () => _navigateToDetail(),
      child: Text('新增'),
    );
    final infos = viewModel.items.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;
    var pagination = FoxyPagination(
      page: page,
      pageSize: 50,
      total: total,
      onChange: viewModel.paginate,
    );
    final toolbar = Row(children: [createButton, const Spacer(), pagination]);

    final table = FoxyDataTable<BriefPlayerCreateInfoEntity>(
      queryVersion: viewModel.queryVersion.value,
      loading: viewModel.loading.value,
      pinnedRowCount: 1,
      rows: infos,
      columns: [
        FoxyTableColumn.fixed(
          label: '种族',
          width: 120,
          cell: (_, info) => Text(info.race.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '职业',
          width: 120,
          cell: (_, info) => Text(info.class_.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '地图',
          width: 120,
          cell: (_, info) => Text(info.map.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '区域',
          width: 120,
          cell: (_, info) => Text(info.zone.toString()),
        ),
        FoxyTableColumn.flex(
          label: '坐标',
          cell: (_, info) => Text(
            '${info.positionX.toStringAsFixed(2)}, '
            '${info.positionY.toStringAsFixed(2)}, '
            '${info.positionZ.toStringAsFixed(2)}, '
            '${info.orientation.toStringAsFixed(2)}',
          ),
        ),
      ],
      onRowDoubleTap: (info) => _navigateToDetail(info: info),
      onRowSecondaryTapDownWithDetails: (info, details) {
        showFoxyContextMenu(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () => _navigateToDetail(info: info),
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              enabled: !viewModel.submitting.value,
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(info.key),
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

  Future<void> _destroy(PlayerCreateInfoKey key) async {
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
      DialogUtil.instance.error('删除失败：${foxyErrorMessage(error)}');
    }
  }

  void _navigateToDetail({BriefPlayerCreateInfoEntity? info}) {
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      route: PlayerCreateInfoDetailRoute(playerCreateInfoKey: info?.key),
      parentMenu: RouterMenu.playerCreateInfo,
    );
  }
}
