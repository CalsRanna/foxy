import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/gem_property_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GemPropertyDetailViewModel
    with
        ViewModelValidationMixin,
        GemPropertyValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<GemPropertyRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  late final idController = registerController(IntFieldController());

  /// Property
  late final enchantIdController = registerController(IntFieldController());
  late final maxCountInvController = registerController(IntFieldController());
  late final maxCountItemController = registerController(IntFieldController());
  late final typeController = registerController(IntFieldController());

  final property = signal(GemPropertyEntity());
  final persistedKey = signal<int?>(null);

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    try {
      if (key == null) {
        persistedKey.value = null;
        final blank = await _repository.createGemProperty();
        property.value = blank;
        _initControllers(blank);
        return;
      }
      persistedKey.value = key;
      final entity = await _repository.getGemProperty(key);
      if (entity == null) {
        throw StateError('原宝石属性不存在，可能已被其他操作修改或删除');
      }
      property.value = entity;
      _initControllers(entity);
    } catch (e, s) {
      LoggerUtil.instance.e('加载宝石属性(key=$key)失败', error: e, stackTrace: s);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  Future<void> persist() async {
    final candidate = _collectFromControllers();
    validateGemPropertyFields(candidate);
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
    property.value = candidate;
    routerFacade.updateCurrentLabel('宝石属性 #${candidate.id}');
    _logActivity(action, candidate);
  }

  Future<void> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('宝石属性数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 从所有 Controller 收集数据构建 GemProperty
  GemPropertyEntity _collectFromControllers() {
    return GemPropertyEntity(
      id: idController.collect(),
      enchantId: enchantIdController.collect(),
      maxCountInv: maxCountInvController.collect(),
      maxCountItem: maxCountItemController.collect(),
      type: typeController.collect(),
    );
  }

  void _initControllers(GemPropertyEntity gemProperty) {
    idController.init(gemProperty.id);
    enchantIdController.init(gemProperty.enchantId);
    maxCountInvController.init(gemProperty.maxCountInv);
    maxCountItemController.init(gemProperty.maxCountItem);
    typeController.init(gemProperty.type);
  }

  void _logActivity(ActivityActionType action, GemPropertyEntity t) {
    final log = ActivityLogEntity(
      module: 'gem_property',
      actionType: action,
      entityName: 'GemProperty ${t.id}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
