// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_action_entity.dart';

mixin _PlayerCreateInfoActionEntityMixin {
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
    final self = this as PlayerCreateInfoActionEntity;
    return PlayerCreateInfoActionEntity(
      race: race ?? self.race,
      class_: class_ ?? self.class_,
      button: button ?? self.button,
      action: action ?? self.action,
      type: type ?? self.type,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as PlayerCreateInfoActionEntity;
    return {
      'race': self.race,
      'class': self.class_,
      'button': self.button,
      'action': self.action,
      'type': self.type,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as PlayerCreateInfoActionEntity;
    return identical(self, other) ||
        other is PlayerCreateInfoActionEntity &&
            self.runtimeType == other.runtimeType &&
            self.race == other.race &&
            self.class_ == other.class_ &&
            self.button == other.button &&
            self.action == other.action &&
            self.type == other.type;
  }

  @override
  int get hashCode {
    final self = this as PlayerCreateInfoActionEntity;
    return Object.hashAll([
      self.runtimeType,
      self.race,
      self.class_,
      self.button,
      self.action,
      self.type,
    ]);
  }

  @override
  String toString() {
    final self = this as PlayerCreateInfoActionEntity;
    return 'PlayerCreateInfoActionEntity('
        'race: ${self.race}, '
        'class_: ${self.class_}, '
        'button: ${self.button}, '
        'action: ${self.action}, '
        'type: ${self.type}'
        ')';
  }
}
