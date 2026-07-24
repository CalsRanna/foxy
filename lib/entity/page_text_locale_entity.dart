import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'page_text_locale_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'page_text_locale')
class PageTextLocaleEntity with _PageTextLocaleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('locale', key: true)
  final String locale;

  @FoxyBriefField()
  @FoxyFullField('Text')
  final String text;

  @FoxyBriefField()
  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const PageTextLocaleEntity({
    this.id = 0,
    this.locale = '',
    this.text = '',
    this.verifiedBuild = 0,
  });

  factory PageTextLocaleEntity.fromJson(Map<String, dynamic> json) =>
      _PageTextLocaleEntityMixin.fromJson(json);
}
