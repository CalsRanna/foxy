import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'dbc_item_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_item')
class DbcItemEntity with _DbcItemEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('ClassID')
  final int classId;

  @FoxyBriefField()
  @FoxyFullField('SubclassID')
  final int subclassId;

  @FoxyFullField('Sound_override_subclassID')
  final int soundOverrideSubclassId;

  @FoxyFullField('Material')
  final int material;

  @FoxyBriefField()
  @FoxyFullField('DisplayInfoID')
  final int displayInfoId;

  @FoxyBriefField()
  @FoxyFullField('InventoryType')
  final int inventoryType;

  @FoxyFullField('SheatheType')
  final int sheatheType;

  const DbcItemEntity({
    this.id = 0,
    this.classId = 0,
    this.subclassId = 0,
    this.soundOverrideSubclassId = 0,
    this.material = 0,
    this.displayInfoId = 0,
    this.inventoryType = 0,
    this.sheatheType = 0,
  });

  factory DbcItemEntity.fromJson(Map<String, dynamic> json) =>
      _DbcItemEntityMixin.fromJson(json);
}
