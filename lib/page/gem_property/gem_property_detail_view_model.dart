import 'package:flutter/widgets.dart';
import 'package:foxy/model/gem_property.dart';
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

  final table = signal(GemProperty());

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = GemPropertyRepository();
      if (t.id == 0) {
        await repository.store(t);
      } else {
        await repository.update(t);
      }
      table.value = t;
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
  GemProperty _collectFromControllers() {
    final t = GemProperty();

    t.id = _parseInt(idController.text);
    t.enchantId = _parseInt(enchantIdController.text);
    t.maxcountInv = _parseInt(maxcountInvController.text);
    t.maxcountItem = _parseInt(maxcountItemController.text);
    t.type = _parseInt(typeController.text);

    return t;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

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
      table.value = (await GemPropertyRepository().find(id))!;
      _initControllers(table.value);
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
