import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/model/smart_script.dart';
import 'package:foxy/provider/application.dart';
import 'package:foxy/provider/smart_script.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/breadcrumb.dart';
import 'package:foxy/widget/card.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/input.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:foxy/widget/table.dart';

@RoutePage()
class SmartScriptListPage extends StatelessWidget {
  const SmartScriptListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [_Breadcrumb(), _Header(), _Filter(), _Table()];
    return ListView(padding: EdgeInsets.all(16), children: children);
  }
}

class _Breadcrumb extends ConsumerWidget {
  const _Breadcrumb();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashboard = FoxyBreadcrumbItem(
      onTap: () => navigateDashboard(context, ref),
      child: Text('首页'),
    );
    final children = [
      dashboard,
      FoxyBreadcrumbItem(child: Text('脚本')),
    ];
    return FoxyBreadcrumb(children: children);
  }

  void navigateDashboard(BuildContext context, WidgetRef ref) {
    final provider = selectedMenuIndexNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.select(0);
    AutoRouter.of(context).navigate(DashboardRoute());
  }
}

class _Filter extends ConsumerWidget {
  const _Filter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonChildren = [
      TextButton(onPressed: () {}, child: Text('查询')),
      const SizedBox(width: 8),
      TextButton(onPressed: () => reset(ref), child: Text('重置')),
    ];
    final credentialChildren = [
      Expanded(child: FoxyInput(placeholder: '编号（Entry）')),
      const SizedBox(width: 16),
      Expanded(child: FoxyInput(placeholder: '名称（Name）')),
      const SizedBox(width: 16),
      Expanded(child: FoxyInput(placeholder: '称号（Sub Name）')),
      const SizedBox(width: 16),
      Expanded(child: Row(children: buttonChildren)),
    ];
    final filter = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: credentialChildren),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FoxyCard(child: filter),
    );
  }

  Future<void> reset(WidgetRef ref) async {
    final provider = smartScriptsNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.reset();
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(vertical: 12);
    return Padding(padding: edgeInsets, child: FoxyHeader('脚本'));
  }
}

class _Pagination extends ConsumerWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = smartScriptTotalProvider;
    final total = ref.watch(provider).valueOrNull;
    return FoxyPagination(
      total: total ?? 0,
      onChange: (page) => handleChange(ref, page),
    );
  }

  void handleChange(WidgetRef ref, int page) {
    final provider = smartScriptsNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.paginate(page);
  }
}

class _Table extends ConsumerWidget {
  const _Table();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(smartScriptsNotifierProvider);
    return switch (provider) {
      AsyncData(:final value) => _buildData(value),
      AsyncError(:final error) => Text(error.toString()),
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      _ => const SizedBox(),
    };
  }

  Widget _buildData(List<SmartScript> templates) {
    final toolbarChildren = [
      FilledButton(onPressed: () {}, child: Text('新增')),
      const Spacer(),
      _Pagination()
    ];
    final toolbar = Row(children: toolbarChildren);
    final header = _buildHeader();
    final body = templates.map(_buildRow).toList();
    final table = FoxyTable(header: header, body: body);
    final column = Column(children: [toolbar, table]);
    return FoxyCard(child: Padding(padding: EdgeInsets.all(16), child: column));
  }

  FoxyTableHeader _buildHeader() {
    return FoxyTableHeader(children: [
      FoxyTableCell(width: 80, child: Text('编号')),
      FoxyTableCell(child: Text('备注')),
      FoxyTableCell(width: 80, child: Text('类型')),
      FoxyTableCell(width: 80, child: Text('ID')),
      FoxyTableCell(width: 80, child: Text('链接')),
      FoxyTableCell(width: 80, child: Text('事件类型')),
      FoxyTableCell(width: 80, child: Text('动作类型')),
      FoxyTableCell(width: 80, child: Text('目标类型')),
    ]);
  }

  FoxyTableRow _buildRow(SmartScript template) {
    final children = [
      FoxyTableCell(width: 80, child: Text(template.entryOrGuid.toString())),
      FoxyTableCell(child: Text(template.comment)),
      FoxyTableCell(width: 80, child: Text(template.sourceType.toString())),
      FoxyTableCell(width: 80, child: Text(template.id.toString())),
      FoxyTableCell(width: 80, child: Text(template.link.toString())),
      FoxyTableCell(width: 80, child: Text(template.eventType.toString())),
      FoxyTableCell(width: 80, child: Text(template.actionType.toString())),
      FoxyTableCell(width: 80, child: Text(template.targetType.toString())),
    ];
    return FoxyTableRow(children: children);
  }
}
