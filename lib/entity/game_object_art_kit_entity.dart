class GameObjectArtKitEntity {
  final int id;
  final String textureVariation0;
  final String textureVariation1;
  final String textureVariation2;
  final String attachModel0;
  final String attachModel1;
  final String attachModel2;
  final String attachModel3;

  const GameObjectArtKitEntity({
    this.id = 0,
    this.textureVariation0 = '',
    this.textureVariation1 = '',
    this.textureVariation2 = '',
    this.attachModel0 = '',
    this.attachModel1 = '',
    this.attachModel2 = '',
    this.attachModel3 = '',
  });

  factory GameObjectArtKitEntity.fromJson(Map<String, dynamic> json) {
    return GameObjectArtKitEntity(
      id: json['ID'] ?? 0,
      textureVariation0: json['TextureVariation0'] ?? '',
      textureVariation1: json['TextureVariation1'] ?? '',
      textureVariation2: json['TextureVariation2'] ?? '',
      attachModel0: json['AttachModel0'] ?? '',
      attachModel1: json['AttachModel1'] ?? '',
      attachModel2: json['AttachModel2'] ?? '',
      attachModel3: json['AttachModel3'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'TextureVariation0': textureVariation0,
    'TextureVariation1': textureVariation1,
    'TextureVariation2': textureVariation2,
    'AttachModel0': attachModel0,
    'AttachModel1': attachModel1,
    'AttachModel2': attachModel2,
    'AttachModel3': attachModel3,
  };
}
