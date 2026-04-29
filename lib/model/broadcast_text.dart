class BroadcastText {
  int id = 0;
  int languageId = 0;
  String maleText = '';
  String femaleText = '';

  BroadcastText();

  factory BroadcastText.fromJson(Map<String, dynamic> json) {
    return BroadcastText()
      ..id = json['ID'] ?? 0
      ..languageId = json['LanguageID'] ?? 0
      ..maleText = json['MaleText'] ?? ''
      ..femaleText = json['FemaleText'] ?? '';
  }

  String get displayText {
    if (maleText.isNotEmpty) return maleText;
    return femaleText;
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
