import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestSortDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final id = signal<int>(0);
  final nameController = TextEditingController();

  final sort = signal(QuestSortEntity());
  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = QuestSortRepository();
      if (t.id == 0) {
        await repository.storeQuestSort(t);
      } else {
        await repository.updateQuestSort(t);
      }
      sort.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
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
  QuestSortEntity _collectFromControllers() {
    return QuestSortEntity(
      id: id.value,
      sortNameLangZhCn: nameController.text,
    );
  }

  void _logActivity(ActivityActionType action, QuestSortEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_sort',
      actionType: action,
      entityId: t.id,
      entityName: t.sortNameLangZhCn,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    nameController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      sort.value = (await QuestSortRepository().getQuestSort(id))!;
      _initControllers(sort.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载任务排序(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestSortEntity table) {
    id.value = table.id;
    nameController.text = table.sortNameLangZhCn;
  }
}
