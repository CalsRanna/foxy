import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestInfoDetailViewModel {
  final _repository = GetIt.instance.get<QuestInfoRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final idController = TextEditingController();
  final nameController = TextEditingController();

  final info = signal(QuestInfoEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        await _repository.storeQuestInfo(t);
      } else {
        await _repository.updateQuestInfo(t);
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
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 QuestInfo
  QuestInfoEntity _collectFromControllers() {
    return QuestInfoEntity(
      id: _pi(idController.text),
      infoNameLangZhCn: nameController.text,
    );
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
      info.value = (await _repository.getQuestInfo(id))!;
      _initControllers(info.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载任务信息(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestInfoEntity table) {
    idController.text = _fmt(table.id);
    nameController.text = table.infoNameLangZhCn;
  }
}
