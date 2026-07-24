// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_entity.dart';

mixin _PageTextEntityMixin {
  int get id;
  String get text;
  int get nextPageId;
  int get verifiedBuild;

  static PageTextEntity fromJson(Map<String, dynamic> json) {
    return PageTextEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      text: json['Text']?.toString() ?? '',
      nextPageId: (json['NextPageID'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  PageTextEntity copyWith({
    int? id,
    String? text,
    int? nextPageId,
    int? verifiedBuild,
  }) {
    return PageTextEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      nextPageId: nextPageId ?? this.nextPageId,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Text': text,
      'NextPageID': nextPageId,
      'VerifiedBuild': verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PageTextEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            text == other.text &&
            nextPageId == other.nextPageId &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, text, nextPageId, verifiedBuild]);
  }

  @override
  String toString() {
    return 'PageTextEntity('
        'id: $id, '
        'text: $text, '
        'nextPageId: $nextPageId, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
