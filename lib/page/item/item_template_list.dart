import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/model/item_template.dart';
import 'package:foxy/provider/item.dart';
import 'package:foxy/widget/breadcrumb.dart';
import 'package:foxy/widget/card.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/input.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:foxy/widget/table.dart';

@RoutePage()
class ItemTemplateListPage extends StatelessWidget {
  const ItemTemplateListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [_Breadcrumb(), _Header(), _Filter(), _Table()];
    return ListView(padding: EdgeInsets.all(16), children: children);
  }
}

class _Breadcrumb extends StatelessWidget {
  const _Breadcrumb();

  @override
  Widget build(BuildContext context) {
    final children = [
      BreadcrumbItem(onTap: () {}, child: Text('首页')),
      BreadcrumbItem(child: Text('物品')),
    ];
    return Breadcrumb(children: children);
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
    return FoxyCard(child: filter);
  }

  Future<void> reset(WidgetRef ref) async {
    final provider = itemTemplatesNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.reset();
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(vertical: 12);
    return Padding(padding: edgeInsets, child: Header('物品'));
  }
}

class _Pagination extends ConsumerWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = itemTemplateTotalProvider;
    final total = ref.watch(provider).valueOrNull;
    return Pagination(
      total: total ?? 0,
      onChange: (page) => handleChange(ref, page),
    );
  }

  void handleChange(WidgetRef ref, int page) {
    final provider = itemTemplatesNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.paginate(page);
  }
}

class _Table extends ConsumerWidget {
  const _Table();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(itemTemplatesNotifierProvider);
    return switch (provider) {
      AsyncData(:final value) => _buildData(value),
      AsyncLoading() => CircularProgressIndicator(),
      AsyncError(:final error) => Text(error.toString()),
      _ => const SizedBox(),
    };
  }

  Widget _buildData(List<ItemTemplate> templates) {
    final children = [
      FilledButton(onPressed: () {}, child: Text('新增')),
      const Spacer(),
      _Pagination()
    ];
    final toolbar = Row(children: children);
    final header = _buildHeader();
    final body = templates.map(_buildRow).toList();
    final table = ArcaneTable(header: header, body: body);
    final column = Column(children: [toolbar, table]);
    return FoxyCard(child: Padding(padding: EdgeInsets.all(16), child: column));
  }

  ArcaneTableHeader _buildHeader() {
    return ArcaneTableHeader(children: [
      ArcaneTableCell(width: 100, child: Text('编号')),
      ArcaneTableCell(child: Text('名称')),
      ArcaneTableCell(child: Text('类别')),
      ArcaneTableCell(child: Text('子类别')),
      ArcaneTableCell(child: Text('佩戴位置')),
      ArcaneTableCell(child: Text('物品等级')),
      ArcaneTableCell(child: Text('需求等级')),
    ]);
  }

  ArcaneTableRow _buildRow(ItemTemplate template) {
    final children = [
      ArcaneTableCell(width: 100, child: Text(template.entry.toString())),
      ArcaneTableCell(child: Text(template.name)),
      ArcaneTableCell(child: Text(template.className.toString())),
      ArcaneTableCell(child: Text(template.subclass.toString())),
      ArcaneTableCell(child: Text(template.inventoryType.toString())),
      ArcaneTableCell(child: Text(template.itemLevel.toString())),
      ArcaneTableCell(child: Text(template.requiredLevel.toString())),
    ];
    return ArcaneTableRow(children: children);
  }
}
