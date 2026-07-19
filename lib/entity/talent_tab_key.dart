import 'package:foxy/entity/talent_tab_entity.dart';

class TalentTabKey {
  final int id;

  const TalentTabKey({required this.id});

  factory TalentTabKey.fromEntity(TalentTabEntity entity) =>
      TalentTabKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TalentTabKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
