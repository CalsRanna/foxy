class QuestRequestItemsLocaleEntity {
  final int id;
  final String locale;
  final String completionText;
  final int verifiedBuild;

  const QuestRequestItemsLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.completionText = '',
    this.verifiedBuild = 0,
  });

  factory QuestRequestItemsLocaleEntity.fromJson(Map<String, dynamic> json) {
    return QuestRequestItemsLocaleEntity(
      id: (json['ID'] ?? json['id'] ?? 0) as int,
      locale: json['locale']?.toString() ?? 'zhCN',
      completionText: json['CompletionText']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  QuestRequestItemsLocaleEntity copyWith({
    int? id,
    String? locale,
    String? completionText,
    int? verifiedBuild,
  }) {
    return QuestRequestItemsLocaleEntity(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      completionText: completionText ?? this.completionText,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'locale': locale,
      'CompletionText': completionText,
      'VerifiedBuild': verifiedBuild,
    };
    return result;
  }
}
