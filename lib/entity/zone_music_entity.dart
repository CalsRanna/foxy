class ZoneMusicEntity {
  final int id;
  final String setName;
  final int silenceIntervalMin0;
  final int silenceIntervalMin1;
  final int silenceIntervalMax0;
  final int silenceIntervalMax1;
  final int sounds0;
  final int sounds1;

  const ZoneMusicEntity({
    this.id = 0,
    this.setName = '',
    this.silenceIntervalMin0 = 0,
    this.silenceIntervalMin1 = 0,
    this.silenceIntervalMax0 = 0,
    this.silenceIntervalMax1 = 0,
    this.sounds0 = 0,
    this.sounds1 = 0,
  });

  factory ZoneMusicEntity.fromJson(Map<String, dynamic> json) =>
      ZoneMusicEntity(
        id: json['ID'] ?? 0,
        setName: json['SetName'] ?? '',
        silenceIntervalMin0: json['SilenceIntervalMin0'] ?? 0,
        silenceIntervalMin1: json['SilenceIntervalMin1'] ?? 0,
        silenceIntervalMax0: json['SilenceIntervalMax0'] ?? 0,
        silenceIntervalMax1: json['SilenceIntervalMax1'] ?? 0,
        sounds0: json['Sounds0'] ?? 0,
        sounds1: json['Sounds1'] ?? 0,
      );

  ZoneMusicEntity copyWith({
    int? id,
    String? setName,
    int? silenceIntervalMin0,
    int? silenceIntervalMin1,
    int? silenceIntervalMax0,
    int? silenceIntervalMax1,
    int? sounds0,
    int? sounds1,
  }) {
    return ZoneMusicEntity(
      id: id ?? this.id,
      setName: setName ?? this.setName,
      silenceIntervalMin0: silenceIntervalMin0 ?? this.silenceIntervalMin0,
      silenceIntervalMin1: silenceIntervalMin1 ?? this.silenceIntervalMin1,
      silenceIntervalMax0: silenceIntervalMax0 ?? this.silenceIntervalMax0,
      silenceIntervalMax1: silenceIntervalMax1 ?? this.silenceIntervalMax1,
      sounds0: sounds0 ?? this.sounds0,
      sounds1: sounds1 ?? this.sounds1,
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'SetName': setName,
    'SilenceIntervalMin0': silenceIntervalMin0,
    'SilenceIntervalMin1': silenceIntervalMin1,
    'SilenceIntervalMax0': silenceIntervalMax0,
    'SilenceIntervalMax1': silenceIntervalMax1,
    'Sounds0': sounds0,
    'Sounds1': sounds1,
  };
}
