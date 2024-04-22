import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/api/creature.dart';
import 'package:foxy/widget/pagination.dart';

void main() {
  runApp(const Foxy());
}

class Foxy extends StatelessWidget {
  const Foxy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Microsoft YaHei',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.dashboard),
              label: Text('DASHBOARD'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.dashboard),
              label: Text('DASHBOARD'),
            ),
          ], selectedIndex: 0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text('首页'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text('/'),
                        ),
                        Text('生物'),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(child: Input(placeholder: 'entry')),
                        const SizedBox(width: 16),
                        Expanded(child: Input(placeholder: 'Name')),
                        const SizedBox(width: 16),
                        Expanded(child: Input(placeholder: '称号')),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {}, child: Text('查询')),
                              const SizedBox(width: 16),
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
                              ElevatedButton(
                                  onPressed: () {}, child: Text('新增')),
                              const Spacer(),
                              Pagination(total: total, onChange: handleChange)
                            ],
                          ),
                          Expanded(
                            child: ArcaneTable(templates: templates),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleChange(int page) async {
    final creatureTemplates = await CreatureTemplateApi().search(page: page);
    setState(() {
      templates = creatureTemplates;
    });
  }
}

class Input extends StatelessWidget {
  final String? placeholder;
  const Input({super.key, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.25),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: placeholder,
          hintStyle: TextStyle(height: 1.2),
        ),
        style: TextStyle(height: 1.2),
      ),
    );
  }
}

class ArcaneTable extends StatelessWidget {
  const ArcaneTable({
    super.key,
    required this.templates,
  });

  final List<CreatureTemplate> templates;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          _ArcaneTableCell(width: 100, child: Text('编号')),
          _ArcaneTableCell(child: Text('姓名')),
          _ArcaneTableCell(child: Text('称号')),
          _ArcaneTableCell(child: Text('最小等级')),
          _ArcaneTableCell(child: Text('最大等级')),
        ],
      ),
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _ArcaneTableRow(template: templates[index]);
          },
          itemCount: templates.length,
        ),
      )
    ]);
  }
}

class _ArcaneTableRow extends StatefulWidget {
  final CreatureTemplate template;
  const _ArcaneTableRow({super.key, required this.template});

  @override
  State<_ArcaneTableRow> createState() => _ArcaneTableRowState();
}

class _ArcaneTableRowState extends State<_ArcaneTableRow> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryContainer = colorScheme.primaryContainer;
    return MouseRegion(
      onEnter: handleEnter,
      onExit: handleExit,
      child: Container(
        color: hovered ? primaryContainer : null,
        child: Row(
          children: [
            _ArcaneTableCell(
                width: 100, child: Text(widget.template.entry.toString())),
            _ArcaneTableCell(child: Text(widget.template.name)),
            _ArcaneTableCell(child: Text(widget.template.subName)),
            _ArcaneTableCell(child: Text(widget.template.minLevel.toString())),
            _ArcaneTableCell(child: Text(widget.template.maxLevel.toString())),
          ],
        ),
      ),
    );
  }

  void handleEnter(PointerEnterEvent event) {
    setState(() {
      hovered = true;
    });
  }

  void handleExit(PointerExitEvent event) {
    setState(() {
      hovered = false;
    });
  }
}

class _ArcaneTableCell extends StatelessWidget {
  final double? width;
  final Widget? child;
  const _ArcaneTableCell({super.key, this.width, this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    return Expanded(
      flex: width == null ? 1 : 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: outline.withOpacity(0.25))),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        width: width,
        child: child,
      ),
    );
  }
}
