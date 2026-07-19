import 'package:foxy/entity/skill_line_entity.dart';

class SkillLineKey {
  final int id;

  const SkillLineKey({required this.id});

  factory SkillLineKey.fromEntity(SkillLineEntity entity) =>
      SkillLineKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SkillLineKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
