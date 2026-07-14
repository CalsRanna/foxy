class EmoteTextEntity {
  final int id;
  final String name;
  final int emoteId;
  final int emoteText0;
  final int emoteText1;
  final int emoteText2;
  final int emoteText3;
  final int emoteText4;
  final int emoteText5;
  final int emoteText6;
  final int emoteText7;
  final int emoteText8;
  final int emoteText9;
  final int emoteText10;
  final int emoteText11;
  final int emoteText12;
  final int emoteText13;
  final int emoteText14;
  final int emoteText15;

  const EmoteTextEntity({
    this.id = 0,
    this.name = '',
    this.emoteId = 0,
    this.emoteText0 = 0,
    this.emoteText1 = 0,
    this.emoteText2 = 0,
    this.emoteText3 = 0,
    this.emoteText4 = 0,
    this.emoteText5 = 0,
    this.emoteText6 = 0,
    this.emoteText7 = 0,
    this.emoteText8 = 0,
    this.emoteText9 = 0,
    this.emoteText10 = 0,
    this.emoteText11 = 0,
    this.emoteText12 = 0,
    this.emoteText13 = 0,
    this.emoteText14 = 0,
    this.emoteText15 = 0,
  });

  factory EmoteTextEntity.fromJson(Map<String, dynamic> json) {
    return EmoteTextEntity(
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      emoteId: json['EmoteID'] ?? 0,
      emoteText0: json['EmoteText0'] ?? 0,
      emoteText1: json['EmoteText1'] ?? 0,
      emoteText2: json['EmoteText2'] ?? 0,
      emoteText3: json['EmoteText3'] ?? 0,
      emoteText4: json['EmoteText4'] ?? 0,
      emoteText5: json['EmoteText5'] ?? 0,
      emoteText6: json['EmoteText6'] ?? 0,
      emoteText7: json['EmoteText7'] ?? 0,
      emoteText8: json['EmoteText8'] ?? 0,
      emoteText9: json['EmoteText9'] ?? 0,
      emoteText10: json['EmoteText10'] ?? 0,
      emoteText11: json['EmoteText11'] ?? 0,
      emoteText12: json['EmoteText12'] ?? 0,
      emoteText13: json['EmoteText13'] ?? 0,
      emoteText14: json['EmoteText14'] ?? 0,
      emoteText15: json['EmoteText15'] ?? 0,
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

  void validate() {
    if (id <= 0) throw StateError('编号必须大于 0');
    _requireNonNegative('表情编号', emoteId);
    _requireNonNegative('表情文本 1', emoteText0);
    _requireNonNegative('表情文本 2', emoteText1);
    _requireNonNegative('表情文本 3', emoteText2);
    _requireNonNegative('表情文本 4', emoteText3);
    _requireNonNegative('表情文本 5', emoteText4);
    _requireNonNegative('表情文本 6', emoteText5);
    _requireNonNegative('表情文本 7', emoteText6);
    _requireNonNegative('表情文本 8', emoteText7);
    _requireNonNegative('表情文本 9', emoteText8);
    _requireNonNegative('表情文本 10', emoteText9);
    _requireNonNegative('表情文本 11', emoteText10);
    _requireNonNegative('表情文本 12', emoteText11);
    _requireNonNegative('表情文本 13', emoteText12);
    _requireNonNegative('表情文本 14', emoteText13);
    _requireNonNegative('表情文本 15', emoteText14);
    _requireNonNegative('表情文本 16', emoteText15);
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
}

void _requireNonNegative(String label, int value) {
  if (value < 0) throw StateError('$label 不能小于 0');
}

/// 表情文本列表/Picker 展示模型
class BriefEmoteTextEntity {
  final int id;
  final String name;
  final int emoteId;

  const BriefEmoteTextEntity({this.id = 0, this.name = '', this.emoteId = 0});

  factory BriefEmoteTextEntity.fromJson(Map<String, dynamic> json) {
    return BriefEmoteTextEntity(
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      emoteId: json['EmoteID'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Name': name, 'EmoteID': emoteId};
  }

  BriefEmoteTextEntity copyWith({int? id, String? name, int? emoteId}) {
    return BriefEmoteTextEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      emoteId: emoteId ?? this.emoteId,
    );
  }
}
