// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'gem_property_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_gem_properties')
class GemPropertyEntity with _GemPropertyEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Enchant_ID')
  final int enchantId;

  @FoxyBriefField()
  @FoxyFullField('Maxcount_inv')
  final int maxCountInv;

  @FoxyBriefField()
  @FoxyFullField('Maxcount_item')
  final int maxCountItem;

  @FoxyBriefField()
  @FoxyFullField('Type')
  final int type;

  const GemPropertyEntity({
    this.id = 0,
    this.enchantId = 0,
    this.maxCountInv = 0,
    this.maxCountItem = 0,
    this.type = 0,
  });

  factory GemPropertyEntity.fromJson(Map<String, dynamic> json) =>
      _GemPropertyEntityMixin.fromJson(json);
}
