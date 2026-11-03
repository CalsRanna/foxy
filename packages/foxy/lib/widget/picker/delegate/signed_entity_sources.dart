import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/model/picker/signed_entity_source.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:get_it/get_it.dart';

/// Built-in data sources: creatures / game objects / quest sorts / quest
/// areas.
class SignedEntitySources {
  static final instance = SignedEntitySources._();

  SignedEntitySources._();

  late final _creature = SignedEntitySource(
    title: '生物模板',
    errorLabel: '搜索生物模板失败',
    fetch: (page, id, name) async {
      final repo = GetIt.instance.get<CreatureTemplateRepository>();
      final items = await repo.getBriefCreatureTemplates(
        page: page,
        filter: CreatureTemplateFilter(entry: id, name: name),
      );
      return items
          .map((e) => SignedEntityBrief(id: e.entry, name: e.displayName))
          .toList();
    },
    count: (id, name) =>
        GetIt.instance.get<CreatureTemplateRepository>().countCreatureTemplates(
          filter: CreatureTemplateFilter(entry: id, name: name),
        ),
  );

  static SignedEntitySource get creature => instance._creature;

  late final _gameObject = SignedEntitySource(
    title: '游戏对象模板',
    errorLabel: '搜索游戏对象模板失败',
    fetch: (page, id, name) async {
      final repo = GetIt.instance.get<GameObjectTemplateRepository>();
      final items = await repo.getBriefGameObjectTemplates(
        page: page,
        filter: GameObjectTemplateFilter(entry: id, name: name),
      );
      return items
          .map((e) => SignedEntityBrief(id: e.entry, name: e.displayName))
          .toList();
    },
    count: (id, name) => GetIt.instance
        .get<GameObjectTemplateRepository>()
        .countGameObjectTemplates(
          filter: GameObjectTemplateFilter(entry: id, name: name),
        ),
  );

  static SignedEntitySource get gameObject => instance._gameObject;

  late final _questSort = SignedEntitySource(
    title: '任务排序',
    errorLabel: '搜索任务排序失败',
    fetch: (page, id, name) async {
      final repo = GetIt.instance.get<QuestSortRepository>();
      final items = await repo.getBriefQuestSorts(
        filter: QuestSortFilter(id: id, name: name),
        page: page,
      );
      return items
          .map((e) => SignedEntityBrief(id: e.id, name: e.sortNameLangZhCN))
          .toList();
    },
    count: (id, name) =>
        GetIt.instance.get<QuestSortRepository>().countQuestSorts(
          filter: QuestSortFilter(id: id, name: name),
        ),
  );

  static SignedEntitySource get questSort => instance._questSort;

  late final _areaTable = SignedEntitySource(
    title: '区域',
    errorLabel: '搜索区域失败',
    fetch: (page, id, name) async {
      final repo = GetIt.instance.get<AreaTableRepository>();
      final items = await repo.getBriefAreaTables(
        filter: AreaTableFilter(id: id, name: name),
        page: page,
      );
      return items
          .map((e) => SignedEntityBrief(id: e.id, name: e.areaNameLangZhCN))
          .toList();
    },
    count: (id, name) =>
        GetIt.instance.get<AreaTableRepository>().countAreaTables(
          filter: AreaTableFilter(id: id, name: name),
        ),
  );

  static SignedEntitySource get areaTable => instance._areaTable;
}
