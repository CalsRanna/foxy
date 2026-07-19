import 'package:foxy/entity/quest_template_entity.dart';

class QuestTemplateKey {
  final int id;

  const QuestTemplateKey({required this.id});

  factory QuestTemplateKey.fromEntity(QuestTemplateEntity entity) {
    return QuestTemplateKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is QuestTemplateKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
