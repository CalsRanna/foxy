import 'package:foxy/model/game_object_template.dart';
import 'package:foxy/service/game_object_template.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_object_template.g.dart';

@Riverpod(keepAlive: true)
Future<int> gameObjectTemplateTotal(GameObjectTemplateTotalRef ref) {
  return GameObjectTemplateService().count();
}

@Riverpod(keepAlive: true)
class GameObjectTemplatesNotifier extends _$GameObjectTemplatesNotifier {
  @override
  Future<List<GameObjectTemplate>> build() async {
    return GameObjectTemplateService().search();
  }

  Future<void> paginate(int page) async {
    final templates = await GameObjectTemplateService().search(page: page);
    state = AsyncData(templates);
  }

  Future<void> reset() async {
    ref.invalidateSelf();
    await future;
  }
}
