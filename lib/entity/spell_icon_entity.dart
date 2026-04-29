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

  Map<String, dynamic> toJson() {
    return {'ID': id, 'TextureFilename': textureFilename};
  }
}
