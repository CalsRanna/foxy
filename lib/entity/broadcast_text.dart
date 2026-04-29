class BroadcastText {
  final int id;
  final int languageId;
  final String maleText;
  final String femaleText;

  const BroadcastText({
    this.id = 0,
    this.languageId = 0,
    this.maleText = '',
    this.femaleText = '',
  });

  factory BroadcastText.fromJson(Map<String, dynamic> json) {
    return BroadcastText(
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

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'LanguageID': languageId,
      'MaleText': maleText,
      'FemaleText': femaleText,
    };
  }
}
