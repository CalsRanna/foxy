// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_property_detail_view_model.dart';

mixin _GemPropertyDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<GemPropertyRepository>();

  final entity = signal<GemPropertyEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final enchantIdController = registerController(IntFieldController());
  late final maxCountInvController = registerController(IntFieldController());
  late final maxCountItemController = registerController(IntFieldController());
  late final typeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createGemProperty();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getGemProperty(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeGemProperty(candidate);
      } else {
        await _repository.updateGemProperty(originalKey, candidate);
      }
      persistedKey.value = candidate.id;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(GemPropertyEntity gemProperty) {}

  void _applyCandidate(GemPropertyEntity gemProperty) {
    idController.init(gemProperty.id);
    enchantIdController.init(gemProperty.enchantId);
    maxCountInvController.init(gemProperty.maxCountInv);
    maxCountItemController.init(gemProperty.maxCountItem);
    typeController.init(gemProperty.type);
    _afterApplyCandidate(gemProperty);
  }

  GemPropertyEntity _collectCandidate() {
    return GemPropertyEntity(
      id: idController.collect(),
      enchantId: enchantIdController.collect(),
      maxCountInv: maxCountInvController.collect(),
      maxCountItem: maxCountItemController.collect(),
      type: typeController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, GemPropertyEntity gemProperty) {}
}
