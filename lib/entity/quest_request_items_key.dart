import 'package:foxy/entity/quest_request_items_entity.dart';

final class QuestRequestItemsKey {
  final int id;

  const QuestRequestItemsKey({required this.id});

  factory QuestRequestItemsKey.fromEntity(QuestRequestItemsEntity entity) {
    return QuestRequestItemsKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is QuestRequestItemsKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
