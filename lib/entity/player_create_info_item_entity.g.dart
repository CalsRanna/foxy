// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_item_entity.dart';

mixin _PlayerCreateInfoItemEntityMixin {
  int get race;
  int get class_;
  int get itemId;
  int get amount;
  String get note;

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
    return PlayerCreateInfoItemEntity(
      race: race ?? this.race,
      class_: class_ ?? this.class_,
      itemId: itemId ?? this.itemId,
      amount: amount ?? this.amount,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'race': race,
      'class': class_,
      'itemid': itemId,
      'amount': amount,
      'Note': note,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoItemEntity &&
            runtimeType == other.runtimeType &&
            race == other.race &&
            class_ == other.class_ &&
            itemId == other.itemId &&
            amount == other.amount &&
            note == other.note;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, race, class_, itemId, amount, note]);
  }

  @override
  String toString() {
    return 'PlayerCreateInfoItemEntity('
        'race: $race, '
        'class_: $class_, '
        'itemId: $itemId, '
        'amount: $amount, '
        'note: $note'
        ')';
  }
}
