// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_text_entity.dart';

mixin _BroadcastTextEntityMixin {
  int get id;
  int get languageId;
  String get maleText;
  String get femaleText;

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
    return BroadcastTextEntity(
      id: id ?? this.id,
      languageId: languageId ?? this.languageId,
      maleText: maleText ?? this.maleText,
      femaleText: femaleText ?? this.femaleText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'LanguageID': languageId,
      'MaleText': maleText,
      'FemaleText': femaleText,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BroadcastTextEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            languageId == other.languageId &&
            maleText == other.maleText &&
            femaleText == other.femaleText;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, languageId, maleText, femaleText]);
  }

  @override
  String toString() {
    return 'BroadcastTextEntity('
        'id: $id, '
        'languageId: $languageId, '
        'maleText: $maleText, '
        'femaleText: $femaleText'
        ')';
  }
}
