// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_text_entity.dart';

mixin _EmoteTextEntityMixin {
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
    final self = this as EmoteTextEntity;
    return EmoteTextEntity(
      id: id ?? self.id,
      name: name ?? self.name,
      emoteId: emoteId ?? self.emoteId,
      emoteText0: emoteText0 ?? self.emoteText0,
      emoteText1: emoteText1 ?? self.emoteText1,
      emoteText2: emoteText2 ?? self.emoteText2,
      emoteText3: emoteText3 ?? self.emoteText3,
      emoteText4: emoteText4 ?? self.emoteText4,
      emoteText5: emoteText5 ?? self.emoteText5,
      emoteText6: emoteText6 ?? self.emoteText6,
      emoteText7: emoteText7 ?? self.emoteText7,
      emoteText8: emoteText8 ?? self.emoteText8,
      emoteText9: emoteText9 ?? self.emoteText9,
      emoteText10: emoteText10 ?? self.emoteText10,
      emoteText11: emoteText11 ?? self.emoteText11,
      emoteText12: emoteText12 ?? self.emoteText12,
      emoteText13: emoteText13 ?? self.emoteText13,
      emoteText14: emoteText14 ?? self.emoteText14,
      emoteText15: emoteText15 ?? self.emoteText15,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as EmoteTextEntity;
    return {
      'ID': self.id,
      'Name': self.name,
      'EmoteID': self.emoteId,
      'EmoteText0': self.emoteText0,
      'EmoteText1': self.emoteText1,
      'EmoteText2': self.emoteText2,
      'EmoteText3': self.emoteText3,
      'EmoteText4': self.emoteText4,
      'EmoteText5': self.emoteText5,
      'EmoteText6': self.emoteText6,
      'EmoteText7': self.emoteText7,
      'EmoteText8': self.emoteText8,
      'EmoteText9': self.emoteText9,
      'EmoteText10': self.emoteText10,
      'EmoteText11': self.emoteText11,
      'EmoteText12': self.emoteText12,
      'EmoteText13': self.emoteText13,
      'EmoteText14': self.emoteText14,
      'EmoteText15': self.emoteText15,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as EmoteTextEntity;
    return identical(self, other) ||
        other is EmoteTextEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.name == other.name &&
            self.emoteId == other.emoteId &&
            self.emoteText0 == other.emoteText0 &&
            self.emoteText1 == other.emoteText1 &&
            self.emoteText2 == other.emoteText2 &&
            self.emoteText3 == other.emoteText3 &&
            self.emoteText4 == other.emoteText4 &&
            self.emoteText5 == other.emoteText5 &&
            self.emoteText6 == other.emoteText6 &&
            self.emoteText7 == other.emoteText7 &&
            self.emoteText8 == other.emoteText8 &&
            self.emoteText9 == other.emoteText9 &&
            self.emoteText10 == other.emoteText10 &&
            self.emoteText11 == other.emoteText11 &&
            self.emoteText12 == other.emoteText12 &&
            self.emoteText13 == other.emoteText13 &&
            self.emoteText14 == other.emoteText14 &&
            self.emoteText15 == other.emoteText15;
  }

  @override
  int get hashCode {
    final self = this as EmoteTextEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.name,
      self.emoteId,
      self.emoteText0,
      self.emoteText1,
      self.emoteText2,
      self.emoteText3,
      self.emoteText4,
      self.emoteText5,
      self.emoteText6,
      self.emoteText7,
      self.emoteText8,
      self.emoteText9,
      self.emoteText10,
      self.emoteText11,
      self.emoteText12,
      self.emoteText13,
      self.emoteText14,
      self.emoteText15,
    ]);
  }

  @override
  String toString() {
    final self = this as EmoteTextEntity;
    return 'EmoteTextEntity('
        'id: ${self.id}, '
        'name: ${self.name}, '
        'emoteId: ${self.emoteId}, '
        'emoteText0: ${self.emoteText0}, '
        'emoteText1: ${self.emoteText1}, '
        'emoteText2: ${self.emoteText2}, '
        'emoteText3: ${self.emoteText3}, '
        'emoteText4: ${self.emoteText4}, '
        'emoteText5: ${self.emoteText5}, '
        'emoteText6: ${self.emoteText6}, '
        'emoteText7: ${self.emoteText7}, '
        'emoteText8: ${self.emoteText8}, '
        'emoteText9: ${self.emoteText9}, '
        'emoteText10: ${self.emoteText10}, '
        'emoteText11: ${self.emoteText11}, '
        'emoteText12: ${self.emoteText12}, '
        'emoteText13: ${self.emoteText13}, '
        'emoteText14: ${self.emoteText14}, '
        'emoteText15: ${self.emoteText15}'
        ')';
  }
}
