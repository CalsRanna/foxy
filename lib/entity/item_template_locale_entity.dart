// item_template_locale 表模型（1:N locale，复合主键 ID + Locale）

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
      locale: json['Locale']?.toString() ?? 'zhCN',
      name: json['Name']?.toString() ?? '',
      description: json['Description']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Locale': locale,
      'Name': name,
      'Description': description,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
