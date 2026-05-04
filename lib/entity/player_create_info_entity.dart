class PlayerCreateInfoEntity {
  final int race;
  final int class_;
  final int map;
  final int zone;
  final double positionX;
  final double positionY;
  final double positionZ;
  final double orientation;

  const PlayerCreateInfoEntity({
    this.race = 0,
    this.class_ = 0,
    this.map = 0,
    this.zone = 0,
    this.positionX = 0,
    this.positionY = 0,
    this.positionZ = 0,
    this.orientation = 0,
  });

  Map<String, dynamic> buildCredential() {
    return {'race': race, 'class': class_};
  }

  factory PlayerCreateInfoEntity.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoEntity(
      race: json['race'] ?? 0,
      class_: json['class'] ?? 0,
      map: json['map'] ?? 0,
      zone: json['zone'] ?? 0,
      positionX: json['position_x'] ?? 0,
      positionY: json['position_y'] ?? 0,
      positionZ: json['position_z'] ?? 0,
      orientation: json['orientation'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'race': race,
      'class': class_,
      'map': map,
      'zone': zone,
      'position_x': positionX,
      'position_y': positionY,
      'position_z': positionZ,
      'orientation': orientation,
    };
  }

  PlayerCreateInfoEntity copyWith({
    int? race,
    int? class_,
    int? map,
    int? zone,
    double? positionX,
    double? positionY,
    double? positionZ,
    double? orientation,
  }) {
    return PlayerCreateInfoEntity(
      race: race ?? this.race,
      class_: class_ ?? this.class_,
      map: map ?? this.map,
      zone: zone ?? this.zone,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      positionZ: positionZ ?? this.positionZ,
      orientation: orientation ?? this.orientation,
    );
  }
}

class PlayerCreateInfoActionEntity {
  final int race;
  final int class_;
  final int button;
  final int action;
  final int type;

  const PlayerCreateInfoActionEntity({
    this.race = 0,
    this.class_ = 0,
    this.button = 0,
    this.action = 0,
    this.type = 0,
  });

  factory PlayerCreateInfoActionEntity.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoActionEntity(
      race: json['race'] ?? 0,
      class_: json['class'] ?? 0,
      button: json['button'] ?? 0,
      action: json['action'] ?? 0,
      type: json['type'] ?? 0,
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
}

class PlayerCreateInfoItemEntity {
  final int race;
  final int class_;
  final int itemid;
  final int amount;
  final String note;

  const PlayerCreateInfoItemEntity({
    this.race = 0,
    this.class_ = 0,
    this.itemid = 0,
    this.amount = 1,
    this.note = '',
  });

  factory PlayerCreateInfoItemEntity.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoItemEntity(
      race: json['race'] ?? 0,
      class_: json['class'] ?? 0,
      itemid: json['itemid'] ?? 0,
      amount: json['amount'] ?? 1,
      note: json['Note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'race': race,
      'class': class_,
      'itemid': itemid,
      'amount': amount,
      'Note': note,
    };
  }

  PlayerCreateInfoItemEntity copyWith({
    int? race,
    int? class_,
    int? itemid,
    int? amount,
    String? note,
  }) {
    return PlayerCreateInfoItemEntity(
      race: race ?? this.race,
      class_: class_ ?? this.class_,
      itemid: itemid ?? this.itemid,
      amount: amount ?? this.amount,
      note: note ?? this.note,
    );
  }
}

class PlayerCreateInfoSpellCustomEntity {
  final int racemask;
  final int classmask;
  final int spell;
  final String note;

  const PlayerCreateInfoSpellCustomEntity({
    this.racemask = 0,
    this.classmask = 0,
    this.spell = 0,
    this.note = '',
  });

  factory PlayerCreateInfoSpellCustomEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return PlayerCreateInfoSpellCustomEntity(
      racemask: json['racemask'] ?? 0,
      classmask: json['classmask'] ?? 0,
      spell: json['spell'] ?? 0,
      note: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'racemask': racemask,
      'classmask': classmask,
      'spell': spell,
      'note': note,
    };
  }

  PlayerCreateInfoSpellCustomEntity copyWith({
    int? racemask,
    int? classmask,
    int? spell,
    String? note,
  }) {
    return PlayerCreateInfoSpellCustomEntity(
      racemask: racemask ?? this.racemask,
      classmask: classmask ?? this.classmask,
      spell: spell ?? this.spell,
      note: note ?? this.note,
    );
  }
}
