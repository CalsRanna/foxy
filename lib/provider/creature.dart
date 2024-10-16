import 'package:foxy/model/creature_template.dart';
import 'package:foxy/service/creature.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'creature.g.dart';

@Riverpod(keepAlive: true)
class CreatureTemplatesNotifier extends _$CreatureTemplatesNotifier {
  @override
  Future<List<BriefCreatureTemplate>> build() async {
    return CreatureTemplateService().search();
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

@riverpod
class CreatureTemplateNotifier extends _$CreatureTemplateNotifier {
  @override
  Future<CreatureTemplate> build(int? entry) async {
    if (entry == null) return CreatureTemplate();
    return CreatureTemplateService().find(entry);
  }
}
