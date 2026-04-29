class PlayerCreateInfo {
  final int race;
  final int class_;
  final int map;
  final int zone;
  final double positionX;
  final double positionY;
  final double positionZ;
  final double orientation;

  const PlayerCreateInfo({
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

  factory PlayerCreateInfo.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfo(
      race: json['race'] ?? 0,
      class_: json['class'] ?? 0,
      map: json['map'] ?? 0,
      zone: json['zone'] ?? 0,
      positionX: (json['position_x'] as num?)?.toDouble() ?? 0,
      positionY: (json['position_y'] as num?)?.toDouble() ?? 0,
      positionZ: (json['position_z'] as num?)?.toDouble() ?? 0,
      orientation: (json['orientation'] as num?)?.toDouble() ?? 0,
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
}

class PlayerCreateInfoAction {
  final int race;
  final int class_;
  final int button;
  final int action;
  final int type;

  const PlayerCreateInfoAction({
    this.race = 0,
    this.class_ = 0,
    this.button = 0,
    this.action = 0,
    this.type = 0,
  });

  factory PlayerCreateInfoAction.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoAction(
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
}

class PlayerCreateInfoItem {
  final int race;
  final int class_;
  final int itemid;
  final int amount;
  final String note;

  const PlayerCreateInfoItem({
    this.race = 0,
    this.class_ = 0,
    this.itemid = 0,
    this.amount = 1,
    this.note = '',
  });

  factory PlayerCreateInfoItem.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoItem(
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
}

class PlayerCreateInfoSpellCustom {
  final int racemask;
  final int classmask;
  final int spell;
  final String note;

  const PlayerCreateInfoSpellCustom({
    this.racemask = 0,
    this.classmask = 0,
    this.spell = 0,
    this.note = '',
  });

  factory PlayerCreateInfoSpellCustom.fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoSpellCustom(
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
}
