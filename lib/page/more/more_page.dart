import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/model/feature.dart';
import 'package:foxy/page/more/more_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/feature_card.dart';
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
    var searchButton = ShadButton(
      onPressed: viewModel.search,
      size: ShadButtonSize.sm,
      child: const Text('查询'),
    );
    var resetButton = ShadButton.ghost(
      onPressed: viewModel.reset,
      size: ShadButtonSize.sm,
      child: const Text('重置'),
    );
    var buttonsRow = Row(spacing: 16, children: [searchButton, resetButton]);
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(child: searchInput),
          Expanded(flex: 3, child: buttonsRow),
        ],
      ),
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
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
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
          return FeatureCard(
            feature: module,
            onTap: () => viewModel.navigateToModule(module),
            onSecondaryTap: (position) =>
                _showContextMenu(context, module, position),
          );
        },
      );
    });
  }

  void _showContextMenu(
    BuildContext context,
    Feature feature,
    Offset position,
  ) {
    showFoxyContextMenu(
      context: context,
      position: position,
      items: [
        ShadContextMenuItem(
          leading: Icon(
            feature.isPinned ? LucideIcons.pinOff : LucideIcons.pin,
            size: 16,
          ),
          onPressed: () => viewModel.togglePinned(feature),
          child: Text(feature.isPinned ? '取消固定' : '钉到侧边栏'),
        ),
        ShadContextMenuItem(
          leading: Icon(
            feature.isFavorite ? LucideIcons.starOff : LucideIcons.star,
            size: 16,
          ),
          onPressed: () => viewModel.toggleFavorite(feature),
          child: Text(feature.isFavorite ? '取消收藏' : '收藏到首页'),
        ),
      ],
    );
  }
}
