import 'dart:async';

import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:signals/signals.dart';

class MoreReadViewModel with FieldControllerMixin {
  final filteredModules = signal<List<FeatureEntity>>([]);
  final loading = signal(false);
  final errorMessage = signal<String?>(null);

  late final searchController = registerController(StringFieldController());

  List<FeatureEntity> _source = const [];
  int _refreshToken = 0;

  Future<void> initSignals() async {
    searchController.addListener(search);
    await _refresh();
  }

  void setFeatures(List<FeatureEntity> features) {
    _source = List.unmodifiable(features);
    unawaited(_refresh());
  }

  void reset() {
    searchController.init('');
    unawaited(_refresh());
  }

  void search() {
    unawaited(_refresh());
  }

  Future<void> refresh() => _refresh();

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    final query = searchController.collect().trim().toLowerCase();
    try {
      final result = query.isEmpty
          ? List.of(_source)
          : _source
                .where((module) => module.name.toLowerCase().contains(query))
                .toList();
      if (token != _refreshToken) return;
      filteredModules.value = result;
    } catch (error) {
      if (token == _refreshToken) errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() {
    _refreshToken++;
    disposeControllers();
  }
}
