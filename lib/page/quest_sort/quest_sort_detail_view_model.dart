import 'package:flutter/widgets.dart';
import 'package:foxy/model/quest_sort.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestSortDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final idController = TextEditingController();
  final nameController = TextEditingController();

  final table = signal(QuestSort());

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = QuestSortRepository();
      if (t.id == 0) {
        await repository.store(t);
      } else {
        await repository.update(t);
      }
      table.value = t;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('任务排序数据已保存'));
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

  /// 从所有 Controller 收集数据构建 QuestSort
  QuestSort _collectFromControllers() {
    final t = QuestSort();
    t.id = _parseInt(idController.text);
    t.sortNameLangZhCn = nameController.text;
    return t;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

  void dispose() {
    idController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      table.value = (await QuestSortRepository().find(id))!;
      _initControllers(table.value);
    } catch (e, s) {
      logger.e('加载任务排序(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestSort table) {
    idController.text = table.id.toString();
    nameController.text = table.sortNameLangZhCn;
  }
}
