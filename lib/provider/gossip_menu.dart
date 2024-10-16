import 'package:foxy/model/gossip_menu.dart';
import 'package:foxy/service/gossip_menu.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gossip_menu.g.dart';

@Riverpod(keepAlive: true)
Future<int> gossipMenuTotal(GossipMenuTotalRef ref) {
  return GossipMenuService().count();
}

@Riverpod(keepAlive: true)
class GossipMenusNotifier extends _$GossipMenusNotifier {
  @override
  Future<List<GossipMenu>> build() async {
    return GossipMenuService().search();
  }

  Future<void> paginate(int page) async {
    final templates = await GossipMenuService().search(page: page);
    state = AsyncData(templates);
  }

  Future<void> reset() async {
    ref.invalidateSelf();
    await future;
  }
}
