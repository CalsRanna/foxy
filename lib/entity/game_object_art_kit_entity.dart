import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'game_object_art_kit_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_game_object_art_kit')
class GameObjectArtKitEntity with _GameObjectArtKitEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('TextureVariation0')
  final String textureVariation0;

  @FoxyFullField('TextureVariation1')
  final String textureVariation1;

  @FoxyFullField('TextureVariation2')
  final String textureVariation2;

  @FoxyBriefField()
  @FoxyFullField('AttachModel0')
  final String attachModel0;

  @FoxyFullField('AttachModel1')
  final String attachModel1;

  @FoxyFullField('AttachModel2')
  final String attachModel2;

  @FoxyFullField('AttachModel3')
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

  factory GameObjectArtKitEntity.fromJson(Map<String, dynamic> json) =>
      _GameObjectArtKitEntityMixin.fromJson(json);
}
