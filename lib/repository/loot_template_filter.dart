final class LootTemplateFilter {
  final String entry;
  final String name;

  const LootTemplateFilter({this.entry = '', this.name = ''});

  factory LootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return LootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  LootTemplateFilter copyWith({String? entry, String? name}) {
    return LootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
