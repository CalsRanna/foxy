// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_addon_entity.dart';

mixin _GameObjectTemplateAddonEntityMixin {
  static GameObjectTemplateAddonEntity fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateAddonEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      faction: (json['faction'] as num?)?.toInt() ?? 0,
      flags: (json['flags'] as num?)?.toInt() ?? 0,
      minGold: (json['mingold'] as num?)?.toInt() ?? 0,
      maxGold: (json['maxgold'] as num?)?.toInt() ?? 0,
      artkit0: (json['artkit0'] as num?)?.toInt() ?? 0,
      artkit1: (json['artkit1'] as num?)?.toInt() ?? 0,
      artkit2: (json['artkit2'] as num?)?.toInt() ?? 0,
      artkit3: (json['artkit3'] as num?)?.toInt() ?? 0,
    );
  }

  GameObjectTemplateAddonEntity copyWith({
    int? entry,
    int? faction,
    int? flags,
    int? minGold,
    int? maxGold,
    int? artkit0,
    int? artkit1,
    int? artkit2,
    int? artkit3,
  }) {
    final self = this as GameObjectTemplateAddonEntity;
    return GameObjectTemplateAddonEntity(
      entry: entry ?? self.entry,
      faction: faction ?? self.faction,
      flags: flags ?? self.flags,
      minGold: minGold ?? self.minGold,
      maxGold: maxGold ?? self.maxGold,
      artkit0: artkit0 ?? self.artkit0,
      artkit1: artkit1 ?? self.artkit1,
      artkit2: artkit2 ?? self.artkit2,
      artkit3: artkit3 ?? self.artkit3,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GameObjectTemplateAddonEntity;
    return {
      'entry': self.entry,
      'faction': self.faction,
      'flags': self.flags,
      'mingold': self.minGold,
      'maxgold': self.maxGold,
      'artkit0': self.artkit0,
      'artkit1': self.artkit1,
      'artkit2': self.artkit2,
      'artkit3': self.artkit3,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as GameObjectTemplateAddonEntity;
    return identical(self, other) ||
        other is GameObjectTemplateAddonEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.faction == other.faction &&
            self.flags == other.flags &&
            self.minGold == other.minGold &&
            self.maxGold == other.maxGold &&
            self.artkit0 == other.artkit0 &&
            self.artkit1 == other.artkit1 &&
            self.artkit2 == other.artkit2 &&
            self.artkit3 == other.artkit3;
  }

  @override
  int get hashCode {
    final self = this as GameObjectTemplateAddonEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.faction,
      self.flags,
      self.minGold,
      self.maxGold,
      self.artkit0,
      self.artkit1,
      self.artkit2,
      self.artkit3,
    ]);
  }

  @override
  String toString() {
    final self = this as GameObjectTemplateAddonEntity;
    return 'GameObjectTemplateAddonEntity('
        'entry: ${self.entry}, '
        'faction: ${self.faction}, '
        'flags: ${self.flags}, '
        'minGold: ${self.minGold}, '
        'maxGold: ${self.maxGold}, '
        'artkit0: ${self.artkit0}, '
        'artkit1: ${self.artkit1}, '
        'artkit2: ${self.artkit2}, '
        'artkit3: ${self.artkit3}'
        ')';
  }
}

final class BriefGameObjectTemplateAddonEntity {
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
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      faction: (json['faction'] as num?)?.toInt() ?? 0,
      flags: (json['flags'] as num?)?.toInt() ?? 0,
      minGold: (json['mingold'] as num?)?.toInt() ?? 0,
      maxGold: (json['maxgold'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => entry;
}
