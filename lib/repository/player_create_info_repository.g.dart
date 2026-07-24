// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_repository.dart';

final class PlayerCreateInfoFilter {
  final String race;
  final String class_;

  const PlayerCreateInfoFilter({this.race = '', this.class_ = ''});

  factory PlayerCreateInfoFilter.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoFilter(
      race: json['race']?.toString() ?? '',
      class_: json['class_']?.toString() ?? '',
    );
  }

  PlayerCreateInfoFilter copyWith({String? race, String? class_}) {
    return PlayerCreateInfoFilter(
      race: race ?? this.race,
      class_: class_ ?? this.class_,
    );
  }

  Map<String, dynamic> toJson() {
    return {'race': race, 'class_': class_};
  }
}
