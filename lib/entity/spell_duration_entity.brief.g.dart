// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefSpellDurationEntity {
  final int id;
  final int duration;
  final int durationPerLevel;
  final int maxDuration;

  const BriefSpellDurationEntity({
    this.id = 0,
    this.duration = 0,
    this.durationPerLevel = 0,
    this.maxDuration = 0,
  });

  factory BriefSpellDurationEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellDurationEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      duration: (json['Duration'] as num?)?.toInt() ?? 0,
      durationPerLevel: (json['DurationPerLevel'] as num?)?.toInt() ?? 0,
      maxDuration: (json['MaxDuration'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
