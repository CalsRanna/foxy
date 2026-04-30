import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class EmoteTextDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final emoteIdController = TextEditingController();

  /// EmoteText
  final emoteText0Controller = TextEditingController();
  final emoteText1Controller = TextEditingController();
  final emoteText2Controller = TextEditingController();
  final emoteText3Controller = TextEditingController();
  final emoteText4Controller = TextEditingController();
  final emoteText5Controller = TextEditingController();
  final emoteText6Controller = TextEditingController();
  final emoteText7Controller = TextEditingController();
  final emoteText8Controller = TextEditingController();
  final emoteText9Controller = TextEditingController();
  final emoteText10Controller = TextEditingController();
  final emoteText11Controller = TextEditingController();
  final emoteText12Controller = TextEditingController();
  final emoteText13Controller = TextEditingController();
  final emoteText14Controller = TextEditingController();
  final emoteText15Controller = TextEditingController();

  final emote = signal(EmoteTextEntity());
  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = EmoteTextRepository();
      if (t.id == 0) {
        await repository.storeEmoteText(t);
      } else {
        await repository.updateEmoteText(t);
      }
      emote.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('表情文本数据已保存'));
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

  /// 从所有 Controller 收集数据构建 EmoteText
  EmoteTextEntity _collectFromControllers() {
    return EmoteTextEntity(
      id: _parseInt(idController.text),
      name: nameController.text,
      emoteId: _parseInt(emoteIdController.text),
      emoteText0: _parseInt(emoteText0Controller.text),
      emoteText1: _parseInt(emoteText1Controller.text),
      emoteText2: _parseInt(emoteText2Controller.text),
      emoteText3: _parseInt(emoteText3Controller.text),
      emoteText4: _parseInt(emoteText4Controller.text),
      emoteText5: _parseInt(emoteText5Controller.text),
      emoteText6: _parseInt(emoteText6Controller.text),
      emoteText7: _parseInt(emoteText7Controller.text),
      emoteText8: _parseInt(emoteText8Controller.text),
      emoteText9: _parseInt(emoteText9Controller.text),
      emoteText10: _parseInt(emoteText10Controller.text),
      emoteText11: _parseInt(emoteText11Controller.text),
      emoteText12: _parseInt(emoteText12Controller.text),
      emoteText13: _parseInt(emoteText13Controller.text),
      emoteText14: _parseInt(emoteText14Controller.text),
      emoteText15: _parseInt(emoteText15Controller.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, EmoteTextEntity t) {
    final log = ActivityLogEntity(
      module: 'emote_text',
      actionType: action,
      entityId: t.id,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    /// Basic
    idController.dispose();
    nameController.dispose();
    emoteIdController.dispose();

    /// EmoteText
    emoteText0Controller.dispose();
    emoteText1Controller.dispose();
    emoteText2Controller.dispose();
    emoteText3Controller.dispose();
    emoteText4Controller.dispose();
    emoteText5Controller.dispose();
    emoteText6Controller.dispose();
    emoteText7Controller.dispose();
    emoteText8Controller.dispose();
    emoteText9Controller.dispose();
    emoteText10Controller.dispose();
    emoteText11Controller.dispose();
    emoteText12Controller.dispose();
    emoteText13Controller.dispose();
    emoteText14Controller.dispose();
    emoteText15Controller.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      emote.value = (await EmoteTextRepository().getEmoteText(id))!;
      _initControllers(emote.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载表情文本(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(EmoteTextEntity emoteText) {
    /// Basic
    idController.text = emoteText.id.toString();
    nameController.text = emoteText.name;
    emoteIdController.text = emoteText.emoteId.toString();

    /// EmoteText
    emoteText0Controller.text = emoteText.emoteText0.toString();
    emoteText1Controller.text = emoteText.emoteText1.toString();
    emoteText2Controller.text = emoteText.emoteText2.toString();
    emoteText3Controller.text = emoteText.emoteText3.toString();
    emoteText4Controller.text = emoteText.emoteText4.toString();
    emoteText5Controller.text = emoteText.emoteText5.toString();
    emoteText6Controller.text = emoteText.emoteText6.toString();
    emoteText7Controller.text = emoteText.emoteText7.toString();
    emoteText8Controller.text = emoteText.emoteText8.toString();
    emoteText9Controller.text = emoteText.emoteText9.toString();
    emoteText10Controller.text = emoteText.emoteText10.toString();
    emoteText11Controller.text = emoteText.emoteText11.toString();
    emoteText12Controller.text = emoteText.emoteText12.toString();
    emoteText13Controller.text = emoteText.emoteText13.toString();
    emoteText14Controller.text = emoteText.emoteText14.toString();
    emoteText15Controller.text = emoteText.emoteText15.toString();
  }
}
