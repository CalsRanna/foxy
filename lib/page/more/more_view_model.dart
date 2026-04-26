import 'package:flutter/material.dart';
import 'package:foxy/model/feature.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/feature_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class MoreViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final featureViewModel = GetIt.instance.get<FeatureViewModel>();

  final searchController = TextEditingController();
  final filteredModules = signal<List<Feature>>([]);

  List<Feature> get _allModules => featureViewModel.allFeatures.value;

  void initSignals() {
    filteredModules.value = List.of(_allModules);
  }

  void search() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      filteredModules.value = List.of(_allModules);
    } else {
      filteredModules.value = _allModules
          .where((m) => m.name.toLowerCase().contains(query))
          .toList();
    }
  }

  void reset() {
    searchController.clear();
    filteredModules.value = List.of(_allModules);
  }

  void navigateToModule(Feature module) {
    final menu = RouterMenu.values.byName(module.routerMenu);
    final isSidebarModule = module.isPinned;
    routerFacade.navigateToMenu(
      menu,
      parentMenu: isSidebarModule ? null : RouterMenu.more,
    );
  }

  Future<void> togglePinned(Feature feature) async {
    await featureViewModel.togglePinned(feature.id);
    search();
  }

  Future<void> toggleFavorite(Feature feature) async {
    await featureViewModel.toggleFavorite(feature.id);
    // 刷新搜索结果
    search();
  }

  void dispose() {
    searchController.dispose();
  }
}
