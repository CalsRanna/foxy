// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_distribution_entity.dart';

mixin _ScalingStatDistributionEntityMixin {
  int get id;
  int get statId0;
  int get statId1;
  int get statId2;
  int get statId3;
  int get statId4;
  int get statId5;
  int get statId6;
  int get statId7;
  int get statId8;
  int get statId9;
  int get bonus0;
  int get bonus1;
  int get bonus2;
  int get bonus3;
  int get bonus4;
  int get bonus5;
  int get bonus6;
  int get bonus7;
  int get bonus8;
  int get bonus9;
  int get maxlevel;

  static ScalingStatDistributionEntity fromJson(Map<String, dynamic> json) {
    return ScalingStatDistributionEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      statId0: (json['StatID0'] as num?)?.toInt() ?? -1,
      statId1: (json['StatID1'] as num?)?.toInt() ?? -1,
      statId2: (json['StatID2'] as num?)?.toInt() ?? -1,
      statId3: (json['StatID3'] as num?)?.toInt() ?? -1,
      statId4: (json['StatID4'] as num?)?.toInt() ?? -1,
      statId5: (json['StatID5'] as num?)?.toInt() ?? -1,
      statId6: (json['StatID6'] as num?)?.toInt() ?? -1,
      statId7: (json['StatID7'] as num?)?.toInt() ?? -1,
      statId8: (json['StatID8'] as num?)?.toInt() ?? -1,
      statId9: (json['StatID9'] as num?)?.toInt() ?? -1,
      bonus0: (json['Bonus0'] as num?)?.toInt() ?? 0,
      bonus1: (json['Bonus1'] as num?)?.toInt() ?? 0,
      bonus2: (json['Bonus2'] as num?)?.toInt() ?? 0,
      bonus3: (json['Bonus3'] as num?)?.toInt() ?? 0,
      bonus4: (json['Bonus4'] as num?)?.toInt() ?? 0,
      bonus5: (json['Bonus5'] as num?)?.toInt() ?? 0,
      bonus6: (json['Bonus6'] as num?)?.toInt() ?? 0,
      bonus7: (json['Bonus7'] as num?)?.toInt() ?? 0,
      bonus8: (json['Bonus8'] as num?)?.toInt() ?? 0,
      bonus9: (json['Bonus9'] as num?)?.toInt() ?? 0,
      maxlevel: (json['Maxlevel'] as num?)?.toInt() ?? 80,
    );
  }

  ScalingStatDistributionEntity copyWith({
    int? id,
    int? statId0,
    int? statId1,
    int? statId2,
    int? statId3,
    int? statId4,
    int? statId5,
    int? statId6,
    int? statId7,
    int? statId8,
    int? statId9,
    int? bonus0,
    int? bonus1,
    int? bonus2,
    int? bonus3,
    int? bonus4,
    int? bonus5,
    int? bonus6,
    int? bonus7,
    int? bonus8,
    int? bonus9,
    int? maxlevel,
  }) {
    return ScalingStatDistributionEntity(
      id: id ?? this.id,
      statId0: statId0 ?? this.statId0,
      statId1: statId1 ?? this.statId1,
      statId2: statId2 ?? this.statId2,
      statId3: statId3 ?? this.statId3,
      statId4: statId4 ?? this.statId4,
      statId5: statId5 ?? this.statId5,
      statId6: statId6 ?? this.statId6,
      statId7: statId7 ?? this.statId7,
      statId8: statId8 ?? this.statId8,
      statId9: statId9 ?? this.statId9,
      bonus0: bonus0 ?? this.bonus0,
      bonus1: bonus1 ?? this.bonus1,
      bonus2: bonus2 ?? this.bonus2,
      bonus3: bonus3 ?? this.bonus3,
      bonus4: bonus4 ?? this.bonus4,
      bonus5: bonus5 ?? this.bonus5,
      bonus6: bonus6 ?? this.bonus6,
      bonus7: bonus7 ?? this.bonus7,
      bonus8: bonus8 ?? this.bonus8,
      bonus9: bonus9 ?? this.bonus9,
      maxlevel: maxlevel ?? this.maxlevel,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'StatID0': statId0,
      'StatID1': statId1,
      'StatID2': statId2,
      'StatID3': statId3,
      'StatID4': statId4,
      'StatID5': statId5,
      'StatID6': statId6,
      'StatID7': statId7,
      'StatID8': statId8,
      'StatID9': statId9,
      'Bonus0': bonus0,
      'Bonus1': bonus1,
      'Bonus2': bonus2,
      'Bonus3': bonus3,
      'Bonus4': bonus4,
      'Bonus5': bonus5,
      'Bonus6': bonus6,
      'Bonus7': bonus7,
      'Bonus8': bonus8,
      'Bonus9': bonus9,
      'Maxlevel': maxlevel,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ScalingStatDistributionEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            statId0 == other.statId0 &&
            statId1 == other.statId1 &&
            statId2 == other.statId2 &&
            statId3 == other.statId3 &&
            statId4 == other.statId4 &&
            statId5 == other.statId5 &&
            statId6 == other.statId6 &&
            statId7 == other.statId7 &&
            statId8 == other.statId8 &&
            statId9 == other.statId9 &&
            bonus0 == other.bonus0 &&
            bonus1 == other.bonus1 &&
            bonus2 == other.bonus2 &&
            bonus3 == other.bonus3 &&
            bonus4 == other.bonus4 &&
            bonus5 == other.bonus5 &&
            bonus6 == other.bonus6 &&
            bonus7 == other.bonus7 &&
            bonus8 == other.bonus8 &&
            bonus9 == other.bonus9 &&
            maxlevel == other.maxlevel;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      statId0,
      statId1,
      statId2,
      statId3,
      statId4,
      statId5,
      statId6,
      statId7,
      statId8,
      statId9,
      bonus0,
      bonus1,
      bonus2,
      bonus3,
      bonus4,
      bonus5,
      bonus6,
      bonus7,
      bonus8,
      bonus9,
      maxlevel,
    ]);
  }

  @override
  String toString() {
    return 'ScalingStatDistributionEntity('
        'id: $id, '
        'statId0: $statId0, '
        'statId1: $statId1, '
        'statId2: $statId2, '
        'statId3: $statId3, '
        'statId4: $statId4, '
        'statId5: $statId5, '
        'statId6: $statId6, '
        'statId7: $statId7, '
        'statId8: $statId8, '
        'statId9: $statId9, '
        'bonus0: $bonus0, '
        'bonus1: $bonus1, '
        'bonus2: $bonus2, '
        'bonus3: $bonus3, '
        'bonus4: $bonus4, '
        'bonus5: $bonus5, '
        'bonus6: $bonus6, '
        'bonus7: $bonus7, '
        'bonus8: $bonus8, '
        'bonus9: $bonus9, '
        'maxlevel: $maxlevel'
        ')';
  }
}
