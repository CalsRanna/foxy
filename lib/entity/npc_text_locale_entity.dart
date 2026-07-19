class NpcTextLocaleEntity {
  final int id;
  final String locale;
  final String text00;
  final String text01;
  final String text10;
  final String text11;
  final String text20;
  final String text21;
  final String text30;
  final String text31;
  final String text40;
  final String text41;
  final String text50;
  final String text51;
  final String text60;
  final String text61;
  final String text70;
  final String text71;

  const NpcTextLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.text00 = '',
    this.text01 = '',
    this.text10 = '',
    this.text11 = '',
    this.text20 = '',
    this.text21 = '',
    this.text30 = '',
    this.text31 = '',
    this.text40 = '',
    this.text41 = '',
    this.text50 = '',
    this.text51 = '',
    this.text60 = '',
    this.text61 = '',
    this.text70 = '',
    this.text71 = '',
  });

  factory NpcTextLocaleEntity.fromJson(Map<String, dynamic> json) {
    return NpcTextLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? (json['id'] as num?)?.toInt() ?? 0,
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

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Locale': locale,
      'Text0_0': text00,
      'Text0_1': text01,
      'Text1_0': text10,
      'Text1_1': text11,
      'Text2_0': text20,
      'Text2_1': text21,
      'Text3_0': text30,
      'Text3_1': text31,
      'Text4_0': text40,
      'Text4_1': text41,
      'Text5_0': text50,
      'Text5_1': text51,
      'Text6_0': text60,
      'Text6_1': text61,
      'Text7_0': text70,
      'Text7_1': text71,
    };
  }
}
