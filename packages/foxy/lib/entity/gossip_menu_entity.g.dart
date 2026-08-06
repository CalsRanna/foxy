// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_entity.dart';

final class BriefGossipMenuEntity {
  final int menuId;
  final int textId;
  final String text00;
  final String text01;
  final String textLocale00;
  final String textLocale01;

  const BriefGossipMenuEntity({
    this.menuId = 0,
    this.textId = 0,
    this.text00 = '',
    this.text01 = '',
    this.textLocale00 = '',
    this.textLocale01 = '',
  });

  factory BriefGossipMenuEntity.fromJson(Map<String, dynamic> json) {
    return BriefGossipMenuEntity(
      menuId: json['MenuID'] == true
          ? 1
          : json['MenuID'] == false
          ? 0
          : (json['MenuID'] as num?)?.toInt() ?? 0,
      textId: json['TextID'] == true
          ? 1
          : json['TextID'] == false
          ? 0
          : (json['TextID'] as num?)?.toInt() ?? 0,
      text00: json['text00']?.toString() ?? '',
      text01: json['text01']?.toString() ?? '',
      textLocale00: json['textLocale00']?.toString() ?? '',
      textLocale01: json['textLocale01']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([
    menuId,
    textId,
    text00,
    text01,
    textLocale00,
    textLocale01,
  ]);

  GossipMenuKey get key {
    return GossipMenuKey(menuId: menuId, textId: textId);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefGossipMenuEntity &&
            menuId == other.menuId &&
            textId == other.textId &&
            text00 == other.text00 &&
            text01 == other.text01 &&
            textLocale00 == other.textLocale00 &&
            textLocale01 == other.textLocale01;
  }

  @override
  String toString() {
    return 'BriefGossipMenuEntity('
        'menuId: $menuId, '
        'textId: $textId, '
        'text00: $text00, '
        'text01: $text01, '
        'textLocale00: $textLocale00, '
        'textLocale01: $textLocale01'
        ')';
  }
}

final class GossipMenuKey {
  final int menuId;
  final int textId;

  const GossipMenuKey({required this.menuId, required this.textId});

  factory GossipMenuKey.fromEntity(GossipMenuEntity entity) {
    return GossipMenuKey(menuId: entity.menuId, textId: entity.textId);
  }

  @override
  int get hashCode => Object.hashAll([menuId, textId]);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GossipMenuKey &&
            menuId == other.menuId &&
            textId == other.textId;
  }

  @override
  String toString() {
    return 'GossipMenuKey('
        'menuId: $menuId, '
        'textId: $textId'
        ')';
  }
}

mixin _GossipMenuEntityMixin {
  @override
  int get hashCode {
    final self = this as GossipMenuEntity;
    return Object.hashAll([self.runtimeType, self.menuId, self.textId]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as GossipMenuEntity;
    return identical(self, other) ||
        other is GossipMenuEntity &&
            self.runtimeType == other.runtimeType &&
            self.menuId == other.menuId &&
            self.textId == other.textId;
  }

  GossipMenuEntity copyWith({int? menuId, int? textId}) {
    final self = this as GossipMenuEntity;
    return GossipMenuEntity(
      menuId: menuId ?? self.menuId,
      textId: textId ?? self.textId,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GossipMenuEntity;
    return {'MenuID': self.menuId, 'TextID': self.textId};
  }

  @override
  String toString() {
    final self = this as GossipMenuEntity;
    return 'GossipMenuEntity('
        'menuId: ${self.menuId}, '
        'textId: ${self.textId}'
        ')';
  }

  static GossipMenuEntity fromJson(Map<String, dynamic> json) {
    return GossipMenuEntity(
      menuId: json['MenuID'] == true
          ? 1
          : json['MenuID'] == false
          ? 0
          : (json['MenuID'] as num?)?.toInt() ?? 0,
      textId: json['TextID'] == true
          ? 1
          : json['TextID'] == false
          ? 0
          : (json['TextID'] as num?)?.toInt() ?? 0,
    );
  }
}
