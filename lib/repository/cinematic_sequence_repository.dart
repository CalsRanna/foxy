import 'package:foxy/entity/cinematic_sequence_entity.dart';
import 'package:foxy/entity/cinematic_sequence_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CinematicSequenceRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_cinematic_sequences';

  Future<void> copyCinematicSequence(int id) async {
    final source = await getCinematicSequence(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await nextMaxPlusOne(_table, 'ID');
    await laconic.table(_table).insert([json]);
  }

  Future<int> countCinematicSequences({
    CinematicSequenceFilterEntity? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<CinematicSequenceEntity> createCinematicSequence() async =>
      CinematicSequenceEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyCinematicSequence(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefCinematicSequenceEntity>> getBriefCinematicSequences({
    int page = 1,
    CinematicSequenceFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'SoundID', 'Camera0']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefCinematicSequenceEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<CinematicSequenceEntity?> getCinematicSequence(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty
        ? null
        : CinematicSequenceEntity.fromJson(rows.first.toMap());
  }

  Future<List<CinematicSequenceEntity>> getCinematicSequences() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => CinematicSequenceEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> saveCinematicSequence(CinematicSequenceEntity entity) async {
    if (await getCinematicSequence(entity.id) == null) {
      await storeCinematicSequence(entity);
    } else {
      await updateCinematicSequence(entity);
    }
  }

  Future<int> storeCinematicSequence(CinematicSequenceEntity entity) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateCinematicSequence(CinematicSequenceEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CinematicSequenceFilterEntity? filter,
  ) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
