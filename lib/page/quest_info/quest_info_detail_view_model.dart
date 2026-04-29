import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestInfoDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final idController = TextEditingController();
  final nameController = TextEditingController();

  final info = signal(QuestInfoEntity());
  final saving = signal(false);

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final t = _collectFromControllers();
      final repository = QuestInfoRepository();
      if (t.id == 0) {
        await repository.storeQuestInfo(t);
      } else {
        await repository.updateQuestInfo(t);
      }
      info.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('任务信息数据已保存'));
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

  /// 从所有 Controller 收集数据构建 QuestInfo
  QuestInfoEntity _collectFromControllers() {
    return QuestInfoEntity(
      id: _parseInt(idController.text),
      infoNameLangZhCn: nameController.text,
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, QuestInfoEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_info',
      actionType: action,
      entityId: t.id,
      entityName: t.infoNameLangZhCn,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    idController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      info.value = (await QuestInfoRepository().getQuestInfo(id))!;
      _initControllers(info.value);
    } catch (e, s) {
      logger.e('加载任务信息(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestInfoEntity table) {
    idController.text = table.id.toString();
    nameController.text = table.infoNameLangZhCn;
  }
}
