// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'smart_script_entity.dart';

final class SmartScriptKey {
  final int entryOrGuid;
  final int sourceType;
  final int id;
  final int link;

  const SmartScriptKey({
    required this.entryOrGuid,
    required this.sourceType,
    required this.id,
    required this.link,
  });

  factory SmartScriptKey.fromEntity(SmartScriptEntity entity) {
    return SmartScriptKey(
      entryOrGuid: entity.entryOrGuid,
      sourceType: entity.sourceType,
      id: entity.id,
      link: entity.link,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SmartScriptKey &&
            entryOrGuid == other.entryOrGuid &&
            sourceType == other.sourceType &&
            id == other.id &&
            link == other.link;
  }

  @override
  int get hashCode => Object.hashAll([entryOrGuid, sourceType, id, link]);

  @override
  String toString() {
    return 'SmartScriptKey('
        'entryOrGuid: $entryOrGuid, '
        'sourceType: $sourceType, '
        'id: $id, '
        'link: $link'
        ')';
  }
}
