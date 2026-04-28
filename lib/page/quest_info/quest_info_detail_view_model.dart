import 'package:flutter/widgets.dart';
import 'package:foxy/model/quest_info.dart';
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

  final table = signal(QuestInfo());
  final saving = signal(false);

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final t = _collectFromControllers();
      final repository = QuestInfoRepository();
      if (t.id == 0) {
        await repository.store(t);
      } else {
        await repository.update(t);
      }
      table.value = t;
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
  QuestInfo _collectFromControllers() {
    final t = QuestInfo();
    t.id = _parseInt(idController.text);
    t.infoNameLangZhCn = nameController.text;
    return t;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void dispose() {
    idController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      table.value = (await QuestInfoRepository().find(id))!;
      _initControllers(table.value);
    } catch (e, s) {
      logger.e('加载任务信息(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestInfo table) {
    idController.text = table.id.toString();
    nameController.text = table.infoNameLangZhCn;
  }
}
