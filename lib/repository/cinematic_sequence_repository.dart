import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/cinematic_sequence_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'cinematic_sequence_repository.g.dart';

@FoxyRepository(CinematicSequenceEntity)
@FoxyFilter.text('id')
class CinematicSequenceRepository
    with RepositoryMixin, _CinematicSequenceRepositoryMixin {
  static const _table = 'foxy.dbc_cinematic_sequences';

  Future<int> copyCinematicSequence(int key) async {
    final source = await getCinematicSequence(key);
    if (source == null) {
      throw StateError('原过场动画序列不存在，可能已被其他操作修改或删除');
    }
    final copied = CinematicSequenceEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeCinematicSequence(copied);
    return copied.id;
  }

  Future<int> countCinematicSequences({CinematicSequenceFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<CinematicSequenceEntity> createCinematicSequence() async =>
      CinematicSequenceEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefCinematicSequenceEntity>> getBriefCinematicSequences({
    int page = 1,
    CinematicSequenceFilter? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'SoundID', 'Camera0']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefCinematicSequenceEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<CinematicSequenceEntity>> getCinematicSequences() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => CinematicSequenceEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeCinematicSequence(CinematicSequenceEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('过场动画序列 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('过场动画序列 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CinematicSequenceFilter? filter,
  ) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
