import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/glyph_property_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GlyphPropertyDetailViewModel
    with
        ViewModelValidationMixin,
        GlyphPropertyValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<GlyphPropertyRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  late final idController = registerController(IntFieldController());

  /// Property
  late final spellIdController = registerController(IntFieldController());
  late final glyphSlotFlagsController = registerController(
    IntFieldController(),
  );
  late final spellIconIdController = registerController(IntFieldController());

  final property = signal(GlyphPropertyEntity());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createGlyphProperty();
        property.value = blank;
        _initControllers(blank);
        return;
      }
      property.value = (await _repository.getGlyphProperty(id))!;
      _initControllers(property.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载雕文属性(id=$id)失败', error: e, stackTrace: s);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      validateGlyphPropertyFields(t);
      final isCreate = (await _repository.getGlyphProperty(t.id)) == null;
      if (isCreate) {
        final id = await _repository.storeGlyphProperty(t);
        t = t.copyWith(id: id);
        idController.init(id);
      } else {
        await _repository.updateGlyphProperty(t);
      }
      property.value = t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('雕文属性数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 从所有 Controller 收集数据构建 GlyphProperty
  GlyphPropertyEntity _collectFromControllers() {
    return GlyphPropertyEntity(
      id: idController.collect(),
      spellId: spellIdController.collect(),
      glyphSlotFlags: glyphSlotFlagsController.collect(),
      spellIconId: spellIconIdController.collect(),
    );
  }

  void _initControllers(GlyphPropertyEntity glyphProperty) {
    /// Basic
    idController.init(glyphProperty.id);

    /// Property
    spellIdController.init(glyphProperty.spellId);
    glyphSlotFlagsController.init(glyphProperty.glyphSlotFlags);
    spellIconIdController.init(glyphProperty.spellIconId);
  }

  void _logActivity(ActivityActionType action, GlyphPropertyEntity t) {
    final log = ActivityLogEntity(
      module: 'glyph_property',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
