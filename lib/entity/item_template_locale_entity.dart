/// 列表 / Picker 精简行：ID + locale + 展示名
class BriefItemTemplateLocaleEntity {
  final int id;
  final String locale;
  final String name;

  const BriefItemTemplateLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.name = '',
  });

  factory BriefItemTemplateLocaleEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemTemplateLocaleEntity(
      id: (json['ID'] ?? json['id'] ?? 0) as int,
      locale: json['locale']?.toString() ?? 'zhCN',
      name: json['Name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'locale': locale, 'Name': name};
  }
}

/// item_template_locale 表模型（1:N locale，复合主键 ID + Locale）
class ItemTemplateLocaleEntity {
  final int id;
  final String locale;
  final String name;
  final String description;
  final int verifiedBuild;

  const ItemTemplateLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.name = '',
    this.description = '',
    this.verifiedBuild = 0,
  });

  factory ItemTemplateLocaleEntity.fromJson(Map<String, dynamic> json) {
    return ItemTemplateLocaleEntity(
      id: (json['ID'] ?? json['id'] ?? 0) as int,
      locale: json['locale']?.toString() ?? 'zhCN',
      name: json['Name']?.toString() ?? '',
      description: json['Description']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  ItemTemplateLocaleEntity copyWith({
    int? id,
    String? locale,
    String? name,
    String? description,
    int? verifiedBuild,
  }) {
    return ItemTemplateLocaleEntity(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      name: name ?? this.name,
      description: description ?? this.description,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'locale': locale,
      'Name': name,
      'Description': description,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
