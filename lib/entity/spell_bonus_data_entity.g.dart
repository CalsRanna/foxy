// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_bonus_data_entity.dart';

mixin _SpellBonusDataEntityMixin {
  static SpellBonusDataEntity fromJson(Map<String, dynamic> json) {
    return SpellBonusDataEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      directBonus: (json['direct_bonus'] as num?)?.toDouble() ?? 0.0,
      dotBonus: (json['dot_bonus'] as num?)?.toDouble() ?? 0.0,
      apBonus: (json['ap_bonus'] as num?)?.toDouble() ?? 0.0,
      apDotBonus: (json['ap_dot_bonus'] as num?)?.toDouble() ?? 0.0,
      comments: json['comments']?.toString() ?? '',
    );
  }

  SpellBonusDataEntity copyWith({
    int? entry,
    double? directBonus,
    double? dotBonus,
    double? apBonus,
    double? apDotBonus,
    String? comments,
  }) {
    final self = this as SpellBonusDataEntity;
    return SpellBonusDataEntity(
      entry: entry ?? self.entry,
      directBonus: directBonus ?? self.directBonus,
      dotBonus: dotBonus ?? self.dotBonus,
      apBonus: apBonus ?? self.apBonus,
      apDotBonus: apDotBonus ?? self.apDotBonus,
      comments: comments ?? self.comments,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellBonusDataEntity;
    return {
      'entry': self.entry,
      'direct_bonus': self.directBonus,
      'dot_bonus': self.dotBonus,
      'ap_bonus': self.apBonus,
      'ap_dot_bonus': self.apDotBonus,
      'comments': self.comments,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellBonusDataEntity;
    return identical(self, other) ||
        other is SpellBonusDataEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.directBonus == other.directBonus &&
            self.dotBonus == other.dotBonus &&
            self.apBonus == other.apBonus &&
            self.apDotBonus == other.apDotBonus &&
            self.comments == other.comments;
  }

  @override
  int get hashCode {
    final self = this as SpellBonusDataEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.directBonus,
      self.dotBonus,
      self.apBonus,
      self.apDotBonus,
      self.comments,
    ]);
  }

  @override
  String toString() {
    final self = this as SpellBonusDataEntity;
    return 'SpellBonusDataEntity('
        'entry: ${self.entry}, '
        'directBonus: ${self.directBonus}, '
        'dotBonus: ${self.dotBonus}, '
        'apBonus: ${self.apBonus}, '
        'apDotBonus: ${self.apDotBonus}, '
        'comments: ${self.comments}'
        ')';
  }
}
