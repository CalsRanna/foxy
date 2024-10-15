import 'package:foxy/service/creature.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'creature.g.dart';

@Riverpod(keepAlive: true)
class CreatureTemplatesNotifier extends _$CreatureTemplatesNotifier {
  @override
  Future<List<CreatureTemplate>> build() async {
    return CreatureTemplateService().search(page: 1);
  }
}

@Riverpod(keepAlive: true)
Future<int> creatureTemplateTotal(CreatureTemplateTotalRef ref) {
  return CreatureTemplateService().count();
}
