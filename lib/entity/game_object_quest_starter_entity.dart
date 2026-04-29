// gameobject_queststarter 模型
// 复合主键 (id, quest)

class GameObjectQuestStarterEntity {
  final int id;
  final int quest;

  const GameObjectQuestStarterEntity({this.id = 0, this.quest = 0});

  factory GameObjectQuestStarterEntity.fromJson(Map<String, dynamic> json) {
    return GameObjectQuestStarterEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

/// Brief 版本（LEFT JOIN gameobject_template 获取名称，无 locale 表）
class BriefGameObjectQuestStarter {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefGameObjectQuestStarter({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefGameObjectQuestStarter.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectQuestStarter(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['Name']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest, 'name': name, 'Name': localeName};
  }
}
