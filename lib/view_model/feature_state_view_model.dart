import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
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

  void dispose() {
    allFeatures.value = const [];
    initialized.value = false;
    loading.value = false;
    errorMessage.value = null;
  }

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
      errorMessage.value = '加载功能模块失败: ${foxyErrorMessage(error)}';
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
      throw RecordNotFoundException('feature module not found: $id');
    }

    final nextValue = !features[index].isFavorite;
    errorMessage.value = null;
    try {
      await _repository.updateFavorite(id, nextValue);
      // 写回前重读最新快照:并发 toggle 时若仍基于 await 前的旧快照重建,
      // 后完成的写回会覆盖先完成者的本地翻转(UI 与 DB 不一致)。
      final latest = allFeatures.value;
      final latestIndex = latest.indexWhere((feature) => feature.id == id);
      if (latestIndex == -1) return;
      final nextFeatures = [...latest];
      nextFeatures[latestIndex] =
          latest[latestIndex].copyWith(isFavorite: nextValue);
      allFeatures.value = nextFeatures;
    } catch (error) {
      errorMessage.value = '更新收藏状态失败: ${foxyErrorMessage(error)}';
      rethrow;
    }
  }

  Future<void> togglePinned(int id) async {
    final features = allFeatures.value;
    final index = features.indexWhere((feature) => feature.id == id);
    if (index == -1) {
      throw RecordNotFoundException('feature module not found: $id');
    }

    final nextValue = !features[index].isPinned;
    errorMessage.value = null;
    try {
      await _repository.updatePinned(id, nextValue);
      // 同 toggleFavorite:写回前重读最新快照,避免并发覆盖本地翻转。
      final latest = allFeatures.value;
      final latestIndex = latest.indexWhere((feature) => feature.id == id);
      if (latestIndex == -1) return;
      final nextFeatures = [...latest];
      nextFeatures[latestIndex] =
          latest[latestIndex].copyWith(isPinned: nextValue);
      allFeatures.value = nextFeatures;
    } catch (error) {
      errorMessage.value = '更新固定状态失败: ${foxyErrorMessage(error)}';
      rethrow;
    }
  }
}
