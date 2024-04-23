import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/api/creature.dart';
import 'package:foxy/provider/creature.dart';
import 'package:foxy/widget/input.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:foxy/widget/table.dart';

class CreatureTemplatesPage extends StatefulWidget {
  const CreatureTemplatesPage({super.key});

  @override
  State<CreatureTemplatesPage> createState() => _CreatureTemplatesPageState();
}

class _CreatureTemplatesPageState extends State<CreatureTemplatesPage> {
  List<CreatureTemplate> templates = [];
  int total = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final creatureTemplates = await CreatureTemplateApi().search(page: 1);
    final count = await CreatureTemplateApi().count();
    setState(() {
      templates = creatureTemplates;
      total = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline.withOpacity(0.85);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text('首页', style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('/'),
                ),
                Text('生物', style: TextStyle(color: outline)),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(child: Input(placeholder: '编号（entry）')),
                const SizedBox(width: 16),
                Expanded(child: Input(placeholder: '姓名（Name）')),
                const SizedBox(width: 16),
                Expanded(child: Input(placeholder: '称号（Sub Name）')),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      TextButton(onPressed: () {}, child: Text('查询')),
                      const SizedBox(width: 8),
                      TextButton(onPressed: () {}, child: Text('重置')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // const SizedBox(height: 16),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      FilledButton(onPressed: () {}, child: Text('新增')),
                      const Spacer(),
                      Pagination(total: total, onChange: handleChange)
                    ],
                  ),
                  Expanded(
                    child: Consumer(builder: (context, ref, child) {
                      final provider =
                          ref.watch(creatureTemplatesNotifierProvider);
                      return switch (provider) {
                        AsyncData(:final value) =>
                          ArcaneTable(templates: value),
                        AsyncError(:final error) => Text(error.toString()),
                        _ => const SizedBox(),
                      };
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void handleChange(int page) async {
    final creatureTemplates = await CreatureTemplateApi().search(page: page);
    setState(() {
      templates = creatureTemplates;
    });
  }
}
