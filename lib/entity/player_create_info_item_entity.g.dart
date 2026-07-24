// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_item_entity.dart';

mixin _PlayerCreateInfoItemEntityMixin {
  static PlayerCreateInfoItemEntity fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoItemEntity(
      race: (json['race'] as num?)?.toInt() ?? 0,
      class_: (json['class'] as num?)?.toInt() ?? 0,
      itemId: (json['itemid'] as num?)?.toInt() ?? 0,
      amount: (json['amount'] as num?)?.toInt() ?? 1,
      note: json['Note']?.toString() ?? '',
    );
  }

  PlayerCreateInfoItemEntity copyWith({
    int? race,
    int? class_,
    int? itemId,
    int? amount,
    String? note,
  }) {
    final self = this as PlayerCreateInfoItemEntity;
    return PlayerCreateInfoItemEntity(
      race: race ?? self.race,
      class_: class_ ?? self.class_,
      itemId: itemId ?? self.itemId,
      amount: amount ?? self.amount,
      note: note ?? self.note,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as PlayerCreateInfoItemEntity;
    return {
      'race': self.race,
      'class': self.class_,
      'itemid': self.itemId,
      'amount': self.amount,
      'Note': self.note,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as PlayerCreateInfoItemEntity;
    return identical(self, other) ||
        other is PlayerCreateInfoItemEntity &&
            self.runtimeType == other.runtimeType &&
            self.race == other.race &&
            self.class_ == other.class_ &&
            self.itemId == other.itemId &&
            self.amount == other.amount &&
            self.note == other.note;
  }

  @override
  int get hashCode {
    final self = this as PlayerCreateInfoItemEntity;
    return Object.hashAll([
      self.runtimeType,
      self.race,
      self.class_,
      self.itemId,
      self.amount,
      self.note,
    ]);
  }

  @override
  String toString() {
    final self = this as PlayerCreateInfoItemEntity;
    return 'PlayerCreateInfoItemEntity('
        'race: ${self.race}, '
        'class_: ${self.class_}, '
        'itemId: ${self.itemId}, '
        'amount: ${self.amount}, '
        'note: ${self.note}'
        ')';
  }
}

final class PlayerCreateInfoItemKey {
  final int race;
  final int class_;
  final int itemId;

  const PlayerCreateInfoItemKey({
    required this.race,
    required this.class_,
    required this.itemId,
  });

  factory PlayerCreateInfoItemKey.fromEntity(
    PlayerCreateInfoItemEntity entity,
  ) {
    return PlayerCreateInfoItemKey(
      race: entity.race,
      class_: entity.class_,
      itemId: entity.itemId,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoItemKey &&
            race == other.race &&
            class_ == other.class_ &&
            itemId == other.itemId;
  }

  @override
  int get hashCode => Object.hashAll([race, class_, itemId]);

  @override
  String toString() {
    return 'PlayerCreateInfoItemKey('
        'race: $race, '
        'class_: $class_, '
        'itemId: $itemId'
        ')';
  }
}

final class BriefPlayerCreateInfoItemEntity {
  final int race;
  final int class_;
  final int itemId;
  final int amount;
  final String note;

  const BriefPlayerCreateInfoItemEntity({
    this.race = 0,
    this.class_ = 0,
    this.itemId = 0,
    this.amount = 1,
    this.note = '',
  });

  factory BriefPlayerCreateInfoItemEntity.fromJson(Map<String, dynamic> json) {
    return BriefPlayerCreateInfoItemEntity(
      race: (json['race'] as num?)?.toInt() ?? 0,
      class_: (json['class'] as num?)?.toInt() ?? 0,
      itemId: (json['itemid'] as num?)?.toInt() ?? 0,
      amount: (json['amount'] as num?)?.toInt() ?? 1,
      note: json['Note']?.toString() ?? '',
    );
  }

  PlayerCreateInfoItemKey get key {
    return PlayerCreateInfoItemKey(race: race, class_: class_, itemId: itemId);
  }
}
