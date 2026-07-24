import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'game_object_template_locale_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'gameobject_template_locale')
class GameObjectTemplateLocaleEntity with _GameObjectTemplateLocaleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('locale', key: true)
  final String locale;

  @FoxyBriefField()
  @FoxyFullField('name')
  final String name;

  @FoxyBriefField()
  @FoxyFullField('castBarCaption')
  final String castBarCaption;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const GameObjectTemplateLocaleEntity({
    this.entry = 0,
    this.locale = '',
    this.name = '',
    this.castBarCaption = '',
    this.verifiedBuild = 0,
  });

  factory GameObjectTemplateLocaleEntity.fromJson(Map<String, dynamic> json) =>
      _GameObjectTemplateLocaleEntityMixin.fromJson(json);
}
