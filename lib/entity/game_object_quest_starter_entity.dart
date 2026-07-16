// gameobject_queststarter 模型
// 复合主键 (id, quest)

/// Brief 版本（LEFT JOIN gameobject_template 获取名称，无 locale 表）
class BriefGameObjectQuestStarterEntity {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefGameObjectQuestStarterEntity({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefGameObjectQuestStarterEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefGameObjectQuestStarterEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['Name']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  BriefGameObjectQuestStarterEntity copyWith({
    int? id,
    int? quest,
    String? name,
    String? localeName,
  }) {
    return BriefGameObjectQuestStarterEntity(
      id: id ?? this.id,
      quest: quest ?? this.quest,
      name: name ?? this.name,
      localeName: localeName ?? this.localeName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest, 'name': name, 'Name': localeName};
  }
}

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

  GameObjectQuestStarterEntity copyWith({int? id, int? quest}) {
    return GameObjectQuestStarterEntity(
      id: id ?? this.id,
      quest: quest ?? this.quest,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}
