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

  PlayerCreateInfoFilterEntity copyWith({String? race, String? class_}) {
    return PlayerCreateInfoFilterEntity(
      race: race ?? this.race,
      class_: class_ ?? this.class_,
    );
  }

  Map<String, dynamic> toJson() {
    return {'race': race, 'class_': class_};
  }
}
