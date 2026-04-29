enum ActivityActionType {
  create('新建'),
  update('更新'),
  delete('删除'),
  copy('复制');

  final String label;
  const ActivityActionType(this.label);

  static ActivityActionType fromString(String value) {
    return ActivityActionType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ActivityActionType.update,
    );
  }
}

class ActivityLog {
  final int id;
  final String module;
  final ActivityActionType actionType;
  final int entityId;
  final String entityName;
  final DateTime createdAt;

  const ActivityLog({
    this.id = 0,
    required this.module,
    required this.actionType,
    required this.entityId,
    this.entityName = '',
    required this.createdAt,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      id: json['id'] as int,
      module: json['module'] as String,
      actionType: ActivityActionType.fromString(json['action_type'] as String),
      entityId: json['entity_id'] as int,
      entityName: (json['entity_name'] as String?) ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'module': module,
      'action_type': actionType.name,
      'entity_id': entityId,
      'entity_name': entityName,
    };
  }
}
