import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/page/feature/feature_state_view_model.dart';
import 'package:foxy/page/more/more_read_view_model.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_feature_card.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
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
  final viewModel = GetIt.instance.get<MoreReadViewModel>();
  final featureState = GetIt.instance.get<FeatureStateViewModel>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  void Function()? _featureSubscription;

  @override
  void initState() {
    super.initState();
    viewModel.setFeatures(featureState.allFeatures.value);
    viewModel.initSignals();
    _featureSubscription = featureState.allFeatures.subscribe(
      viewModel.setFeatures,
    );
  }

  @override
  void dispose() {
    _featureSubscription?.call();
    viewModel.dispose();
    super.dispose();
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
    var searchInput = FoxyStringInput(
      controller: viewModel.searchController,
      placeholder: '搜索模块名称',
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
          childAspectRatio: 3 / 2,
        ),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          return FoxyFeatureCard(
            feature: module,
            onTap: () => _navigateToModule(module),
            onSecondaryTap: (position) =>
                _showContextMenu(context, module, position),
          );
        },
      );
    });
  }

  void _showContextMenu(
    BuildContext context,
    FeatureEntity feature,
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
          onPressed: () => _togglePinned(feature),
          child: Text(feature.isPinned ? '取消固定' : '钉到侧边栏'),
        ),
        ShadContextMenuItem(
          leading: Icon(
            feature.isFavorite ? LucideIcons.starOff : LucideIcons.star,
            size: 16,
          ),
          onPressed: () => _toggleFavorite(feature),
          child: Text(feature.isFavorite ? '取消收藏' : '收藏到首页'),
        ),
      ],
    );
  }

  void _navigateToModule(FeatureEntity module) {
    routerFacade.navigateToMenu(
      RouterMenu.values.byName(module.routerMenu),
      parentMenu: module.isPinned ? null : RouterMenu.more,
    );
  }

  Future<void> _toggleFavorite(FeatureEntity feature) async {
    try {
      await featureState.toggleFavorite(feature.id);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('更新收藏状态失败：$error');
    }
  }

  Future<void> _togglePinned(FeatureEntity feature) async {
    try {
      await featureState.togglePinned(feature.id);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('更新固定状态失败：$error');
    }
  }
}
