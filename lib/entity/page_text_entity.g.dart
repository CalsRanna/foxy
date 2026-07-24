// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_entity.dart';

mixin _PageTextEntityMixin {
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
    final self = this as PageTextEntity;
    return PageTextEntity(
      id: id ?? self.id,
      text: text ?? self.text,
      nextPageId: nextPageId ?? self.nextPageId,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as PageTextEntity;
    return {
      'ID': self.id,
      'Text': self.text,
      'NextPageID': self.nextPageId,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as PageTextEntity;
    return identical(self, other) ||
        other is PageTextEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.text == other.text &&
            self.nextPageId == other.nextPageId &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as PageTextEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.text,
      self.nextPageId,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as PageTextEntity;
    return 'PageTextEntity('
        'id: ${self.id}, '
        'text: ${self.text}, '
        'nextPageId: ${self.nextPageId}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class BriefPageTextEntity {
  final int id;
  final String text;
  final int nextPageId;
  final String localeText;

  const BriefPageTextEntity({
    this.id = 0,
    this.text = '',
    this.nextPageId = 0,
    this.localeText = '',
  });

  factory BriefPageTextEntity.fromJson(Map<String, dynamic> json) {
    return BriefPageTextEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      text: json['Text']?.toString() ?? '',
      nextPageId: (json['NextPageID'] as num?)?.toInt() ?? 0,
      localeText: json['localeText']?.toString() ?? '',
    );
  }

  int get key => id;
}
