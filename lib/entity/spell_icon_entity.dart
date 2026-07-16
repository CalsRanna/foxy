/// 法术图标列表/Picker 展示模型
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

  BriefSpellIconEntity copyWith({int? id, String? textureFilename}) {
    return BriefSpellIconEntity(
      id: id ?? this.id,
      textureFilename: textureFilename ?? this.textureFilename,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'TextureFilename': textureFilename};
  }
}

class SpellIconEntity {
  final int id;
  final String textureFilename;

  const SpellIconEntity({this.id = 0, this.textureFilename = ''});

  factory SpellIconEntity.fromJson(Map<String, dynamic> json) {
    return SpellIconEntity(
      id: json['ID'] ?? 0,
      textureFilename: json['TextureFilename'] ?? '',
    );
  }

  SpellIconEntity copyWith({int? id, String? textureFilename}) {
    return SpellIconEntity(
      id: id ?? this.id,
      textureFilename: textureFilename ?? this.textureFilename,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'TextureFilename': textureFilename};
  }
}
