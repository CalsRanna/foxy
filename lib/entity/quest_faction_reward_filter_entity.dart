class QuestFactionRewardFilterEntity {
  final String id;

  const QuestFactionRewardFilterEntity({this.id = ''});

  factory QuestFactionRewardFilterEntity.fromJson(Map<String, dynamic> json) {
    return QuestFactionRewardFilterEntity(id: json['id'] ?? '');
  }

  QuestFactionRewardFilterEntity copyWith({String? id}) {
    return QuestFactionRewardFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
