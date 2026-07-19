import 'package:foxy/entity/emote_text_data_entity.dart';

class EmoteTextDataKey {
  final int id;

  const EmoteTextDataKey({required this.id});

  factory EmoteTextDataKey.fromEntity(EmoteTextDataEntity entity) =>
      EmoteTextDataKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is EmoteTextDataKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
