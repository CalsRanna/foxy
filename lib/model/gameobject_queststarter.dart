/// gameobject_queststarter 模型
/// 复合主键 (id, quest)

class GameobjectQueststarter {
  int id = 0;
  int quest = 0;

  GameobjectQueststarter();

  GameobjectQueststarter.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    quest = json['quest'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

/// Brief 版本（LEFT JOIN gameobject_template 获取名称，无 locale 表）
class BriefGameobjectQueststarter {
  int id = 0;
  int quest = 0;
  String name = '';
  String localeName = '';

  BriefGameobjectQueststarter();

  BriefGameobjectQueststarter.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    quest = json['quest'] ?? 0;
    name = json['name']?.toString() ?? '';
    localeName = json['Name']?.toString() ?? '';
  }

  String get displayName =>
      localeName.isNotEmpty ? localeName : name;
}