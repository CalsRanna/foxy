// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_action_entity.dart';

mixin _PlayerCreateInfoActionEntityMixin {
  int get race;
  int get class_;
  int get button;
  int get action;
  int get type;

  static PlayerCreateInfoActionEntity fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoActionEntity(
      race: (json['race'] as num?)?.toInt() ?? 0,
      class_: (json['class'] as num?)?.toInt() ?? 0,
      button: (json['button'] as num?)?.toInt() ?? 0,
      action: (json['action'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
    );
  }

  PlayerCreateInfoActionEntity copyWith({
    int? race,
    int? class_,
    int? button,
    int? action,
    int? type,
  }) {
    return PlayerCreateInfoActionEntity(
      race: race ?? this.race,
      class_: class_ ?? this.class_,
      button: button ?? this.button,
      action: action ?? this.action,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'race': race,
      'class': class_,
      'button': button,
      'action': action,
      'type': type,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoActionEntity &&
            runtimeType == other.runtimeType &&
            race == other.race &&
            class_ == other.class_ &&
            button == other.button &&
            action == other.action &&
            type == other.type;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, race, class_, button, action, type]);
  }

  @override
  String toString() {
    return 'PlayerCreateInfoActionEntity('
        'race: $race, '
        'class_: $class_, '
        'button: $button, '
        'action: $action, '
        'type: $type'
        ')';
  }
}
