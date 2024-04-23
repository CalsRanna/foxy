import 'package:foxy/service/creature.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'creature.g.dart';

@riverpod
class CreatureTemplatesNotifier extends _$CreatureTemplatesNotifier {
  @override
  Future<List<CreatureTemplate>> build() async {
    return await CreatureTemplateService().search(page: 1);
  }
}
