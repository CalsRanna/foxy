class SpellIcon {
  int id = 0;
  String textureFilename = '';

  SpellIcon();

  SpellIcon.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    textureFilename = json['TextureFilename'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'TextureFilename': textureFilename,
    };
  }
}
