import 'package:foxy/service/creature.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'creature.g.dart';

@Riverpod(keepAlive: true)
class CreatureTemplatesNotifier extends _$CreatureTemplatesNotifier {
  @override
  Future<List<CreatureTemplate>> build() async {
    return CreatureTemplateService().search(page: 1);
  }

  Future<void> paginate(int page) async {
    final templates = await CreatureTemplateService().search(page: page);
    state = AsyncData(templates);
  }
}

@Riverpod(keepAlive: true)
Future<int> creatureTemplateTotal(CreatureTemplateTotalRef ref) {
  return CreatureTemplateService().count();
}
