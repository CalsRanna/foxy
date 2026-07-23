import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/item_extended_cost_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ItemExtendedCostDetailViewModel
    with
        ViewModelValidationMixin,
        ItemExtendedCostValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<ItemExtendedCostRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<ItemExtendedCostEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Basic
  late final idController = registerController(IntFieldController());
  late final honorPointsController = registerController(IntFieldController());
  late final arenaPointsController = registerController(IntFieldController());
  late final arenaBracketController = registerController(IntFieldController());
  late final requiredArenaRatingController = registerController(
    IntFieldController(),
  );
  late final itemPurchaseGroupController = registerController(
    IntFieldController(),
  );

  /// ItemID
  late final itemID0Controller = registerController(IntFieldController());
  late final itemID1Controller = registerController(IntFieldController());
  late final itemID2Controller = registerController(IntFieldController());
  late final itemID3Controller = registerController(IntFieldController());
  late final itemID4Controller = registerController(IntFieldController());

  /// ItemCount
  late final itemCount0Controller = registerController(IntFieldController());
  late final itemCount1Controller = registerController(IntFieldController());
  late final itemCount2Controller = registerController(IntFieldController());
  late final itemCount3Controller = registerController(IntFieldController());
  late final itemCount4Controller = registerController(IntFieldController());

  /// 从所有 Controller 收集数据构建 ItemExtendedCost

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
        throw StateError('原扩展价格不存在，可能已被其他操作修改或删除');
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

  /// 退出页面
  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      validateItemExtendedCostFields(candidate);
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
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  ItemExtendedCostEntity _collectCandidate() {
    return ItemExtendedCostEntity(
      id: idController.collect(),
      honorPoints: honorPointsController.collect(),
      arenaPoints: arenaPointsController.collect(),
      arenaBracket: arenaBracketController.collect(),
      requiredArenaRating: requiredArenaRatingController.collect(),
      itemPurchaseGroup: itemPurchaseGroupController.collect(),
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
    );
  }

  void _applyCandidate(ItemExtendedCostEntity table) {
    idController.init(table.id);
    honorPointsController.init(table.honorPoints);
    arenaPointsController.init(table.arenaPoints);
    arenaBracketController.init(table.arenaBracket);
    requiredArenaRatingController.init(table.requiredArenaRating);
    itemPurchaseGroupController.init(table.itemPurchaseGroup);
    itemID0Controller.init(table.itemID0);
    itemID1Controller.init(table.itemID1);
    itemID2Controller.init(table.itemID2);
    itemID3Controller.init(table.itemID3);
    itemID4Controller.init(table.itemID4);
    itemCount0Controller.init(table.itemCount0);
    itemCount1Controller.init(table.itemCount1);
    itemCount2Controller.init(table.itemCount2);
    itemCount3Controller.init(table.itemCount3);
    itemCount4Controller.init(table.itemCount4);
  }

  void _logActivity(ActivityActionType action, ItemExtendedCostEntity t) {
    final log = ActivityLogEntity(
      module: 'item_extended_cost',
      actionType: action,
      entityName: 'ItemExtendedCost ${t.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
