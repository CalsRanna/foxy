import 'package:foxy/entity/quest_template_addon_entity.dart';

final class QuestTemplateAddonKey {
  final int id;

  const QuestTemplateAddonKey({required this.id});

  factory QuestTemplateAddonKey.fromEntity(QuestTemplateAddonEntity entity) {
    return QuestTemplateAddonKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestTemplateAddonKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
