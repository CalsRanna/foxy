import 'package:foxy/entity/quest_info_entity.dart';

class QuestInfoKey {
  final int id;

  const QuestInfoKey({required this.id});

  factory QuestInfoKey.fromEntity(QuestInfoEntity entity) =>
      QuestInfoKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is QuestInfoKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
