import 'package:foxy/constant/player_create_info_constants.dart';

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

  void validate() {
    if (!kPlayerRaceOptions.containsKey(race)) throw StateError('种族无效: $race');
    if (!kPlayerClassOptions.containsKey(class_)) {
      throw StateError('职业无效: $class_');
    }
    const maxCoordinate = 17066.166666666668;
    if (!positionX.isFinite ||
        positionX.abs() > maxCoordinate ||
        !positionY.isFinite ||
        positionY.abs() > maxCoordinate ||
        !positionZ.isFinite ||
        positionZ.abs() > maxCoordinate ||
        !orientation.isFinite) {
      throw StateError('出生坐标或朝向无效');
    }
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

  void validate() {
    if (!kPlayerRaceOptions.containsKey(race) ||
        !kPlayerClassOptions.containsKey(class_)) {
      throw StateError('动作按钮必须属于有效的种族/职业组合');
    }
    if (button < 0 || button >= 144) throw StateError('按钮必须在 0..143 之间');
    if (action < 0 || action >= 0x1000000) {
      throw StateError('动作必须在 0..16777215 之间');
    }
    if (!kPlayerActionButtonTypeOptions.containsKey(type)) {
      throw StateError('动作类型无效: $type');
    }
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

  void validate() {
    if (race != 0 && !kPlayerRaceOptions.containsKey(race)) {
      throw StateError('种族无效: $race');
    }
    if (class_ != 0 && !kPlayerClassOptions.containsKey(class_)) {
      throw StateError('职业无效: $class_');
    }
    if (itemid <= 0) throw StateError('物品 ID 必须大于 0');
    if (amount == 0) throw StateError('物品数量不能为 0');
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
      spell: json['Spell'] ?? 0,
      note: json['Note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'racemask': racemask,
      'classmask': classmask,
      'Spell': spell,
      'Note': note,
    };
  }

  void validate() {
    _validatePlayerCreateMasks(racemask, classmask);
    if (spell <= 0) throw StateError('法术 ID 必须大于 0');
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

class PlayerCreateInfoSkillEntity {
  final int raceMask;
  final int classMask;
  final int skill;
  final int rank;
  final String comment;

  const PlayerCreateInfoSkillEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.skill = 0,
    this.rank = 0,
    this.comment = '',
  });

  factory PlayerCreateInfoSkillEntity.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoSkillEntity(
      raceMask: json['raceMask'] ?? 0,
      classMask: json['classMask'] ?? 0,
      skill: json['skill'] ?? 0,
      rank: json['rank'] ?? 0,
      comment: json['comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'raceMask': raceMask,
    'classMask': classMask,
    'skill': skill,
    'rank': rank,
    'comment': comment,
  };

  void validate() {
    _validatePlayerCreateMasks(raceMask, classMask);
    if (skill <= 0) throw StateError('技能 ID 必须大于 0');
    if (rank < 0 || rank >= 16) throw StateError('技能阶数必须在 0..15 之间');
  }
}

class PlayerCreateInfoCastSpellEntity {
  final int raceMask;
  final int classMask;
  final int spell;
  final String note;

  const PlayerCreateInfoCastSpellEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.spell = 0,
    this.note = '',
  });

  factory PlayerCreateInfoCastSpellEntity.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoCastSpellEntity(
      raceMask: json['raceMask'] ?? 0,
      classMask: json['classMask'] ?? 0,
      spell: json['spell'] ?? 0,
      note: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'raceMask': raceMask,
    'classMask': classMask,
    'spell': spell,
    'note': note,
  };

  void validate() {
    _validatePlayerCreateMasks(raceMask, classMask);
    if (spell <= 0) throw StateError('法术 ID 必须大于 0');
  }
}

void _validatePlayerCreateMasks(int raceMask, int classMask) {
  if (raceMask != 0 && (raceMask & kPlayerCreatePlayableRaceMask) == 0) {
    throw StateError('种族掩码未包含可玩种族');
  }
  if (classMask != 0 && (classMask & kPlayerCreatePlayableClassMask) == 0) {
    throw StateError('职业掩码未包含可玩职业');
  }
}
