import 'package:foxy/entity/talent_entity.dart';

class TalentKey {
  final int id;

  const TalentKey({required this.id});

  factory TalentKey.fromEntity(TalentEntity entity) {
    return TalentKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TalentKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
