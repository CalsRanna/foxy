// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class CreatureTemplateFilterEntity {
  final String entry;
  final String name;
  final String subName;

  const CreatureTemplateFilterEntity({
    this.entry = '',
    this.name = '',
    this.subName = '',
  });

  factory CreatureTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateFilterEntity(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      subName: json['subName']?.toString() ?? '',
    );
  }

  CreatureTemplateFilterEntity copyWith({
    String? entry,
    String? name,
    String? subName,
  }) {
    return CreatureTemplateFilterEntity(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      subName: subName ?? this.subName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name, 'subName': subName};
  }
}
