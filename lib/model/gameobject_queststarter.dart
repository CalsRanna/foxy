// gameobject_queststarter 模型
// 复合主键 (id, quest)

class GameobjectQueststarter {
  final int id;
  final int quest;

  const GameobjectQueststarter({
    this.id = 0,
    this.quest = 0,
  });

  factory GameobjectQueststarter.fromJson(Map<String, dynamic> json) {
    return GameobjectQueststarter(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

/// Brief 版本（LEFT JOIN gameobject_template 获取名称，无 locale 表）
class BriefGameobjectQueststarter {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefGameobjectQueststarter({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefGameobjectQueststarter.fromJson(Map<String, dynamic> json) {
    return BriefGameobjectQueststarter(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['Name']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quest': quest,
      'name': name,
      'Name': localeName,
    };
  }
}
