class SpellIcon {
  int id = 0;
  String textureFilename = '';

  SpellIcon();

  factory SpellIcon.fromJson(Map<String, dynamic> json) {
    return SpellIcon()
      ..id = json['ID'] ?? 0
      ..textureFilename = json['TextureFilename'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'TextureFilename': textureFilename,
    };
  }
}
