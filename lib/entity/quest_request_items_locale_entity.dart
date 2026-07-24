import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'quest_request_items_locale_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'quest_request_items_locale')
class QuestRequestItemsLocaleEntity with _QuestRequestItemsLocaleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('locale', key: true)
  final String locale;

  @FoxyBriefField()
  @FoxyFullField('CompletionText')
  final String completionText;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const QuestRequestItemsLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.completionText = '',
    this.verifiedBuild = 0,
  });

  factory QuestRequestItemsLocaleEntity.fromJson(Map<String, dynamic> json) =>
      _QuestRequestItemsLocaleEntityMixin.fromJson(json);
}
