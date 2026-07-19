import 'package:foxy/entity/quest_sort_entity.dart';

class QuestSortKey {
  final int id;

  const QuestSortKey({required this.id});

  factory QuestSortKey.fromEntity(QuestSortEntity entity) {
    return QuestSortKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestSortKey &&
            runtimeType == other.runtimeType &&
            id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
