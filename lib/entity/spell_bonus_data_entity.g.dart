// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_bonus_data_entity.dart';

mixin _SpellBonusDataEntityMixin {
  int get entry;
  double get directBonus;
  double get dotBonus;
  double get apBonus;
  double get apDotBonus;
  String get comments;

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
    return SpellBonusDataEntity(
      entry: entry ?? this.entry,
      directBonus: directBonus ?? this.directBonus,
      dotBonus: dotBonus ?? this.dotBonus,
      apBonus: apBonus ?? this.apBonus,
      apDotBonus: apDotBonus ?? this.apDotBonus,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'direct_bonus': directBonus,
      'dot_bonus': dotBonus,
      'ap_bonus': apBonus,
      'ap_dot_bonus': apDotBonus,
      'comments': comments,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellBonusDataEntity &&
            runtimeType == other.runtimeType &&
            entry == other.entry &&
            directBonus == other.directBonus &&
            dotBonus == other.dotBonus &&
            apBonus == other.apBonus &&
            apDotBonus == other.apDotBonus &&
            comments == other.comments;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      entry,
      directBonus,
      dotBonus,
      apBonus,
      apDotBonus,
      comments,
    ]);
  }

  @override
  String toString() {
    return 'SpellBonusDataEntity('
        'entry: $entry, '
        'directBonus: $directBonus, '
        'dotBonus: $dotBonus, '
        'apBonus: $apBonus, '
        'apDotBonus: $apDotBonus, '
        'comments: $comments'
        ')';
  }
}
