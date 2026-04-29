import 'package:foxy/model/feature.dart';
import 'package:foxy/repository/repository_mixin.dart';

class FeatureRepository with RepositoryMixin {
  Future<List<Feature>> getAll() async {
    final rows = await laconic
        .table('foxy.features')
        .select(['*'])
        .orderBy('sort_order')
        .get();

    return rows.map((row) => Feature.fromJson(row.toMap())).toList();
  }

  Future<void> updatePinned(int id, bool pinned) async {
    await laconic.table('foxy.features').where('id', id).update({
      'is_pinned': pinned ? 1 : 0,
    });
  }

  Future<void> updateFavorite(int id, bool favorite) async {
    await laconic.table('foxy.features').where('id', id).update({
      'is_favorite': favorite ? 1 : 0,
    });
  }
}
