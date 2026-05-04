import 'package:signals/signals.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_filter_entity.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class GossipMenuSelectorViewModel {
  final _repository = GossipMenuRepository();

  final menuIdFilter = signal('');
  final textFilter = signal('');
  final items = signal<List<BriefGossipMenuEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final filter = GossipMenuFilterEntity(
        menuId: menuIdFilter.value,
        text: textFilter.value,
      );
      final result = await _repository.getBriefGossipMenus(
        filter: filter,
        page: page.value,
      );
      final count = await _repository.countGossipMenus(filter: filter);
      items.value = result;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索对话菜单失败: $e');
      DialogUtil.instance.error('搜索对话菜单失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    menuIdFilter.value = '';
    textFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
