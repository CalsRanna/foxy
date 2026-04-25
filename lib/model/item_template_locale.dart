// item_template_locale 表模型（1:N locale，复合主键 ID + Locale）

class ItemTemplateLocale {
  int id = 0;
  String locale = 'zhCN';
  String name = '';
  String description = '';
  int verifiedBuild = 0;

  ItemTemplateLocale();

  ItemTemplateLocale.fromJson(Map<String, dynamic> json) {
    id = (json['ID'] ?? json['id'] ?? 0) as int;
    locale = json['Locale']?.toString() ?? 'zhCN';
    name = json['Name']?.toString() ?? '';
    description = json['Description']?.toString() ?? '';
    verifiedBuild = json['VerifiedBuild'] ?? 0;
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