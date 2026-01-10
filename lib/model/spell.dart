/// 技能
class Spell {
  int id = 0;
  String name = '';
  String subtext = '';

  Spell();

  Spell.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    name = json['Name_Lang_zhCN'] ?? json['name'] ?? '';
    subtext = json['NameSubtext_Lang_zhCN'] ?? json['subtext'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_Lang_zhCN': name,
      'NameSubtext_Lang_zhCN': subtext,
    };
  }
}
