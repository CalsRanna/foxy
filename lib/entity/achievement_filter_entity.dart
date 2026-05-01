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

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}
