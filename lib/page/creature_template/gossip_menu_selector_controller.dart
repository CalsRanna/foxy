import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_filter_entity.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:get_it/get_it.dart';

class GossipMenuSelectorController extends SelectorController<BriefGossipMenuEntity> {
  final _repository = GetIt.instance.get<GossipMenuRepository>();

  String menuIdFilter = '';
  String textFilter = '';

  @override
  String get errorLabel => '搜索对话菜单失败';

  @override
  Future<void> performSearch() async {
    final filter = GossipMenuFilterEntity(menuId: menuIdFilter, text: textFilter);
    final result = await _repository.getBriefGossipMenus(filter: filter, page: page);
    final count = await _repository.countGossipMenus(filter: filter);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    menuIdFilter = '';
    textFilter = '';
  }
}
