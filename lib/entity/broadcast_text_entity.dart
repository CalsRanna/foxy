/// 广播文本列表/Picker 展示模型
class BriefBroadcastTextEntity {
  final int id;
  final String maleText;
  final int languageId;

  const BriefBroadcastTextEntity({
    this.id = 0,
    this.maleText = '',
    this.languageId = 0,
  });

  factory BriefBroadcastTextEntity.fromJson(Map<String, dynamic> json) {
    return BriefBroadcastTextEntity(
      id: json['ID'] ?? 0,
      maleText: json['MaleText'] ?? json['display_text'] ?? '',
      languageId: json['LanguageID'] ?? 0,
    );
  }

  BriefBroadcastTextEntity copyWith({
    int? id,
    String? maleText,
    int? languageId,
  }) {
    return BriefBroadcastTextEntity(
      id: id ?? this.id,
      maleText: maleText ?? this.maleText,
      languageId: languageId ?? this.languageId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'MaleText': maleText, 'LanguageID': languageId};
  }
}

class BroadcastTextEntity {
  final int id;
  final int languageId;
  final String maleText;
  final String femaleText;

  const BroadcastTextEntity({
    this.id = 0,
    this.languageId = 0,
    this.maleText = '',
    this.femaleText = '',
  });

  factory BroadcastTextEntity.fromJson(Map<String, dynamic> json) {
    return BroadcastTextEntity(
      id: json['ID'] ?? 0,
      languageId: json['LanguageID'] ?? 0,
      maleText: json['MaleText'] ?? '',
      femaleText: json['FemaleText'] ?? '',
    );
  }

  String get displayText {
    if (maleText.isNotEmpty) return maleText;
    return femaleText;
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
}
