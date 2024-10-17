import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/provider/creature.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/breadcrumb.dart';
import 'package:foxy/widget/header.dart';
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

class _Breadcrumb extends StatelessWidget {
  const _Breadcrumb();

  @override
  Widget build(BuildContext context) {
    final children = [
      BreadcrumbItem(onTap: () {}, child: Text('首页')),
      BreadcrumbItem(child: Text('生物')),
    ];
    return Breadcrumb(children: children);
  }
}

class _CreatureTemplateListPageState extends State<CreatureTemplateListPage> {
  int total = 0;

  @override
  Widget build(BuildContext context) {
    final children = [_Breadcrumb(), _Header(), _Filter(), _Table()];
    return ListView(padding: EdgeInsets.all(16), children: children);
  }
}

class _Filter extends StatelessWidget {
  const _Filter();

  @override
  Widget build(BuildContext context) {
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
    return Card(child: filter);
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(vertical: 12);
    return Padding(padding: edgeInsets, child: Header('生物'));
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
      AsyncData(:final value) => _buildData(context, value),
      AsyncLoading() => CircularProgressIndicator.adaptive(),
      AsyncError(:final error) => Text(error.toString()),
      _ => const SizedBox(),
    };
  }

  void handleDoubleTap(BuildContext context, BriefCreatureTemplate template) {
    final route = CreatureTemplateRoute(entry: template.entry);
    AutoRouter.of(context).push(route);
  }

  Widget _buildData(
    BuildContext context,
    List<BriefCreatureTemplate> templates,
  ) {
    final children = [
      FilledButton(onPressed: () {}, child: Text('新增')),
      const Spacer(),
      _Pagination()
    ];
    final toolbar = Row(children: children);
    final header = _buildHeader();
    final body = templates.map((template) {
      return _buildRow(context, template);
    }).toList();
    final table = ArcaneTable(header: header, body: body);
    final column = Column(children: [toolbar, table]);
    return Card(child: Padding(padding: EdgeInsets.all(16), child: column));
  }

  ArcaneTableHeader _buildHeader() {
    return ArcaneTableHeader(children: [
      ArcaneTableCell(width: 100, child: Text('编号')),
      ArcaneTableCell(child: Text('姓名')),
      ArcaneTableCell(child: Text('称号')),
      ArcaneTableCell(child: Text('最低等级')),
      ArcaneTableCell(child: Text('最高等级')),
    ]);
  }

  ArcaneTableRow _buildRow(
    BuildContext context,
    BriefCreatureTemplate template,
  ) {
    final children = [
      ArcaneTableCell(width: 100, child: Text(template.entry.toString())),
      ArcaneTableCell(child: Text(template.name)),
      ArcaneTableCell(child: Text(template.subName)),
      ArcaneTableCell(child: Text(template.minLevel.toString())),
      ArcaneTableCell(child: Text(template.maxLevel.toString())),
    ];
    return ArcaneTableRow(
      onDoubleTap: () => handleDoubleTap(context, template),
      children: children,
    );
  }
}