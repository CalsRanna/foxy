/// npc_text 主表模型（单主键: ID）
///
/// 每行包含 8 组（index 0..7）独立的文本数据，
/// 每组包含: lang{n} / Probability{n} / text{n}_0 / text{n}_1
///          / BroadcastTextID{n} / em{n}_0..5
class NpcTextEntity {
  final int id;
  final int verifiedBuild;
  final List<NpcTextEntryEntity> entries;

  const NpcTextEntity({
    this.id = 0,
    this.verifiedBuild = 0,
    this.entries = const [],
  });

  factory NpcTextEntity.fromJson(Map<String, dynamic> json) {
    return NpcTextEntity(
      id: json['ID'] ?? json['id'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0,
      entries: List.generate(8, (n) => NpcTextEntryEntity.fromJson(json, n)),
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{'ID': id, 'VerifiedBuild': verifiedBuild};
    for (var n = 0; n < 8; n++) {
      result.addAll(entries[n].toJson(n));
    }
    return result;
  }
}

/// npc_text 的单组数据
class NpcTextEntryEntity {
  final String lang;
  final double probability;
  final String text0;
  final String text1;
  final int broadcastTextId;
  final List<int> emotes;

  const NpcTextEntryEntity({
    this.lang = '0',
    this.probability = 0,
    this.text0 = '',
    this.text1 = '',
    this.broadcastTextId = 0,
    this.emotes = const [0, 0, 0, 0, 0, 0],
  });

  factory NpcTextEntryEntity.fromJson(Map<String, dynamic> json, int n) {
    return NpcTextEntryEntity(
      lang: json['lang$n']?.toString() ?? '0',
      probability: (json['Probability$n'] is num)
          ? (json['Probability$n'] as num).toDouble()
          : double.tryParse(json['Probability$n']?.toString() ?? '') ?? 0,
      text0: json['text${n}_0']?.toString() ?? '',
      text1: json['text${n}_1']?.toString() ?? '',
      broadcastTextId:
          json['BroadcastTextID$n'] ?? json['broadcasttextid$n'] ?? 0,
      emotes: List.generate(6, (i) => json['em${n}_$i'] ?? 0),
    );
  }

  Map<String, dynamic> toJson(int n) {
    final result = <String, dynamic>{
      'lang$n': lang,
      'Probability$n': probability,
      'text${n}_0': text0,
      'text${n}_1': text1,
      'BroadcastTextID$n': broadcastTextId,
    };
    for (var i = 0; i < 6; i++) {
      result['em${n}_$i'] = emotes[i];
    }
    return result;
  }
}
