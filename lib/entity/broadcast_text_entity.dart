// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'broadcast_text_entity.g.dart';

@FoxyFullEntity(table: 'broadcast_text')
class BroadcastTextEntity with _BroadcastTextEntityMixin {
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('LanguageID')
  final int languageId;

  @FoxyFullField('MaleText')
  final String maleText;

  @FoxyFullField('FemaleText')
  final String femaleText;

  const BroadcastTextEntity({
    this.id = 0,
    this.languageId = 0,
    this.maleText = '',
    this.femaleText = '',
  });

  factory BroadcastTextEntity.fromJson(Map<String, dynamic> json) =>
      _BroadcastTextEntityMixin.fromJson(json);

  String get displayText {
    if (maleText.isNotEmpty) return maleText;
    return femaleText;
  }
}
