// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefGameObjectArtKitEntity {
  final int id;
  final String textureVariation0;
  final String attachModel0;

  const BriefGameObjectArtKitEntity({
    this.id = 0,
    this.textureVariation0 = '',
    this.attachModel0 = '',
  });

  factory BriefGameObjectArtKitEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectArtKitEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      textureVariation0: json['TextureVariation0']?.toString() ?? '',
      attachModel0: json['AttachModel0']?.toString() ?? '',
    );
  }

  int get key => id;
}
