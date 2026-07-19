import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/entity/glyph_property_key.dart';
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
  final persistedKey = signal<GlyphPropertyKey?>(null);

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({GlyphPropertyKey? key}) async {
    try {
      if (key == null) {
        persistedKey.value = null;
        final blank = await _repository.createGlyphProperty();
        property.value = blank;
        _initControllers(blank);
        return;
      }
      persistedKey.value = key;
      final entity = await _repository.getGlyphProperty(key);
      if (entity == null) {
        throw StateError('原雕文属性不存在，可能已被其他操作修改或删除');
      }
      property.value = entity;
      _initControllers(entity);
    } catch (e, s) {
      LoggerUtil.instance.e('加载雕文属性(key=$key)失败', error: e, stackTrace: s);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  Future<void> persist() async {
    final candidate = _collectFromControllers();
    validateGlyphPropertyFields(candidate);
    final originalKey = persistedKey.value;
    final action = originalKey == null
        ? ActivityActionType.create
        : ActivityActionType.update;
    if (originalKey == null) {
      await _repository.storeGlyphProperty(candidate);
    } else {
      await _repository.updateGlyphProperty(originalKey, candidate);
    }
    persistedKey.value = GlyphPropertyKey.fromEntity(candidate);
    property.value = candidate;
    routerFacade.updateCurrentLabel('雕文属性 #${candidate.id}');
    _logActivity(action, candidate);
  }

  Future<void> save(BuildContext context) async {
    try {
      await persist();
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
      entityName: 'GlyphProperty ${t.id}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
