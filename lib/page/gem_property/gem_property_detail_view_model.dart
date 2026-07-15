import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/gem_property_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
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

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      validateGemPropertyFields(t);
      final isCreate = (await _repository.getGemProperty(t.id)) == null;
      if (isCreate) {
        final id = await _repository.storeGemProperty(t);
        t = t.copyWith(id: id);
        idController.init(id);
      } else {
        await _repository.updateGemProperty(t);
      }
      property.value = t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('宝石属性数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
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

  void _logActivity(ActivityActionType action, GemPropertyEntity t) {
    final log = ActivityLogEntity(
      module: 'gem_property',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createGemProperty();
        property.value = blank;
        _initControllers(blank);
        return;
      }
      property.value = (await _repository.getGemProperty(id))!;
      _initControllers(property.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载宝石属性(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(GemPropertyEntity gemProperty) {
    idController.init(gemProperty.id);
    enchantIdController.init(gemProperty.enchantId);
    maxCountInvController.init(gemProperty.maxCountInv);
    maxCountItemController.init(gemProperty.maxCountItem);
    typeController.init(gemProperty.type);
  }
}
