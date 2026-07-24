import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'page_text_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('localeText')
@FoxyFilterEntity()
@FoxyFullEntity(table: 'page_text')
class PageTextEntity with _PageTextEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('Text')
  final String text;

  @FoxyBriefField()
  @FoxyFullField('NextPageID')
  final int nextPageId;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const PageTextEntity({
    this.id = 0,
    this.text = '',
    this.nextPageId = 0,
    this.verifiedBuild = 0,
  });

  factory PageTextEntity.fromJson(Map<String, dynamic> json) =>
      _PageTextEntityMixin.fromJson(json);
}

extension BriefPageTextEntityDisplay on BriefPageTextEntity {
  String get displayText => localeText.isNotEmpty ? localeText : text;
}
