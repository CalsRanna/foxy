import 'package:foxy/model/creature_template.dart';
import 'package:foxy/service/creature.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'creature.g.dart';

@riverpod
class CreatureTemplateNotifier extends _$CreatureTemplateNotifier {
  @override
  Future<CreatureTemplate> build(int? entry) async {
    if (entry == null) return CreatureTemplate();
    return CreatureTemplateService().find(entry);
  }

  Future<void> store(CreatureTemplate template) async {
    final service = CreatureTemplateService();
    final maxPrimaryKey = await service.getMaxPrimaryKey();
    int primaryKey = 600000;
    if (maxPrimaryKey >= 600000) primaryKey = maxPrimaryKey + 1;
    template.entry = primaryKey;
    await service.store(template);
    state = AsyncData(template);
  }

  Future<void> updateCreatureTemplate(CreatureTemplate template) async {
    await CreatureTemplateService().update(template);
    state = AsyncData(template);
  }
}

@Riverpod(keepAlive: true)
class CreatureTemplatePageNotifier extends _$CreatureTemplatePageNotifier {
  @override
  int build() => 1;

  void paginate(int page) => state = page;
}

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

  Future<void> search({int? entry, String? name, String? subName}) async {
    final service = CreatureTemplateService();
    final templates = await service.search(
      entry: entry,
      name: name,
      subName: subName,
    );
    state = AsyncData(templates);
  }
}

@Riverpod(keepAlive: true)
class CreatureTemplateTotalNotifier extends _$CreatureTemplateTotalNotifier {
  @override
  Future<int> build() async {
    return CreatureTemplateService().count();
  }

  Future<void> count({int? entry, String? name, String? subName}) async {
    final total = await CreatureTemplateService().count(
      entry: entry,
      name: name,
      subName: subName,
    );
    state = AsyncData(total);
  }
}
