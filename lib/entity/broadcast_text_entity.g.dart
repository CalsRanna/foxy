// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_text_entity.dart';

mixin _BroadcastTextEntityMixin {
  static BroadcastTextEntity fromJson(Map<String, dynamic> json) {
    return BroadcastTextEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      languageId: (json['LanguageID'] as num?)?.toInt() ?? 0,
      maleText: json['MaleText']?.toString() ?? '',
      femaleText: json['FemaleText']?.toString() ?? '',
    );
  }

  BroadcastTextEntity copyWith({
    int? id,
    int? languageId,
    String? maleText,
    String? femaleText,
  }) {
    final self = this as BroadcastTextEntity;
    return BroadcastTextEntity(
      id: id ?? self.id,
      languageId: languageId ?? self.languageId,
      maleText: maleText ?? self.maleText,
      femaleText: femaleText ?? self.femaleText,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as BroadcastTextEntity;
    return {
      'ID': self.id,
      'LanguageID': self.languageId,
      'MaleText': self.maleText,
      'FemaleText': self.femaleText,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as BroadcastTextEntity;
    return identical(self, other) ||
        other is BroadcastTextEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.languageId == other.languageId &&
            self.maleText == other.maleText &&
            self.femaleText == other.femaleText;
  }

  @override
  int get hashCode {
    final self = this as BroadcastTextEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.languageId,
      self.maleText,
      self.femaleText,
    ]);
  }

  @override
  String toString() {
    final self = this as BroadcastTextEntity;
    return 'BroadcastTextEntity('
        'id: ${self.id}, '
        'languageId: ${self.languageId}, '
        'maleText: ${self.maleText}, '
        'femaleText: ${self.femaleText}'
        ')';
  }
}

final class BriefBroadcastTextEntity {
  final int id;
  final int languageId;
  final String maleText;

  const BriefBroadcastTextEntity({
    this.id = 0,
    this.languageId = 0,
    this.maleText = '',
  });

  factory BriefBroadcastTextEntity.fromJson(Map<String, dynamic> json) {
    return BriefBroadcastTextEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      languageId: (json['LanguageID'] as num?)?.toInt() ?? 0,
      maleText: json['MaleText']?.toString() ?? '',
    );
  }

  int get key => id;
}
