// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_text_entity.dart';

mixin _EmoteTextEntityMixin {
  int get id;
  String get name;
  int get emoteId;
  int get emoteText0;
  int get emoteText1;
  int get emoteText2;
  int get emoteText3;
  int get emoteText4;
  int get emoteText5;
  int get emoteText6;
  int get emoteText7;
  int get emoteText8;
  int get emoteText9;
  int get emoteText10;
  int get emoteText11;
  int get emoteText12;
  int get emoteText13;
  int get emoteText14;
  int get emoteText15;

  static EmoteTextEntity fromJson(Map<String, dynamic> json) {
    return EmoteTextEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      emoteId: (json['EmoteID'] as num?)?.toInt() ?? 0,
      emoteText0: (json['EmoteText0'] as num?)?.toInt() ?? 0,
      emoteText1: (json['EmoteText1'] as num?)?.toInt() ?? 0,
      emoteText2: (json['EmoteText2'] as num?)?.toInt() ?? 0,
      emoteText3: (json['EmoteText3'] as num?)?.toInt() ?? 0,
      emoteText4: (json['EmoteText4'] as num?)?.toInt() ?? 0,
      emoteText5: (json['EmoteText5'] as num?)?.toInt() ?? 0,
      emoteText6: (json['EmoteText6'] as num?)?.toInt() ?? 0,
      emoteText7: (json['EmoteText7'] as num?)?.toInt() ?? 0,
      emoteText8: (json['EmoteText8'] as num?)?.toInt() ?? 0,
      emoteText9: (json['EmoteText9'] as num?)?.toInt() ?? 0,
      emoteText10: (json['EmoteText10'] as num?)?.toInt() ?? 0,
      emoteText11: (json['EmoteText11'] as num?)?.toInt() ?? 0,
      emoteText12: (json['EmoteText12'] as num?)?.toInt() ?? 0,
      emoteText13: (json['EmoteText13'] as num?)?.toInt() ?? 0,
      emoteText14: (json['EmoteText14'] as num?)?.toInt() ?? 0,
      emoteText15: (json['EmoteText15'] as num?)?.toInt() ?? 0,
    );
  }

  EmoteTextEntity copyWith({
    int? id,
    String? name,
    int? emoteId,
    int? emoteText0,
    int? emoteText1,
    int? emoteText2,
    int? emoteText3,
    int? emoteText4,
    int? emoteText5,
    int? emoteText6,
    int? emoteText7,
    int? emoteText8,
    int? emoteText9,
    int? emoteText10,
    int? emoteText11,
    int? emoteText12,
    int? emoteText13,
    int? emoteText14,
    int? emoteText15,
  }) {
    return EmoteTextEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      emoteId: emoteId ?? this.emoteId,
      emoteText0: emoteText0 ?? this.emoteText0,
      emoteText1: emoteText1 ?? this.emoteText1,
      emoteText2: emoteText2 ?? this.emoteText2,
      emoteText3: emoteText3 ?? this.emoteText3,
      emoteText4: emoteText4 ?? this.emoteText4,
      emoteText5: emoteText5 ?? this.emoteText5,
      emoteText6: emoteText6 ?? this.emoteText6,
      emoteText7: emoteText7 ?? this.emoteText7,
      emoteText8: emoteText8 ?? this.emoteText8,
      emoteText9: emoteText9 ?? this.emoteText9,
      emoteText10: emoteText10 ?? this.emoteText10,
      emoteText11: emoteText11 ?? this.emoteText11,
      emoteText12: emoteText12 ?? this.emoteText12,
      emoteText13: emoteText13 ?? this.emoteText13,
      emoteText14: emoteText14 ?? this.emoteText14,
      emoteText15: emoteText15 ?? this.emoteText15,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'EmoteID': emoteId,
      'EmoteText0': emoteText0,
      'EmoteText1': emoteText1,
      'EmoteText2': emoteText2,
      'EmoteText3': emoteText3,
      'EmoteText4': emoteText4,
      'EmoteText5': emoteText5,
      'EmoteText6': emoteText6,
      'EmoteText7': emoteText7,
      'EmoteText8': emoteText8,
      'EmoteText9': emoteText9,
      'EmoteText10': emoteText10,
      'EmoteText11': emoteText11,
      'EmoteText12': emoteText12,
      'EmoteText13': emoteText13,
      'EmoteText14': emoteText14,
      'EmoteText15': emoteText15,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EmoteTextEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            emoteId == other.emoteId &&
            emoteText0 == other.emoteText0 &&
            emoteText1 == other.emoteText1 &&
            emoteText2 == other.emoteText2 &&
            emoteText3 == other.emoteText3 &&
            emoteText4 == other.emoteText4 &&
            emoteText5 == other.emoteText5 &&
            emoteText6 == other.emoteText6 &&
            emoteText7 == other.emoteText7 &&
            emoteText8 == other.emoteText8 &&
            emoteText9 == other.emoteText9 &&
            emoteText10 == other.emoteText10 &&
            emoteText11 == other.emoteText11 &&
            emoteText12 == other.emoteText12 &&
            emoteText13 == other.emoteText13 &&
            emoteText14 == other.emoteText14 &&
            emoteText15 == other.emoteText15;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      name,
      emoteId,
      emoteText0,
      emoteText1,
      emoteText2,
      emoteText3,
      emoteText4,
      emoteText5,
      emoteText6,
      emoteText7,
      emoteText8,
      emoteText9,
      emoteText10,
      emoteText11,
      emoteText12,
      emoteText13,
      emoteText14,
      emoteText15,
    ]);
  }

  @override
  String toString() {
    return 'EmoteTextEntity('
        'id: $id, '
        'name: $name, '
        'emoteId: $emoteId, '
        'emoteText0: $emoteText0, '
        'emoteText1: $emoteText1, '
        'emoteText2: $emoteText2, '
        'emoteText3: $emoteText3, '
        'emoteText4: $emoteText4, '
        'emoteText5: $emoteText5, '
        'emoteText6: $emoteText6, '
        'emoteText7: $emoteText7, '
        'emoteText8: $emoteText8, '
        'emoteText9: $emoteText9, '
        'emoteText10: $emoteText10, '
        'emoteText11: $emoteText11, '
        'emoteText12: $emoteText12, '
        'emoteText13: $emoteText13, '
        'emoteText14: $emoteText14, '
        'emoteText15: $emoteText15'
        ')';
  }
}
