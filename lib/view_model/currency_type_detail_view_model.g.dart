// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_type_detail_view_model.dart';

mixin _CurrencyTypeDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<CurrencyTypeRepository>();

  final entity = signal<CurrencyTypeEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final itemIdController = registerController(IntFieldController());
  late final categoryIdController = registerController(IntFieldController());
  late final bitIndexController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createCurrencyType();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getCurrencyType(key);
      if (result == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeCurrencyType(candidate);
      } else {
        await _repository.updateCurrencyType(originalKey, candidate);
      }
      persistedKey.value = candidate.id;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(CurrencyTypeEntity currencyType) {}

  void _applyCandidate(CurrencyTypeEntity currencyType) {
    idController.init(currencyType.id);
    itemIdController.init(currencyType.itemId);
    categoryIdController.init(currencyType.categoryId);
    bitIndexController.init(currencyType.bitIndex);
    _afterApplyCandidate(currencyType);
  }

  CurrencyTypeEntity _collectCandidate() {
    return CurrencyTypeEntity(
      id: idController.collect(),
      itemId: itemIdController.collect(),
      categoryId: categoryIdController.collect(),
      bitIndex: bitIndexController.collect(),
    );
  }

  void _logActivity(
    ActivityActionType action,
    CurrencyTypeEntity currencyType,
  ) {}
}
