import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class MoreViewModel with FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final scaffoldViewModel = GetIt.instance.get<ScaffoldViewModel>();

  late final searchController = registerController(StringFieldController());
  final filteredModules = signal<List<FeatureEntity>>([]);

  List<FeatureEntity> get _allModules => scaffoldViewModel.allFeatures.value;

  void initSignals() {
    searchController.addListener(search);
    filteredModules.value = List.of(_allModules);
  }

  void search() {
    final query = searchController.collect().trim().toLowerCase();
    if (query.isEmpty) {
      filteredModules.value = List.of(_allModules);
    } else {
      filteredModules.value = _allModules
          .where((m) => m.name.toLowerCase().contains(query))
          .toList();
    }
  }

  void reset() {
    searchController.init('');
    filteredModules.value = List.of(_allModules);
  }

  void navigateToModule(FeatureEntity module) {
    final menu = RouterMenu.values.byName(module.routerMenu);
    final isSidebarModule = module.isPinned;
    routerFacade.navigateToMenu(
      menu,
      parentMenu: isSidebarModule ? null : RouterMenu.more,
    );
  }

  Future<void> togglePinned(FeatureEntity feature) async {
    await scaffoldViewModel.togglePinned(feature.id);
    search();
  }

  Future<void> toggleFavorite(FeatureEntity feature) async {
    await scaffoldViewModel.toggleFavorite(feature.id);
    // 刷新搜索结果
    search();
  }

  void dispose() {
    disposeControllers();
  }
}
