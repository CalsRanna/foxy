// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_set_detail_view_model.dart';

mixin _ItemSetDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<ItemSetRepository>();

  final entity = signal<ItemSetEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final nameLangEnUSController = registerController(
    StringFieldController(),
  );
  late final nameLangKoKRController = registerController(
    StringFieldController(),
  );
  late final nameLangFrFRController = registerController(
    StringFieldController(),
  );
  late final nameLangDeDEController = registerController(
    StringFieldController(),
  );
  late final nameLangZhCNController = registerController(
    StringFieldController(),
  );
  late final nameLangZhTWController = registerController(
    StringFieldController(),
  );
  late final nameLangEsESController = registerController(
    StringFieldController(),
  );
  late final nameLangEsMXController = registerController(
    StringFieldController(),
  );
  late final nameLangRuRUController = registerController(
    StringFieldController(),
  );
  late final nameLangJaJPController = registerController(
    StringFieldController(),
  );
  late final nameLangPtPTController = registerController(
    StringFieldController(),
  );
  late final nameLangPtBRController = registerController(
    StringFieldController(),
  );
  late final nameLangItITController = registerController(
    StringFieldController(),
  );
  late final nameLangUnk1Controller = registerController(
    StringFieldController(),
  );
  late final nameLangUnk2Controller = registerController(
    StringFieldController(),
  );
  late final nameLangUnk3Controller = registerController(
    StringFieldController(),
  );
  late final nameLangFlagsController = registerController(IntFieldController());
  late final itemId0Controller = registerController(IntFieldController());
  late final itemId1Controller = registerController(IntFieldController());
  late final itemId2Controller = registerController(IntFieldController());
  late final itemId3Controller = registerController(IntFieldController());
  late final itemId4Controller = registerController(IntFieldController());
  late final itemId5Controller = registerController(IntFieldController());
  late final itemId6Controller = registerController(IntFieldController());
  late final itemId7Controller = registerController(IntFieldController());
  late final itemId8Controller = registerController(IntFieldController());
  late final itemId9Controller = registerController(IntFieldController());
  late final itemId10Controller = registerController(IntFieldController());
  late final itemId11Controller = registerController(IntFieldController());
  late final itemId12Controller = registerController(IntFieldController());
  late final itemId13Controller = registerController(IntFieldController());
  late final itemId14Controller = registerController(IntFieldController());
  late final itemId15Controller = registerController(IntFieldController());
  late final itemId16Controller = registerController(IntFieldController());
  late final setSpellId0Controller = registerController(IntFieldController());
  late final setSpellId1Controller = registerController(IntFieldController());
  late final setSpellId2Controller = registerController(IntFieldController());
  late final setSpellId3Controller = registerController(IntFieldController());
  late final setSpellId4Controller = registerController(IntFieldController());
  late final setSpellId5Controller = registerController(IntFieldController());
  late final setSpellId6Controller = registerController(IntFieldController());
  late final setSpellId7Controller = registerController(IntFieldController());
  late final setThreshold0Controller = registerController(IntFieldController());
  late final setThreshold1Controller = registerController(IntFieldController());
  late final setThreshold2Controller = registerController(IntFieldController());
  late final setThreshold3Controller = registerController(IntFieldController());
  late final setThreshold4Controller = registerController(IntFieldController());
  late final setThreshold5Controller = registerController(IntFieldController());
  late final setThreshold6Controller = registerController(IntFieldController());
  late final setThreshold7Controller = registerController(IntFieldController());
  late final requiredSkillController = registerController(IntFieldController());
  late final requiredSkillRankController = registerController(
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
        final blank = await _repository.createItemSet();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getItemSet(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = FoxyError.message(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        final storedKey = await _repository.storeItemSet(candidate);
        persistedKey.value = storedKey;
      } else {
        await _repository.updateItemSet(originalKey, candidate);
        persistedKey.value = candidate.id;
      }
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(ItemSetEntity itemSet) {}

  void _applyCandidate(ItemSetEntity itemSet) {
    idController.init(itemSet.id);
    nameLangEnUSController.init(itemSet.nameLangEnUS);
    nameLangKoKRController.init(itemSet.nameLangKoKR);
    nameLangFrFRController.init(itemSet.nameLangFrFR);
    nameLangDeDEController.init(itemSet.nameLangDeDE);
    nameLangZhCNController.init(itemSet.nameLangZhCN);
    nameLangZhTWController.init(itemSet.nameLangZhTW);
    nameLangEsESController.init(itemSet.nameLangEsES);
    nameLangEsMXController.init(itemSet.nameLangEsMX);
    nameLangRuRUController.init(itemSet.nameLangRuRU);
    nameLangJaJPController.init(itemSet.nameLangJaJP);
    nameLangPtPTController.init(itemSet.nameLangPtPT);
    nameLangPtBRController.init(itemSet.nameLangPtBR);
    nameLangItITController.init(itemSet.nameLangItIT);
    nameLangUnk1Controller.init(itemSet.nameLangUnk1);
    nameLangUnk2Controller.init(itemSet.nameLangUnk2);
    nameLangUnk3Controller.init(itemSet.nameLangUnk3);
    nameLangFlagsController.init(itemSet.nameLangFlags);
    itemId0Controller.init(itemSet.itemId0);
    itemId1Controller.init(itemSet.itemId1);
    itemId2Controller.init(itemSet.itemId2);
    itemId3Controller.init(itemSet.itemId3);
    itemId4Controller.init(itemSet.itemId4);
    itemId5Controller.init(itemSet.itemId5);
    itemId6Controller.init(itemSet.itemId6);
    itemId7Controller.init(itemSet.itemId7);
    itemId8Controller.init(itemSet.itemId8);
    itemId9Controller.init(itemSet.itemId9);
    itemId10Controller.init(itemSet.itemId10);
    itemId11Controller.init(itemSet.itemId11);
    itemId12Controller.init(itemSet.itemId12);
    itemId13Controller.init(itemSet.itemId13);
    itemId14Controller.init(itemSet.itemId14);
    itemId15Controller.init(itemSet.itemId15);
    itemId16Controller.init(itemSet.itemId16);
    setSpellId0Controller.init(itemSet.setSpellId0);
    setSpellId1Controller.init(itemSet.setSpellId1);
    setSpellId2Controller.init(itemSet.setSpellId2);
    setSpellId3Controller.init(itemSet.setSpellId3);
    setSpellId4Controller.init(itemSet.setSpellId4);
    setSpellId5Controller.init(itemSet.setSpellId5);
    setSpellId6Controller.init(itemSet.setSpellId6);
    setSpellId7Controller.init(itemSet.setSpellId7);
    setThreshold0Controller.init(itemSet.setThreshold0);
    setThreshold1Controller.init(itemSet.setThreshold1);
    setThreshold2Controller.init(itemSet.setThreshold2);
    setThreshold3Controller.init(itemSet.setThreshold3);
    setThreshold4Controller.init(itemSet.setThreshold4);
    setThreshold5Controller.init(itemSet.setThreshold5);
    setThreshold6Controller.init(itemSet.setThreshold6);
    setThreshold7Controller.init(itemSet.setThreshold7);
    requiredSkillController.init(itemSet.requiredSkill);
    requiredSkillRankController.init(itemSet.requiredSkillRank);
    _afterApplyCandidate(itemSet);
  }

  ItemSetEntity _collectCandidate() {
    return ItemSetEntity(
      id: idController.collect(),
      nameLangEnUS: nameLangEnUSController.collect(),
      nameLangKoKR: nameLangKoKRController.collect(),
      nameLangFrFR: nameLangFrFRController.collect(),
      nameLangDeDE: nameLangDeDEController.collect(),
      nameLangZhCN: nameLangZhCNController.collect(),
      nameLangZhTW: nameLangZhTWController.collect(),
      nameLangEsES: nameLangEsESController.collect(),
      nameLangEsMX: nameLangEsMXController.collect(),
      nameLangRuRU: nameLangRuRUController.collect(),
      nameLangJaJP: nameLangJaJPController.collect(),
      nameLangPtPT: nameLangPtPTController.collect(),
      nameLangPtBR: nameLangPtBRController.collect(),
      nameLangItIT: nameLangItITController.collect(),
      nameLangUnk1: nameLangUnk1Controller.collect(),
      nameLangUnk2: nameLangUnk2Controller.collect(),
      nameLangUnk3: nameLangUnk3Controller.collect(),
      nameLangFlags: nameLangFlagsController.collect(),
      itemId0: itemId0Controller.collect(),
      itemId1: itemId1Controller.collect(),
      itemId2: itemId2Controller.collect(),
      itemId3: itemId3Controller.collect(),
      itemId4: itemId4Controller.collect(),
      itemId5: itemId5Controller.collect(),
      itemId6: itemId6Controller.collect(),
      itemId7: itemId7Controller.collect(),
      itemId8: itemId8Controller.collect(),
      itemId9: itemId9Controller.collect(),
      itemId10: itemId10Controller.collect(),
      itemId11: itemId11Controller.collect(),
      itemId12: itemId12Controller.collect(),
      itemId13: itemId13Controller.collect(),
      itemId14: itemId14Controller.collect(),
      itemId15: itemId15Controller.collect(),
      itemId16: itemId16Controller.collect(),
      setSpellId0: setSpellId0Controller.collect(),
      setSpellId1: setSpellId1Controller.collect(),
      setSpellId2: setSpellId2Controller.collect(),
      setSpellId3: setSpellId3Controller.collect(),
      setSpellId4: setSpellId4Controller.collect(),
      setSpellId5: setSpellId5Controller.collect(),
      setSpellId6: setSpellId6Controller.collect(),
      setSpellId7: setSpellId7Controller.collect(),
      setThreshold0: setThreshold0Controller.collect(),
      setThreshold1: setThreshold1Controller.collect(),
      setThreshold2: setThreshold2Controller.collect(),
      setThreshold3: setThreshold3Controller.collect(),
      setThreshold4: setThreshold4Controller.collect(),
      setThreshold5: setThreshold5Controller.collect(),
      setThreshold6: setThreshold6Controller.collect(),
      setThreshold7: setThreshold7Controller.collect(),
      requiredSkill: requiredSkillController.collect(),
      requiredSkillRank: requiredSkillRankController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(ActivityActionType action, ItemSetEntity itemSet) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_item_set',
          actionType: action,
          entityName: 'ItemSet ${itemSet.id}',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
