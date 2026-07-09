class ItemRandomPropertiesEntity {
  final int id;
  final String name;
  final String nameLangZhCn;

  const ItemRandomPropertiesEntity({
    this.id = 0,
    this.name = '',
    this.nameLangZhCn = '',
  });

  factory ItemRandomPropertiesEntity.fromJson(Map<String, dynamic> json) {
    return ItemRandomPropertiesEntity(
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      nameLangZhCn: json['Name_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Name': name, 'Name_lang_zhCN': nameLangZhCn};
  }

  ItemRandomPropertiesEntity copyWith({
    int? id,
    String? name,
    String? nameLangZhCn,
  }) {
    return ItemRandomPropertiesEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      nameLangZhCn: nameLangZhCn ?? this.nameLangZhCn,
    );
  }
}

/// 随机属性列表/Picker 展示模型
class BriefItemRandomPropertiesEntity {
  final int id;
  final String name;
  final String nameLangZhCn;

  const BriefItemRandomPropertiesEntity({
    this.id = 0,
    this.name = '',
    this.nameLangZhCn = '',
  });

  factory BriefItemRandomPropertiesEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemRandomPropertiesEntity(
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      nameLangZhCn: json['Name_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Name': name, 'Name_lang_zhCN': nameLangZhCn};
  }

  BriefItemRandomPropertiesEntity copyWith({
    int? id,
    String? name,
    String? nameLangZhCn,
  }) {
    return BriefItemRandomPropertiesEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      nameLangZhCn: nameLangZhCn ?? this.nameLangZhCn,
    );
  }
}
