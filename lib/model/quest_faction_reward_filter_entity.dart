class QuestFactionRewardFilterEntity {
  final String id;

  const QuestFactionRewardFilterEntity({this.id = ''});

  factory QuestFactionRewardFilterEntity.fromJson(Map<String, dynamic> json) {
    return QuestFactionRewardFilterEntity(id: json['id'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
