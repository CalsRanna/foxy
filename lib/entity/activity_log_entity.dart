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

class ActivityLogEntity {
  final int id;
  final String module;
  final ActivityActionType actionType;
  final String entityName;
  final DateTime createdAt;

  const ActivityLogEntity({
    this.id = 0,
    required this.module,
    required this.actionType,
    required this.entityName,
    required this.createdAt,
  });

  factory ActivityLogEntity.fromJson(Map<String, dynamic> json) {
    return ActivityLogEntity(
      id: json['id'] as int,
      module: json['module'] as String,
      actionType: ActivityActionType.fromString(json['action_type'] as String),
      entityName: (json['entity_name'] as String?) ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  ActivityLogEntity copyWith({
    int? id,
    String? module,
    ActivityActionType? actionType,
    String? entityName,
    DateTime? createdAt,
  }) {
    return ActivityLogEntity(
      id: id ?? this.id,
      module: module ?? this.module,
      actionType: actionType ?? this.actionType,
      entityName: entityName ?? this.entityName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'module': module,
      'action_type': actionType.name,
      'entity_name': entityName,
    };
  }
}
