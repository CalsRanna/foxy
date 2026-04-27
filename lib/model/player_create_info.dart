class PlayerCreateInfo {
  int race = 0;
  int class_ = 0;
  int map = 0;
  int zone = 0;
  double positionX = 0;
  double positionY = 0;
  double positionZ = 0;
  double orientation = 0;

  PlayerCreateInfo();

  Map<String, dynamic> buildCredential() {
    return {'race': race, 'class': class_};
  }

  PlayerCreateInfo.fromJson(Map<String, dynamic> json) {
    race = json['race'] ?? 0;
    class_ = json['class'] ?? 0;
    map = json['map'] ?? 0;
    zone = json['zone'] ?? 0;
    positionX = (json['position_x'] as num?)?.toDouble() ?? 0;
    positionY = (json['position_y'] as num?)?.toDouble() ?? 0;
    positionZ = (json['position_z'] as num?)?.toDouble() ?? 0;
    orientation = (json['orientation'] as num?)?.toDouble() ?? 0;
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
  int race = 0;
  int class_ = 0;
  int button = 0;
  int action = 0;
  int type = 0;

  PlayerCreateInfoAction();

  PlayerCreateInfoAction.fromJson(Map<String, dynamic> json) {
    race = json['race'] ?? 0;
    class_ = json['class'] ?? 0;
    button = json['button'] ?? 0;
    action = json['action'] ?? 0;
    type = json['type'] ?? 0;
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
  int race = 0;
  int class_ = 0;
  int itemid = 0;
  int amount = 1;
  String note = '';

  PlayerCreateInfoItem();

  PlayerCreateInfoItem.fromJson(Map<String, dynamic> json) {
    race = json['race'] ?? 0;
    class_ = json['class'] ?? 0;
    itemid = json['itemid'] ?? 0;
    amount = json['amount'] ?? 1;
    note = json['Note'] ?? '';
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
  int racemask = 0;
  int classmask = 0;
  int spell = 0;
  String note = '';

  PlayerCreateInfoSpellCustom();

  PlayerCreateInfoSpellCustom.fromJson(Map<String, dynamic> json) {
    racemask = json['racemask'] ?? 0;
    classmask = json['classmask'] ?? 0;
    spell = json['spell'] ?? 0;
    note = json['note'] ?? '';
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
