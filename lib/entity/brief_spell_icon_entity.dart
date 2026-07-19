/// 法术图标列表/Picker 展示模型。
class BriefSpellIconEntity {
  final int id;
  final String textureFilename;

  const BriefSpellIconEntity({this.id = 0, this.textureFilename = ''});

  factory BriefSpellIconEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellIconEntity(
      id: json['ID'] ?? 0,
      textureFilename: json['TextureFilename'] ?? '',
    );
  }

  int get key => id;
}
