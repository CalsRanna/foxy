import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';
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
  final id = signal<int>(0);

  /// Property
  final enchantId = signal<int>(0);
  final maxCountInv = signal<int>(0);
  final maxCountItem = signal<int>(0);
  final type = signal<int>(0);

  final property = signal(GemPropertyEntity());
  /// 保存到数据库
  Future<void> save(BuildContext context) async {
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
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 GemProperty
  GemPropertyEntity _collectFromControllers() {
    return GemPropertyEntity(
      id: id.value,
      enchantId: enchantId.value,
      maxCountInv: maxCountInv.value,
      maxCountItem: maxCountItem.value,
      type: type.value,
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

  void dispose() {}

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      property.value = (await GemPropertyRepository().getGemProperty(id))!;
      _initControllers(property.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载宝石属性(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(GemPropertyEntity gemProperty) {
    id.value = gemProperty.id;
    enchantId.value = gemProperty.enchantId;
    maxCountInv.value = gemProperty.maxCountInv;
    maxCountItem.value = gemProperty.maxCountItem;
    type.value = gemProperty.type;
  }
}
