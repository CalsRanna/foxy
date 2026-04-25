/// npc_text 主表模型（单主键: ID）
///
/// 每行包含 8 组（index 0..7）独立的文本数据，
/// 每组包含: lang{n} / Probability{n} / text{n}_0 / text{n}_1
///          / BroadcastTextID{n} / em{n}_0..5
class NpcText {
  int id = 0;
  int verifiedBuild = 0;

  /// 8 组数据，index 0..7
  final List<NpcTextEntry> entries = List.generate(8, (_) => NpcTextEntry());

  NpcText();

  NpcText.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    verifiedBuild = json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0;
    for (var n = 0; n < 8; n++) {
      entries[n] = NpcTextEntry.fromJson(json, n);
    }
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'VerifiedBuild': verifiedBuild,
    };
    for (var n = 0; n < 8; n++) {
      result.addAll(entries[n].toJson(n));
    }
    return result;
  }
}

/// npc_text 的单组数据
class NpcTextEntry {
  String lang = '0';
  double probability = 0;
  String text0 = '';
  String text1 = '';
  int broadcastTextId = 0;
  List<int> emotes = List.filled(6, 0);

  NpcTextEntry();

  NpcTextEntry.fromJson(Map<String, dynamic> json, int n) {
    lang = json['lang$n']?.toString() ?? '0';
    probability = (json['Probability$n'] is num)
        ? (json['Probability$n'] as num).toDouble()
        : double.tryParse(json['Probability$n']?.toString() ?? '') ?? 0;
    text0 = json['text${n}_0']?.toString() ?? '';
    text1 = json['text${n}_1']?.toString() ?? '';
    broadcastTextId =
        json['BroadcastTextID$n'] ?? json['broadcasttextid$n'] ?? 0;
    for (var i = 0; i < 6; i++) {
      emotes[i] = json['em${n}_$i'] ?? 0;
    }
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
