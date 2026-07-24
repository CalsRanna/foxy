// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefItemVisualEffectEntity {
  final int id;
  final String model;

  const BriefItemVisualEffectEntity({this.id = 0, this.model = ''});

  factory BriefItemVisualEffectEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemVisualEffectEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      model: json['Model']?.toString() ?? '',
    );
  }

  int get key => id;
}
