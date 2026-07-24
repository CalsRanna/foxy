// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefSpellIconEntity {
  final int id;
  final String textureFilename;

  const BriefSpellIconEntity({this.id = 0, this.textureFilename = ''});

  factory BriefSpellIconEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellIconEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      textureFilename: json['TextureFilename']?.toString() ?? '',
    );
  }

  int get key => id;
}
