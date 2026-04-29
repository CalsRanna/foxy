import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gem_property.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GemPropertyDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();

  /// Property
  final enchantIdController = TextEditingController();
  final maxcountInvController = TextEditingController();
  final maxcountItemController = TextEditingController();
  final typeController = TextEditingController();

  final property = signal(GemProperty());
  final saving = signal(false);

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final t = _collectFromControllers();
      final repository = GemPropertyRepository();
      if (t.id == 0) {
        await repository.storeGemProperty(t);
      } else {
        await repository.updateGemProperty(t);
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
    } finally {
      saving.value = false;
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 GemProperty
  GemProperty _collectFromControllers() {
    return GemProperty(
      id: _parseInt(idController.text),
      enchantId: _parseInt(enchantIdController.text),
      maxcountInv: _parseInt(maxcountInvController.text),
      maxcountItem: _parseInt(maxcountItemController.text),
      type: _parseInt(typeController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, GemProperty t) {
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
    idController.dispose();
    enchantIdController.dispose();
    maxcountInvController.dispose();
    maxcountItemController.dispose();
    typeController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      property.value = (await GemPropertyRepository().getGemProperty(id))!;
      _initControllers(property.value);
    } catch (e, s) {
      logger.e('加载宝石属性(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(GemProperty gemProperty) {
    idController.text = gemProperty.id.toString();
    enchantIdController.text = gemProperty.enchantId.toString();
    maxcountInvController.text = gemProperty.maxcountInv.toString();
    maxcountItemController.text = gemProperty.maxcountItem.toString();
    typeController.text = gemProperty.type.toString();
  }
}
