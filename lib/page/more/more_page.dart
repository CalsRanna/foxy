import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/more/more_view_model.dart';
import 'package:foxy/widget/header.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final viewModel = GetIt.instance.get<MoreViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('更多功能'),
      _buildSearch(),
      Expanded(child: _buildGrid()),
    ];
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: children,
    );
    return Padding(padding: const EdgeInsets.all(16.0), child: column);
  }

  Widget _buildSearch() {
    var searchInput = ShadInput(
      controller: viewModel.searchController,
      placeholder: const Text('搜索模块名称'),
      onChanged: (_) => viewModel.search(),
    );
    var resetButton = ShadButton.ghost(
      onPressed: viewModel.reset,
      size: ShadButtonSize.sm,
      child: const Text('重置'),
    );
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: [
        Expanded(child: searchInput),
        resetButton,
      ]),
    );
  }

  Widget _buildGrid() {
    return Watch((_) {
      final modules = viewModel.filteredModules.value;
      if (modules.isEmpty) {
        return Center(
          child: Text(
            '没有匹配的模块',
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
            ),
          ),
        );
      }
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.0,
        ),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          final column = index % 4;
          final row = index ~/ 4;
          return _ModuleCard(
            module: module,
            showRightBorder: column < 3,
            showTopBorder: row == 0,
            onTap: () => viewModel.navigateToModule(module),
          );
        },
      );
    });
  }
}

class _ModuleCard extends StatefulWidget {
  final ModuleItem module;
  final bool showRightBorder;
  final bool showTopBorder;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.module,
    required this.showRightBorder,
    required this.showTopBorder,
    required this.onTap,
  });

  @override
  State<_ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<_ModuleCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final surface = colorScheme.surface;

    final border = Border(
      right: widget.showRightBorder
          ? BorderSide(color: outline.withValues(alpha: 0.2))
          : BorderSide.none,
      top: widget.showTopBorder
          ? BorderSide(color: outline.withValues(alpha: 0.2))
          : BorderSide.none,
    );
    final boxShadow = hover
        ? [
            BoxShadow(
              blurRadius: 8,
              color: outline.withValues(alpha: 0.15),
              spreadRadius: 4,
            ),
          ]
        : [
            BoxShadow(
              blurRadius: 8,
              color: outline.withValues(alpha: 0.1),
              spreadRadius: 8,
            ),
          ];

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildDescription(),
      ],
    );

    final container = Container(
      decoration: BoxDecoration(
        border: border,
        boxShadow: boxShadow,
        color: surface,
      ),
      padding: const EdgeInsets.all(16),
      child: content,
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(onTap: widget.onTap, child: container),
    );
  }

  Widget _buildHeader() {
    final icon = Icon(widget.module.icon, size: 32);
    final name = Text(
      widget.module.name,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
    final tag = Text(
      widget.module.category.name.toUpperCase(),
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 16),
        Expanded(child: name),
        tag,
      ],
    );
  }

  Widget _buildDescription() {
    return SizedBox(
      height: 72,
      child: Text(
        widget.module.description,
        style: TextStyle(
          fontSize: 13,
          color: Theme.of(context)
              .colorScheme
              .onSurface
              .withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
