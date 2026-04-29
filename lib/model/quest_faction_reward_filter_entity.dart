class QuestFactionRewardFilterEntity {
  String id = '';

  QuestFactionRewardFilterEntity();

  factory QuestFactionRewardFilterEntity.fromJson(Map<String, dynamic> json) {
    return QuestFactionRewardFilterEntity()
      ..id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
