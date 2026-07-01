import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GlyphPropertyDetailViewModel {
  final _repository = GetIt.instance.get<GlyphPropertyRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();

  /// Property
  final spellIdController = TextEditingController();
  final glyphSlotFlagsController = TextEditingController();
  final spellIconIdController = TextEditingController();

  final property = signal(GlyphPropertyEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        await _repository.storeGlyphProperty(t);
      } else {
        await _repository.updateGlyphProperty(t);
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
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 GlyphProperty
  GlyphPropertyEntity _collectFromControllers() {
    return GlyphPropertyEntity(
      id: _pi(idController.text),
      spellId: _pi(spellIdController.text),
      glyphSlotFlags: _pi(glyphSlotFlagsController.text),
      spellIconId: _pi(spellIconIdController.text),
    );
  }

  void _logActivity(ActivityActionType action, GlyphPropertyEntity t) {
    final log = ActivityLogEntity(
      module: 'glyph_property',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    glyphSlotFlagsController.dispose();
    idController.dispose();
    spellIconIdController.dispose();
    spellIdController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      property.value = (await _repository.getGlyphProperty(id))!;
      _initControllers(property.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载雕文属性(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(GlyphPropertyEntity glyphProperty) {
    /// Basic
    idController.text = _fmt(glyphProperty.id);

    /// Property
    spellIdController.text = _fmt(glyphProperty.spellId);
    glyphSlotFlagsController.text = _fmt(glyphProperty.glyphSlotFlags);
    spellIconIdController.text = _fmt(glyphProperty.spellIconId);
  }
}
