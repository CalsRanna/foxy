import 'package:flutter/foundation.dart';
import 'package:foxy/entity/page_text_entity.dart';

@immutable
final class PageTextKey {
  final int id;

  const PageTextKey({required this.id});

  factory PageTextKey.fromEntity(PageTextEntity value) {
    return PageTextKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is PageTextKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
