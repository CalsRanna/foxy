import 'package:foxy/model/feature.dart';
import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

class FeatureRepository {
  Laconic get _laconic => GetIt.instance.get<FoxyViewModel>().laconic!;

  Future<List<Feature>> getAll() async {
    final rows = await _laconic
        .table('foxy.features')
        .select(['*'])
        .orderBy('sort_order')
        .get();

    return rows.map((row) => Feature.fromJson(row.toMap())).toList();
  }

  Future<void> updatePinned(int id, bool pinned) async {
    await _laconic
        .table('foxy.features')
        .where('id', id)
        .update({'is_pinned': pinned ? 1 : 0});
  }

  Future<void> updateFavorite(int id, bool favorite) async {
    await _laconic
        .table('foxy.features')
        .where('id', id)
        .update({'is_favorite': favorite ? 1 : 0});
  }
}
