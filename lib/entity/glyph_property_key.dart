import 'package:foxy/entity/glyph_property_entity.dart';

class GlyphPropertyKey {
  final int id;

  const GlyphPropertyKey({required this.id});

  factory GlyphPropertyKey.fromEntity(GlyphPropertyEntity entity) =>
      GlyphPropertyKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is GlyphPropertyKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
