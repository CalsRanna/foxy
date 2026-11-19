import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'item_visuals_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_item_visuals')
class ItemVisualsEntity with _ItemVisualsEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference(
    '视觉效果0',
    table: 'foxy.dbc_item_visual_effects',
    column: 'ID',
  )
  @FoxyFullField('Slot0')
  final int slot0;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference(
    '视觉效果1',
    table: 'foxy.dbc_item_visual_effects',
    column: 'ID',
  )
  @FoxyFullField('Slot1')
  final int slot1;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference(
    '视觉效果2',
    table: 'foxy.dbc_item_visual_effects',
    column: 'ID',
  )
  @FoxyFullField('Slot2')
  final int slot2;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference(
    '视觉效果3',
    table: 'foxy.dbc_item_visual_effects',
    column: 'ID',
  )
  @FoxyFullField('Slot3')
  final int slot3;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference(
    '视觉效果4',
    table: 'foxy.dbc_item_visual_effects',
    column: 'ID',
  )
  @FoxyFullField('Slot4')
  final int slot4;

  const ItemVisualsEntity({
    this.id = 0,
    this.slot0 = 0,
    this.slot1 = 0,
    this.slot2 = 0,
    this.slot3 = 0,
    this.slot4 = 0,
  });

  factory ItemVisualsEntity.fromJson(Map<String, dynamic> json) =>
      _ItemVisualsEntityMixin.fromJson(json);
}
