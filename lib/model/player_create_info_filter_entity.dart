class PlayerCreateInfoFilterEntity {
  String race = '';
  String class_ = '';

  PlayerCreateInfoFilterEntity();

  factory PlayerCreateInfoFilterEntity.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoFilterEntity()
      ..race = json['race'] ?? ''
      ..class_ = json['class_'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'race': race, 'class_': class_};
  }
}
