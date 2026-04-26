import 'package:foxy/model/feature.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:signals/signals.dart';

class FeatureViewModel {
  final FeatureRepository _repository = FeatureRepository();

  final allFeatures = signal<List<Feature>>([]);

  List<Feature> get pinnedFeatures =>
      allFeatures.value.where((f) => f.isPinned).toList();

  List<Feature> get favoriteFeatures =>
      allFeatures.value.where((f) => f.isFavorite).toList();

  Future<void> load() async {
    final features = await _repository.getAll();
    allFeatures.value = features;
  }

  Future<void> togglePinned(int id) async {
    final features = allFeatures.value;
    final index = features.indexWhere((f) => f.id == id);
    if (index == -1) return;

    final feature = features[index];
    final newValue = !feature.isPinned;
    await _repository.updatePinned(id, newValue);

    final updated = feature.copyWith(isPinned: newValue);
    final newList = [...features];
    newList[index] = updated;
    allFeatures.value = newList;
  }

  Future<void> toggleFavorite(int id) async {
    final features = allFeatures.value;
    final index = features.indexWhere((f) => f.id == id);
    if (index == -1) return;

    final feature = features[index];
    final newValue = !feature.isFavorite;
    await _repository.updateFavorite(id, newValue);

    final updated = feature.copyWith(isFavorite: newValue);
    final newList = [...features];
    newList[index] = updated;
    allFeatures.value = newList;
  }
}
