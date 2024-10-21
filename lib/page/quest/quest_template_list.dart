import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/model/quest_template.dart';
import 'package:foxy/provider/application.dart';
import 'package:foxy/provider/quest_template.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/breadcrumb.dart';
import 'package:foxy/widget/card.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/input.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:foxy/widget/table.dart';

@RoutePage()
class QuestTemplateListPage extends StatelessWidget {
  const QuestTemplateListPage({super.key});

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
    var dashboard = ArcaneBreadcrumbItem(
      onTap: () => navigateDashboard(context, ref),
      child: Text('首页'),
    );
    final children = [
      dashboard,
      ArcaneBreadcrumbItem(child: Text('任务')),
    ];
    return ArcaneBreadcrumb(children: children);
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
      Expanded(child: ArcaneInput(placeholder: '编号（Entry）')),
      const SizedBox(width: 16),
      Expanded(child: ArcaneInput(placeholder: '名称（Name）')),
      const SizedBox(width: 16),
      Expanded(child: ArcaneInput(placeholder: '称号（Sub Name）')),
      const SizedBox(width: 16),
      Expanded(child: Row(children: buttonChildren)),
    ];
    final filter = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: credentialChildren),
    );
    return ArcaneCard(child: filter);
  }

  Future<void> reset(WidgetRef ref) async {
    final provider = questTemplatesNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.reset();
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(vertical: 12);
    return Padding(padding: edgeInsets, child: ArcaneHeader('任务'));
  }
}

class _Pagination extends ConsumerWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = questTemplateTotalProvider;
    final total = ref.watch(provider).valueOrNull;
    return ArcanePagination(
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
      AsyncLoading() => CircularProgressIndicator(),
      AsyncError(:final error) => Text(error.toString()),
      _ => const SizedBox(),
    };
  }

  Widget _buildData(List<QuestTemplate> templates) {
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
    return ArcaneCard(
        child: Padding(padding: EdgeInsets.all(16), child: column));
  }

  ArcaneTableHeader _buildHeader() {
    return ArcaneTableHeader(children: [
      ArcaneTableCell(width: 80, child: Text('编号')),
      ArcaneTableCell(width: 160, child: Text('标题')),
      ArcaneTableCell(child: Text('描述')),
      ArcaneTableCell(width: 80, child: Text('类型')),
      ArcaneTableCell(width: 80, child: Text('等级')),
      ArcaneTableCell(width: 80, child: Text('最低等级')),
    ]);
  }

  ArcaneTableRow _buildRow(QuestTemplate template) {
    final children = [
      ArcaneTableCell(width: 80, child: Text(template.entry.toString())),
      ArcaneTableCell(width: 160, child: Text(template.title)),
      ArcaneTableCell(child: Text(template.description)),
      ArcaneTableCell(width: 80, child: Text(template.type.toString())),
      ArcaneTableCell(width: 80, child: Text(template.level.toString())),
      ArcaneTableCell(width: 80, child: Text(template.minLevel.toString())),
    ];
    return ArcaneTableRow(children: children);
  }
}
