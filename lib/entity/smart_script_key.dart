import 'package:flutter/foundation.dart';
import 'package:foxy/entity/smart_script_entity.dart';

@immutable
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

  factory SmartScriptKey.fromEntity(SmartScriptEntity value) {
    return SmartScriptKey(
      entryOrGuid: value.entryOrGuid,
      sourceType: value.sourceType,
      id: value.id,
      link: value.link,
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
  int get hashCode => Object.hash(entryOrGuid, sourceType, id, link);
}
