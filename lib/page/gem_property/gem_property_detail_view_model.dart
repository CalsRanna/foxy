import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GemPropertyDetailViewModel {
  final _repository = GetIt.instance.get<GemPropertyRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();

  /// Property
  final enchantIdController = TextEditingController();
  final maxCountInvController = TextEditingController();
  final maxCountItemController = TextEditingController();
  final typeController = TextEditingController();

  final property = signal(GemPropertyEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        final id = await _repository.storeGemProperty(t);
        idController.text = '$id';
      } else {
        await _repository.updateGemProperty(t);
      }
      property.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
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
      id: _pi(idController.text),
      enchantId: _pi(enchantIdController.text),
      maxCountInv: _pi(maxCountInvController.text),
      maxCountItem: _pi(maxCountItemController.text),
      type: _pi(typeController.text),
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    enchantIdController.dispose();
    idController.dispose();
    maxCountInvController.dispose();
    maxCountItemController.dispose();
    typeController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      property.value = (await _repository.getGemProperty(id))!;
      _initControllers(property.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载宝石属性(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(GemPropertyEntity gemProperty) {
    idController.text = _fmt(gemProperty.id);
    enchantIdController.text = _fmt(gemProperty.enchantId);
    maxCountInvController.text = _fmt(gemProperty.maxCountInv);
    maxCountItemController.text = _fmt(gemProperty.maxCountItem);
    typeController.text = _fmt(gemProperty.type);
  }
}
