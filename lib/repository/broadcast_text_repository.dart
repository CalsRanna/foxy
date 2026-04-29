import 'package:foxy/entity/broadcast_text.dart';
import 'package:foxy/repository/repository_mixin.dart';

class BroadcastTextRepository with RepositoryMixin {
  static const _table = 'broadcast_text';

  Future<List<BroadcastText>> getBroadcastTexts({
    String? id,
    String? text,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'LanguageID',
      "COALESCE(NULLIF(MaleText, ''), FemaleText) as display_text",
    ]);
    if (id != null && id.isNotEmpty) {
      builder = builder.where('ID', id);
    }
    if (text != null && text.isNotEmpty) {
      builder = builder.whereAny(
        ['MaleText', 'FemaleText'],
        '%$text%',
        operator: 'like',
      );
    }
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) {
      final map = e.toMap();
      final displayText = map['display_text'] as String? ?? '';
      map['MaleText'] = displayText;
      return BroadcastText.fromJson(map);
    }).toList();
  }

  Future<int> countBroadcastTexts({String? id, String? text}) async {
    var builder = laconic.table(_table);
    if (id != null && id.isNotEmpty) {
      builder = builder.where('ID', id);
    }
    if (text != null && text.isNotEmpty) {
      builder = builder.whereAny(
        ['MaleText', 'FemaleText'],
        '%$text%',
        operator: 'like',
      );
    }
    return builder.count();
  }
}
