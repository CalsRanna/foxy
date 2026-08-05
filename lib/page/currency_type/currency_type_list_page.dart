import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/currency_type_list_view_model.dart';
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
class CurrencyTypeListPage extends StatefulWidget {
  const CurrencyTypeListPage({super.key});

  @override
  State<CurrencyTypeListPage> createState() => _CurrencyTypeListPageState();
}

class _CurrencyTypeListPageState extends State<CurrencyTypeListPage> {
  final viewModel = GetIt.instance.get<CurrencyTypeListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('货币列表'),
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
      controller: viewModel.idController,
      placeholder: '编号（ID）',
    );
    var nameInput = FoxyStringInput(
      controller: viewModel.nameController,
      placeholder: '物品名称',
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
      Expanded(child: SizedBox()),
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

    final table = FoxyDataTable<BriefCurrencyTypeEntity>(
      queryVersion: viewModel.queryVersion.value,
      loading: viewModel.loading.value,
      pinnedRowCount: 1,
      rows: items,
      columns: [
        FoxyTableColumn.fixed(
          label: '编号',
          width: 120,
          cell: (_, item) => Text(item.id.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '物品编号',
          width: 120,
          cell: (_, item) => Text(item.itemId.toString()),
        ),
        FoxyTableColumn.flex(
          label: '名称',
          cell: (_, item) => Text(item.displayItemName),
        ),
        FoxyTableColumn.fixed(
          label: '分类',
          width: 120,
          cell: (_, item) => Text(item.categoryId.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '位索引',
          width: 120,
          cell: (_, item) => Text(item.bitIndex.toString()),
        ),
      ],
      onRowDoubleTap: (item) => _navigateToDetail(key: item.key),
      onRowSecondaryTapDownWithDetails: (item, details) {
        showFoxyContextMenu(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () => _navigateToDetail(key: item.key),
              child: Text('编辑'),
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

    var children = [
      if (viewModel.errorMessage.value != null)
        FoxyInlineError(message: viewModel.errorMessage.value),
      toolbar,
      Expanded(child: table),
    ];
    final column = Column(spacing: 16, children: children);
    return ShadCard(padding: EdgeInsets.fromLTRB(16, 16, 16, 0), child: column);
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
      DialogUtil.instance.error('删除失败：${foxyErrorMessage(error)}');
    }
  }

  void _navigateToDetail({int? key}) {
    GetIt.instance.get<RouterFacade>().navigateToDetail(
      route: CurrencyTypeDetailRoute(currencyTypeKey: key),
      parentMenu: RouterMenu.currencyType,
    );
  }
}
