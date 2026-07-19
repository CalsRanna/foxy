import 'package:foxy/entity/spell_duration_key.dart';

/// 法术持续时间列表/Picker 展示模型。
class BriefSpellDurationEntity {
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
      id: json['ID'] ?? 0,
      duration: json['Duration'] ?? 0,
      durationPerLevel: json['DurationPerLevel'] ?? 0,
      maxDuration: json['MaxDuration'] ?? 0,
    );
  }

  SpellDurationKey get key => SpellDurationKey(id: id);
}
