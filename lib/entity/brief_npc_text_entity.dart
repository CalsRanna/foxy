class BriefNpcTextEntity {
  final int id;
  final String text0;
  final String text1;

  const BriefNpcTextEntity({this.id = 0, this.text0 = '', this.text1 = ''});

  factory BriefNpcTextEntity.fromJson(Map<String, dynamic> json) =>
      BriefNpcTextEntity(
        id: (json['ID'] as num?)?.toInt() ?? (json['id'] as num?)?.toInt() ?? 0,
        text0: json['text0_0']?.toString() ?? '',
        text1: json['text0_1']?.toString() ?? '',
      );

  String get displayText => text0.isNotEmpty ? text0 : text1;

  int get key => id;
}
