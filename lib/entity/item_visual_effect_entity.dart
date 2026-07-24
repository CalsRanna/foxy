import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'item_visual_effect_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_item_visual_effects')
class ItemVisualEffectEntity with _ItemVisualEffectEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('Model')
  final String model;

  const ItemVisualEffectEntity({this.id = 0, this.model = ''});

  factory ItemVisualEffectEntity.fromJson(Map<String, dynamic> json) =>
      _ItemVisualEffectEntityMixin.fromJson(json);
}
