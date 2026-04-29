import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log.dart';
import 'package:foxy/entity/glyph_property.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GlyphPropertyDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();

  /// Property
  final spellIdController = TextEditingController();
  final glyphSlotFlagsController = TextEditingController();
  final spellIconIdController = TextEditingController();

  final property = signal(GlyphProperty());
  final saving = signal(false);

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final t = _collectFromControllers();
      final repository = GlyphPropertyRepository();
      if (t.id == 0) {
        await repository.storeGlyphProperty(t);
      } else {
        await repository.updateGlyphProperty(t);
      }
      property.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('雕文属性数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 GlyphProperty
  GlyphProperty _collectFromControllers() {
    return GlyphProperty(
      id: _parseInt(idController.text),
      spellId: _parseInt(spellIdController.text),
      glyphSlotFlags: _parseInt(glyphSlotFlagsController.text),
      spellIconId: _parseInt(spellIconIdController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, GlyphProperty t) {
    final log = ActivityLog(
      module: 'glyph_property',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    /// Basic
    idController.dispose();

    /// Property
    spellIdController.dispose();
    glyphSlotFlagsController.dispose();
    spellIconIdController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      property.value = (await GlyphPropertyRepository().getGlyphProperty(id))!;
      _initControllers(property.value);
    } catch (e, s) {
      logger.e('加载雕文属性(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(GlyphProperty glyphProperty) {
    /// Basic
    idController.text = glyphProperty.id.toString();

    /// Property
    spellIdController.text = glyphProperty.spellId.toString();
    glyphSlotFlagsController.text = glyphProperty.glyphSlotFlags.toString();
    spellIconIdController.text = glyphProperty.spellIconId.toString();
  }
}
