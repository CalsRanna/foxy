import 'package:foxy/entity/game_object_template_addon_key.dart';

class BriefGameObjectTemplateAddonEntity {
  final int entry;
  final int faction;
  final int flags;
  final int minGold;
  final int maxGold;

  const BriefGameObjectTemplateAddonEntity({
    this.entry = 0,
    this.faction = 0,
    this.flags = 0,
    this.minGold = 0,
    this.maxGold = 0,
  });

  factory BriefGameObjectTemplateAddonEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefGameObjectTemplateAddonEntity(
      entry: json['entry'] ?? 0,
      faction: json['faction'] ?? 0,
      flags: json['flags'] ?? 0,
      minGold: json['mingold'] ?? json['Mingold'] ?? 0,
      maxGold: json['maxgold'] ?? json['Maxgold'] ?? 0,
    );
  }

  GameObjectTemplateAddonKey get key =>
      GameObjectTemplateAddonKey(entry: entry);
}
