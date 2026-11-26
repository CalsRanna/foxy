import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/repository/spell_rank_repository.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  late SpellRankRepository repository;

  setUp(() {
    repository = _Repository(Laconic(_RankDriver()));
  });

  test('链首和后级法术的计数与列表都读取同一排行链', () async {
    for (final spellId in [133, 116]) {
      final count = await repository.countSpellRanks(spellId);
      final rows = await repository.getBriefSpellRanks(spellId);

      expect(count, 2);
      expect(rows, hasLength(count));
      expect(rows.map((row) => row.spellId), [133, 116]);
      expect(rows.map((row) => row.firstSpellId), [133, 133]);
    }
  });

  test('从后级法术新增时预填现有链首和下一级排行', () async {
    final candidate = await repository.createSpellRank(116);

    expect(candidate.firstSpellId, 133);
    expect(candidate.rank, 3);
  });

  test('未入链法术没有排行记录，新增从第一级开始', () async {
    expect(await repository.countSpellRanks(999), 0);
    expect(await repository.getBriefSpellRanks(999), isEmpty);

    final candidate = await repository.createSpellRank(999);

    expect(candidate.firstSpellId, 999);
    expect(candidate.rank, 1);
  });
}

class _Repository extends SpellRankRepository {
  @override
  final Laconic laconic;

  _Repository(this.laconic);
}

class _RankDriver extends Fake implements DatabaseDriver {
  static const _rows = [
    {'first_spell_id': 133, 'spell_id': 133, 'rank': 1},
    {'first_spell_id': 133, 'spell_id': 116, 'rank': 2},
  ];

  @override
  final SqlGrammar grammar = MysqlGrammar();

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    final column = RegExp(
      r'\bwhere\s+(?:sr\.)?`?(first_spell_id|spell_id)`?\s*=\s*\?',
      caseSensitive: false,
    ).firstMatch(sql)?.group(1);
    expect(column, isNotNull, reason: sql);
    final rows = _rows.where((row) => row[column] == params.first).toList();
    final query = sql.toLowerCase();
    if (query.contains('count(')) {
      return [
        LaconicResult.fromMap({'aggregate': rows.length}),
      ];
    }
    if (query.contains('max(')) {
      return [
        LaconicResult.fromMap({
          'max_id': rows.isEmpty ? null : rows.last['rank'],
        }),
      ];
    }
    return rows.map(LaconicResult.fromMap).toList();
  }
}
