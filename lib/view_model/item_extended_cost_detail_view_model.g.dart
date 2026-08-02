// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_extended_cost_detail_view_model.dart';

mixin _ItemExtendedCostDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<ItemExtendedCostRepository>();

  final entity = signal<ItemExtendedCostEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final honorPointsController = registerController(IntFieldController());
  late final arenaPointsController = registerController(IntFieldController());
  late final arenaBracketController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final itemID0Controller = registerController(IntFieldController());
  late final itemID1Controller = registerController(IntFieldController());
  late final itemID2Controller = registerController(IntFieldController());
  late final itemID3Controller = registerController(IntFieldController());
  late final itemID4Controller = registerController(IntFieldController());
  late final itemCount0Controller = registerController(IntFieldController());
  late final itemCount1Controller = registerController(IntFieldController());
  late final itemCount2Controller = registerController(IntFieldController());
  late final itemCount3Controller = registerController(IntFieldController());
  late final itemCount4Controller = registerController(IntFieldController());
  late final requiredArenaRatingController = registerController(
    IntFieldController(),
  );
  late final itemPurchaseGroupController = registerController(
    IntFieldController(),
  );

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createItemExtendedCost();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getItemExtendedCost(key);
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
        await _repository.storeItemExtendedCost(candidate);
      } else {
        await _repository.updateItemExtendedCost(originalKey, candidate);
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

  void _afterApplyCandidate(ItemExtendedCostEntity itemExtendedCost) {}

  void _applyCandidate(ItemExtendedCostEntity itemExtendedCost) {
    idController.init(itemExtendedCost.id);
    honorPointsController.init(itemExtendedCost.honorPoints);
    arenaPointsController.init(itemExtendedCost.arenaPoints);
    arenaBracketController.init(itemExtendedCost.arenaBracket);
    itemID0Controller.init(itemExtendedCost.itemID0);
    itemID1Controller.init(itemExtendedCost.itemID1);
    itemID2Controller.init(itemExtendedCost.itemID2);
    itemID3Controller.init(itemExtendedCost.itemID3);
    itemID4Controller.init(itemExtendedCost.itemID4);
    itemCount0Controller.init(itemExtendedCost.itemCount0);
    itemCount1Controller.init(itemExtendedCost.itemCount1);
    itemCount2Controller.init(itemExtendedCost.itemCount2);
    itemCount3Controller.init(itemExtendedCost.itemCount3);
    itemCount4Controller.init(itemExtendedCost.itemCount4);
    requiredArenaRatingController.init(itemExtendedCost.requiredArenaRating);
    itemPurchaseGroupController.init(itemExtendedCost.itemPurchaseGroup);
    _afterApplyCandidate(itemExtendedCost);
  }

  ItemExtendedCostEntity _collectCandidate() {
    return ItemExtendedCostEntity(
      id: idController.collect(),
      honorPoints: honorPointsController.collect(),
      arenaPoints: arenaPointsController.collect(),
      arenaBracket: arenaBracketController.collect(),
      itemID0: itemID0Controller.collect(),
      itemID1: itemID1Controller.collect(),
      itemID2: itemID2Controller.collect(),
      itemID3: itemID3Controller.collect(),
      itemID4: itemID4Controller.collect(),
      itemCount0: itemCount0Controller.collect(),
      itemCount1: itemCount1Controller.collect(),
      itemCount2: itemCount2Controller.collect(),
      itemCount3: itemCount3Controller.collect(),
      itemCount4: itemCount4Controller.collect(),
      requiredArenaRating: requiredArenaRatingController.collect(),
      itemPurchaseGroup: itemPurchaseGroupController.collect(),
    );
  }

  void _logActivity(
    ActivityActionType action,
    ItemExtendedCostEntity itemExtendedCost,
  ) {}
}
