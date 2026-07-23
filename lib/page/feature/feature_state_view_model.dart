import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class FeatureStateViewModel {
  final FeatureRepository _repository;

  final initialized = signal(false);
  final loading = signal(false);
  final errorMessage = signal<String?>(null);
  final allFeatures = signal<List<FeatureEntity>>([]);

  late final pinnedFeatures = computed(
    () => allFeatures.value.where((feature) => feature.isPinned).toList(),
  );

  late final favoriteFeatures = computed(
    () => allFeatures.value.where((feature) => feature.isFavorite).toList(),
  );

  FeatureStateViewModel({FeatureRepository? repository})
    : _repository = repository ?? GetIt.instance.get<FeatureRepository>();

  Future<void> initSignals() async {
    if (initialized.value) return;
    await refresh();
    initialized.value = true;
  }

  Future<void> refresh() async {
    if (loading.value) return;
    loading.value = true;
    errorMessage.value = null;
    try {
      allFeatures.value = await _repository.getFeatures();
    } catch (error) {
      errorMessage.value = '加载功能模块失败: $error';
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  void replaceFeatures(List<FeatureEntity> features) {
    allFeatures.value = List.unmodifiable(features);
    initialized.value = true;
    errorMessage.value = null;
  }

  Future<void> toggleFavorite(int id) async {
    final features = allFeatures.value;
    final index = features.indexWhere((feature) => feature.id == id);
    if (index == -1) {
      throw StateError('功能模块不存在: $id');
    }

    final feature = features[index];
    final nextValue = !feature.isFavorite;
    errorMessage.value = null;
    try {
      await _repository.updateFavorite(id, nextValue);
      final nextFeatures = [...features];
      nextFeatures[index] = feature.copyWith(isFavorite: nextValue);
      allFeatures.value = nextFeatures;
    } catch (error) {
      errorMessage.value = '更新收藏状态失败: $error';
      rethrow;
    }
  }

  Future<void> togglePinned(int id) async {
    final features = allFeatures.value;
    final index = features.indexWhere((feature) => feature.id == id);
    if (index == -1) {
      throw StateError('功能模块不存在: $id');
    }

    final feature = features[index];
    final nextValue = !feature.isPinned;
    errorMessage.value = null;
    try {
      await _repository.updatePinned(id, nextValue);
      final nextFeatures = [...features];
      nextFeatures[index] = feature.copyWith(isPinned: nextValue);
      allFeatures.value = nextFeatures;
    } catch (error) {
      errorMessage.value = '更新固定状态失败: $error';
      rethrow;
    }
  }

  void dispose() {
    allFeatures.value = const [];
    initialized.value = false;
    loading.value = false;
    errorMessage.value = null;
  }
}
