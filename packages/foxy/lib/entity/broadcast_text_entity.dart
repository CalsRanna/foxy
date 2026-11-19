import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'broadcast_text_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity()
class BroadcastTextEntity with _BroadcastTextEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.enumValues(
    '语言',
    values: GossipMenuOptionConstants.npcTextLanguages,
  )
  @FoxyFullField('LanguageID')
  final int languageId;

  @FoxyBriefField()
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
