class SpellIcon {
  final int id;
  final String textureFilename;

  const SpellIcon({this.id = 0, this.textureFilename = ''});

  factory SpellIcon.fromJson(Map<String, dynamic> json) {
    return SpellIcon(
      id: json['ID'] ?? 0,
      textureFilename: json['TextureFilename'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'TextureFilename': textureFilename,
    };
  }
}
