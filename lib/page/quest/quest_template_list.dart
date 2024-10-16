import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/model/quest_template.dart';
import 'package:foxy/provider/quest_template.dart';
import 'package:foxy/widget/input.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:foxy/widget/table.dart';

@RoutePage()
class QuestTemplateListPage extends StatelessWidget {
  const QuestTemplateListPage({super.key});

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
      Text('任务', style: TextStyle(color: outline)),
    ];
    final breadcrumb = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: breadcrumbChildren),
    );
    final children = [
      Card(child: breadcrumb),
      _Filter(),
      Expanded(child: Card(child: table)),
    ];
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
    return Padding(padding: const EdgeInsets.all(16.0), child: column);
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
    return Card(child: filter);
  }

  Future<void> reset(WidgetRef ref) async {
    final provider = questTemplatesNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.reset();
  }
}

class _Pagination extends ConsumerWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = questTemplateTotalProvider;
    final total = ref.watch(provider).valueOrNull;
    return Pagination(
      total: total ?? 0,
      onChange: (page) => handleChange(ref, page),
    );
  }

  void handleChange(WidgetRef ref, int page) {
    final provider = questTemplatesNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.paginate(page);
  }
}

class _Table extends ConsumerWidget {
  const _Table();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(questTemplatesNotifierProvider);
    return switch (provider) {
      AsyncData(:final value) => _buildData(value),
      AsyncLoading() => CircularProgressIndicator.adaptive(),
      AsyncError(:final error) => Text(error.toString()),
      _ => const SizedBox(),
    };
  }

  Widget _buildData(List<QuestTemplate> templates) {
    final header = ArcaneTableHeader(children: [
      ArcaneTableCell(width: 80, child: Text('编号')),
      ArcaneTableCell(width: 100, child: Text('标题')),
      ArcaneTableCell(width: 400, child: Text('描述')),
      ArcaneTableCell(child: Text('类型')),
      ArcaneTableCell(child: Text('等级')),
      ArcaneTableCell(child: Text('最低等级')),
    ]);
    final body = templates.map(_buildRow).toList();
    return ArcaneTable(header: header, body: body);
  }

  ArcaneTableRow _buildRow(QuestTemplate template) {
    final children = [
      ArcaneTableCell(width: 80, child: Text(template.entry.toString())),
      ArcaneTableCell(width: 100, child: Text(template.title)),
      ArcaneTableCell(width: 400, child: Text(template.description)),
      ArcaneTableCell(child: Text(template.type.toString())),
      ArcaneTableCell(child: Text(template.level.toString())),
      ArcaneTableCell(child: Text(template.minLevel.toString())),
    ];
    return ArcaneTableRow(children: children);
  }
}
