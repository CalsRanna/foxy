import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'item_visuals_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_item_visuals')
class ItemVisualsEntity with _ItemVisualsEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Slot0')
  final int slot0;

  @FoxyBriefField()
  @FoxyFullField('Slot1')
  final int slot1;

  @FoxyBriefField()
  @FoxyFullField('Slot2')
  final int slot2;

  @FoxyBriefField()
  @FoxyFullField('Slot3')
  final int slot3;

  @FoxyBriefField()
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
