// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'page_text_entity.g.dart';

@FoxyFilterEntity()
@FoxyFullEntity(table: 'page_text')
class PageTextEntity with _PageTextEntityMixin {
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('Text')
  final String text;

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
