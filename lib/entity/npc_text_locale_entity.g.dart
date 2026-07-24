// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_text_locale_entity.dart';

mixin _NpcTextLocaleEntityMixin {
  static NpcTextLocaleEntity fromJson(Map<String, dynamic> json) {
    return NpcTextLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['Locale']?.toString() ?? 'zhCN',
      text00: json['Text0_0']?.toString() ?? '',
      text01: json['Text0_1']?.toString() ?? '',
      text10: json['Text1_0']?.toString() ?? '',
      text11: json['Text1_1']?.toString() ?? '',
      text20: json['Text2_0']?.toString() ?? '',
      text21: json['Text2_1']?.toString() ?? '',
      text30: json['Text3_0']?.toString() ?? '',
      text31: json['Text3_1']?.toString() ?? '',
      text40: json['Text4_0']?.toString() ?? '',
      text41: json['Text4_1']?.toString() ?? '',
      text50: json['Text5_0']?.toString() ?? '',
      text51: json['Text5_1']?.toString() ?? '',
      text60: json['Text6_0']?.toString() ?? '',
      text61: json['Text6_1']?.toString() ?? '',
      text70: json['Text7_0']?.toString() ?? '',
      text71: json['Text7_1']?.toString() ?? '',
    );
  }

  NpcTextLocaleEntity copyWith({
    int? id,
    String? locale,
    String? text00,
    String? text01,
    String? text10,
    String? text11,
    String? text20,
    String? text21,
    String? text30,
    String? text31,
    String? text40,
    String? text41,
    String? text50,
    String? text51,
    String? text60,
    String? text61,
    String? text70,
    String? text71,
  }) {
    final self = this as NpcTextLocaleEntity;
    return NpcTextLocaleEntity(
      id: id ?? self.id,
      locale: locale ?? self.locale,
      text00: text00 ?? self.text00,
      text01: text01 ?? self.text01,
      text10: text10 ?? self.text10,
      text11: text11 ?? self.text11,
      text20: text20 ?? self.text20,
      text21: text21 ?? self.text21,
      text30: text30 ?? self.text30,
      text31: text31 ?? self.text31,
      text40: text40 ?? self.text40,
      text41: text41 ?? self.text41,
      text50: text50 ?? self.text50,
      text51: text51 ?? self.text51,
      text60: text60 ?? self.text60,
      text61: text61 ?? self.text61,
      text70: text70 ?? self.text70,
      text71: text71 ?? self.text71,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as NpcTextLocaleEntity;
    return {
      'ID': self.id,
      'Locale': self.locale,
      'Text0_0': self.text00,
      'Text0_1': self.text01,
      'Text1_0': self.text10,
      'Text1_1': self.text11,
      'Text2_0': self.text20,
      'Text2_1': self.text21,
      'Text3_0': self.text30,
      'Text3_1': self.text31,
      'Text4_0': self.text40,
      'Text4_1': self.text41,
      'Text5_0': self.text50,
      'Text5_1': self.text51,
      'Text6_0': self.text60,
      'Text6_1': self.text61,
      'Text7_0': self.text70,
      'Text7_1': self.text71,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as NpcTextLocaleEntity;
    return identical(self, other) ||
        other is NpcTextLocaleEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.locale == other.locale &&
            self.text00 == other.text00 &&
            self.text01 == other.text01 &&
            self.text10 == other.text10 &&
            self.text11 == other.text11 &&
            self.text20 == other.text20 &&
            self.text21 == other.text21 &&
            self.text30 == other.text30 &&
            self.text31 == other.text31 &&
            self.text40 == other.text40 &&
            self.text41 == other.text41 &&
            self.text50 == other.text50 &&
            self.text51 == other.text51 &&
            self.text60 == other.text60 &&
            self.text61 == other.text61 &&
            self.text70 == other.text70 &&
            self.text71 == other.text71;
  }

  @override
  int get hashCode {
    final self = this as NpcTextLocaleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.locale,
      self.text00,
      self.text01,
      self.text10,
      self.text11,
      self.text20,
      self.text21,
      self.text30,
      self.text31,
      self.text40,
      self.text41,
      self.text50,
      self.text51,
      self.text60,
      self.text61,
      self.text70,
      self.text71,
    ]);
  }

  @override
  String toString() {
    final self = this as NpcTextLocaleEntity;
    return 'NpcTextLocaleEntity('
        'id: ${self.id}, '
        'locale: ${self.locale}, '
        'text00: ${self.text00}, '
        'text01: ${self.text01}, '
        'text10: ${self.text10}, '
        'text11: ${self.text11}, '
        'text20: ${self.text20}, '
        'text21: ${self.text21}, '
        'text30: ${self.text30}, '
        'text31: ${self.text31}, '
        'text40: ${self.text40}, '
        'text41: ${self.text41}, '
        'text50: ${self.text50}, '
        'text51: ${self.text51}, '
        'text60: ${self.text60}, '
        'text61: ${self.text61}, '
        'text70: ${self.text70}, '
        'text71: ${self.text71}'
        ')';
  }
}

final class NpcTextLocaleKey {
  final int id;
  final String locale;

  const NpcTextLocaleKey({required this.id, required this.locale});

  factory NpcTextLocaleKey.fromEntity(NpcTextLocaleEntity entity) {
    return NpcTextLocaleKey(id: entity.id, locale: entity.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NpcTextLocaleKey && id == other.id && locale == other.locale;
  }

  @override
  int get hashCode => Object.hashAll([id, locale]);

  @override
  String toString() {
    return 'NpcTextLocaleKey('
        'id: $id, '
        'locale: $locale'
        ')';
  }
}

final class BriefNpcTextLocaleEntity {
  final int id;
  final String locale;

  const BriefNpcTextLocaleEntity({this.id = 0, this.locale = 'zhCN'});

  factory BriefNpcTextLocaleEntity.fromJson(Map<String, dynamic> json) {
    return BriefNpcTextLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['Locale']?.toString() ?? 'zhCN',
    );
  }

  NpcTextLocaleKey get key {
    return NpcTextLocaleKey(id: id, locale: locale);
  }
}
