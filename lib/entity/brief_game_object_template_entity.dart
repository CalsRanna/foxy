import 'package:foxy/entity/game_object_template_key.dart';

class BriefGameObjectTemplateEntity {
  final int entry;
  final String name;
  final String localeName;
  final int type;
  final double size;

  const BriefGameObjectTemplateEntity({
    this.entry = 0,
    this.name = '',
    this.localeName = '',
    this.type = 0,
    this.size = 0,
  });

  factory BriefGameObjectTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectTemplateEntity(
      entry: json['entry'] ?? 0,
      name: json['name'] ?? '',
      localeName: json['Name'] ?? '',
      type: json['type'] ?? 0,
      size: (json['size'] as num?)?.toDouble() ?? 0,
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  GameObjectTemplateKey get key => GameObjectTemplateKey(entry: entry);
}
