import 'package:foxy/entity/char_title_entity.dart';

class CharTitleKey {
  final int id;

  const CharTitleKey({required this.id});

  factory CharTitleKey.fromEntity(CharTitleEntity entity) =>
      CharTitleKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CharTitleKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
