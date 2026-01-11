/// DBC 阵营
class DbcFaction {
  int id = 0;
  String name = '';
  String description = '';

  DbcFaction();

  DbcFaction.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    name = json['Name_Lang_zhCN'] ?? json['name'] ?? '';
    description = json['Description_Lang_zhCN'] ?? json['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_Lang_zhCN': name,
      'Description_Lang_zhCN': description,
    };
  }
}
