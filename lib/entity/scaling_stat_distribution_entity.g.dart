// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_distribution_entity.dart';

mixin _ScalingStatDistributionEntityMixin {
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
    final self = this as ScalingStatDistributionEntity;
    return ScalingStatDistributionEntity(
      id: id ?? self.id,
      statId0: statId0 ?? self.statId0,
      statId1: statId1 ?? self.statId1,
      statId2: statId2 ?? self.statId2,
      statId3: statId3 ?? self.statId3,
      statId4: statId4 ?? self.statId4,
      statId5: statId5 ?? self.statId5,
      statId6: statId6 ?? self.statId6,
      statId7: statId7 ?? self.statId7,
      statId8: statId8 ?? self.statId8,
      statId9: statId9 ?? self.statId9,
      bonus0: bonus0 ?? self.bonus0,
      bonus1: bonus1 ?? self.bonus1,
      bonus2: bonus2 ?? self.bonus2,
      bonus3: bonus3 ?? self.bonus3,
      bonus4: bonus4 ?? self.bonus4,
      bonus5: bonus5 ?? self.bonus5,
      bonus6: bonus6 ?? self.bonus6,
      bonus7: bonus7 ?? self.bonus7,
      bonus8: bonus8 ?? self.bonus8,
      bonus9: bonus9 ?? self.bonus9,
      maxlevel: maxlevel ?? self.maxlevel,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ScalingStatDistributionEntity;
    return {
      'ID': self.id,
      'StatID0': self.statId0,
      'StatID1': self.statId1,
      'StatID2': self.statId2,
      'StatID3': self.statId3,
      'StatID4': self.statId4,
      'StatID5': self.statId5,
      'StatID6': self.statId6,
      'StatID7': self.statId7,
      'StatID8': self.statId8,
      'StatID9': self.statId9,
      'Bonus0': self.bonus0,
      'Bonus1': self.bonus1,
      'Bonus2': self.bonus2,
      'Bonus3': self.bonus3,
      'Bonus4': self.bonus4,
      'Bonus5': self.bonus5,
      'Bonus6': self.bonus6,
      'Bonus7': self.bonus7,
      'Bonus8': self.bonus8,
      'Bonus9': self.bonus9,
      'Maxlevel': self.maxlevel,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as ScalingStatDistributionEntity;
    return identical(self, other) ||
        other is ScalingStatDistributionEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.statId0 == other.statId0 &&
            self.statId1 == other.statId1 &&
            self.statId2 == other.statId2 &&
            self.statId3 == other.statId3 &&
            self.statId4 == other.statId4 &&
            self.statId5 == other.statId5 &&
            self.statId6 == other.statId6 &&
            self.statId7 == other.statId7 &&
            self.statId8 == other.statId8 &&
            self.statId9 == other.statId9 &&
            self.bonus0 == other.bonus0 &&
            self.bonus1 == other.bonus1 &&
            self.bonus2 == other.bonus2 &&
            self.bonus3 == other.bonus3 &&
            self.bonus4 == other.bonus4 &&
            self.bonus5 == other.bonus5 &&
            self.bonus6 == other.bonus6 &&
            self.bonus7 == other.bonus7 &&
            self.bonus8 == other.bonus8 &&
            self.bonus9 == other.bonus9 &&
            self.maxlevel == other.maxlevel;
  }

  @override
  int get hashCode {
    final self = this as ScalingStatDistributionEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.statId0,
      self.statId1,
      self.statId2,
      self.statId3,
      self.statId4,
      self.statId5,
      self.statId6,
      self.statId7,
      self.statId8,
      self.statId9,
      self.bonus0,
      self.bonus1,
      self.bonus2,
      self.bonus3,
      self.bonus4,
      self.bonus5,
      self.bonus6,
      self.bonus7,
      self.bonus8,
      self.bonus9,
      self.maxlevel,
    ]);
  }

  @override
  String toString() {
    final self = this as ScalingStatDistributionEntity;
    return 'ScalingStatDistributionEntity('
        'id: ${self.id}, '
        'statId0: ${self.statId0}, '
        'statId1: ${self.statId1}, '
        'statId2: ${self.statId2}, '
        'statId3: ${self.statId3}, '
        'statId4: ${self.statId4}, '
        'statId5: ${self.statId5}, '
        'statId6: ${self.statId6}, '
        'statId7: ${self.statId7}, '
        'statId8: ${self.statId8}, '
        'statId9: ${self.statId9}, '
        'bonus0: ${self.bonus0}, '
        'bonus1: ${self.bonus1}, '
        'bonus2: ${self.bonus2}, '
        'bonus3: ${self.bonus3}, '
        'bonus4: ${self.bonus4}, '
        'bonus5: ${self.bonus5}, '
        'bonus6: ${self.bonus6}, '
        'bonus7: ${self.bonus7}, '
        'bonus8: ${self.bonus8}, '
        'bonus9: ${self.bonus9}, '
        'maxlevel: ${self.maxlevel}'
        ')';
  }
}
