import 'package:foxy/entity/emote_text_entity.dart';

class EmoteTextKey {
  final int id;

  const EmoteTextKey({required this.id});

  factory EmoteTextKey.fromEntity(EmoteTextEntity entity) =>
      EmoteTextKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is EmoteTextKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
