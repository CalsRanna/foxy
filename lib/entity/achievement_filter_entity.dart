class AchievementFilterEntity {
  final String id;
  final String title;

  const AchievementFilterEntity({this.id = '', this.title = ''});

  factory AchievementFilterEntity.fromJson(Map<String, dynamic> json) {
    return AchievementFilterEntity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
    );
  }

  AchievementFilterEntity copyWith({String? id, String? title}) {
    return AchievementFilterEntity(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}
