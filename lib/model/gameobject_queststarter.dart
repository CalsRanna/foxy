// gameobject_queststarter 模型
// 复合主键 (id, quest)

class GameobjectQueststarter {
  int id = 0;
  int quest = 0;

  GameobjectQueststarter();

  factory GameobjectQueststarter.fromJson(Map<String, dynamic> json) {
    return GameobjectQueststarter()
      ..id = json['id'] ?? 0
      ..quest = json['quest'] ?? 0;
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

  factory BriefGameobjectQueststarter.fromJson(Map<String, dynamic> json) {
    return BriefGameobjectQueststarter()
      ..id = json['id'] ?? 0
      ..quest = json['quest'] ?? 0
      ..name = json['name']?.toString() ?? ''
      ..localeName = json['Name']?.toString() ?? '';
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;
}
