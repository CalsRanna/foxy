// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_template_locale_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'creature_template_locale')
class CreatureTemplateLocaleEntity with _CreatureTemplateLocaleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('locale', key: true)
  final String locale;

  @FoxyBriefField()
  @FoxyFullField('Name')
  final String name;

  @FoxyBriefField()
  @FoxyFullField('Title')
  final String title;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const CreatureTemplateLocaleEntity({
    this.entry = 0,
    this.locale = '',
    this.name = '',
    this.title = '',
    this.verifiedBuild = 0,
  });

  factory CreatureTemplateLocaleEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureTemplateLocaleEntityMixin.fromJson(json);
}
