class PlayerCreateInfoFilterEntity {
  final String race;
  final String class_;

  const PlayerCreateInfoFilterEntity({this.race = '', this.class_ = ''});

  factory PlayerCreateInfoFilterEntity.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoFilterEntity(
      race: json['race'] ?? '',
      class_: json['class_'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'race': race, 'class_': class_};
  }
}
