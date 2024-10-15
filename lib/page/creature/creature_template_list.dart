import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/provider/creature.dart';
import 'package:foxy/widget/input.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:foxy/widget/table.dart';

@RoutePage()
class CreatureTemplateListPage extends StatefulWidget {
  const CreatureTemplateListPage({super.key});

  @override
  State<CreatureTemplateListPage> createState() =>
      _CreatureTemplateListPageState();
}

class _CreatureTemplateListPageState extends State<CreatureTemplateListPage> {
  int total = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline.withOpacity(0.85);
    final toolbarChildren = [
      FilledButton(onPressed: () {}, child: Text('新增')),
      const Spacer(),
      _Pagination()
    ];
    final tableChildren = [
      Row(children: toolbarChildren),
      Expanded(child: _Table())
    ];
    final table = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: tableChildren),
    );
    const edgeInsets = EdgeInsets.symmetric(horizontal: 8.0);
    final breadcrumbChildren = [
      Text('首页', style: TextStyle(fontWeight: FontWeight.bold)),
      Padding(padding: edgeInsets, child: Text('/')),
      Text('生物', style: TextStyle(color: outline)),
    ];
    final breadcrumb = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: breadcrumbChildren),
    );
    final buttonChildren = [
      TextButton(onPressed: () {}, child: Text('查询')),
      const SizedBox(width: 8),
      TextButton(onPressed: () {}, child: Text('重置')),
    ];
    final credentialChildren = [
      Expanded(child: FoxyInput(placeholder: '编号（entry）')),
      const SizedBox(width: 16),
      Expanded(child: FoxyInput(placeholder: '姓名（Name）')),
      const SizedBox(width: 16),
      Expanded(child: FoxyInput(placeholder: '称号（Sub Name）')),
      const SizedBox(width: 16),
      Expanded(child: Row(children: buttonChildren)),
    ];
    final filter = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: credentialChildren),
    );
    final children = [
      Card(child: breadcrumb),
      Card(child: filter),
      Expanded(child: Card(child: table)),
    ];
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
    return Padding(padding: const EdgeInsets.all(16.0), child: column);
  }
}

class _Pagination extends ConsumerWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = creatureTemplateTotalProvider;
    final total = ref.watch(provider).valueOrNull;
    return Pagination(
      total: total ?? 0,
      onChange: (page) => handleChange(ref, page),
    );
  }

  void handleChange(WidgetRef ref, int page) {
    final provider = creatureTemplatesNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.paginate(page);
  }
}

class _Table extends ConsumerWidget {
  const _Table();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(creatureTemplatesNotifierProvider);
    return switch (provider) {
      AsyncData(:final value) => _buildData(value),
      AsyncLoading() => CircularProgressIndicator.adaptive(),
      AsyncError(:final error) => Text(error.toString()),
      _ => const SizedBox(),
    };
  }

  Widget _buildData(List<CreatureTemplate> templates) {
    final header = ArcaneTableHeader(children: [
      ArcaneTableCell(width: 100, child: Text('编号')),
      ArcaneTableCell(child: Text('姓名')),
      ArcaneTableCell(child: Text('称号')),
      ArcaneTableCell(child: Text('最低等级')),
      ArcaneTableCell(child: Text('最高等级')),
    ]);
    final body = templates.map(_buildRow).toList();
    return ArcaneTable(header: header, body: body);
  }

  ArcaneTableRow _buildRow(CreatureTemplate template) {
    final children = [
      ArcaneTableCell(width: 100, child: Text(template.entry.toString())),
      ArcaneTableCell(child: Text(template.name)),
      ArcaneTableCell(child: Text(template.subName)),
      ArcaneTableCell(child: Text(template.minLevel.toString())),
      ArcaneTableCell(child: Text(template.maxLevel.toString())),
    ];
    return ArcaneTableRow(children: children);
  }
}
