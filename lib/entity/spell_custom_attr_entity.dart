// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_custom_attr_entity.g.dart';

/// 法术自定义属性

@FoxyBriefEntity()
@FoxyFullEntity(table: 'spell_custom_attr')
class SpellCustomAttrEntity with _SpellCustomAttrEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('spell_id', key: true)
  final int spellId;

  @FoxyBriefField()
  @FoxyFullField('attributes')
  final int attributes;

  const SpellCustomAttrEntity({this.spellId = 0, this.attributes = 0});

  factory SpellCustomAttrEntity.fromJson(Map<String, dynamic> json) =>
      _SpellCustomAttrEntityMixin.fromJson(json);
}
