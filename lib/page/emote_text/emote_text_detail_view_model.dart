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
  final id = signal<int>(0);
  final nameController = TextEditingController();
  final emoteId = signal<int>(0);

  /// EmoteText
  final emoteText0 = signal<int>(0);
  final emoteText1 = signal<int>(0);
  final emoteText2 = signal<int>(0);
  final emoteText3 = signal<int>(0);
  final emoteText4 = signal<int>(0);
  final emoteText5 = signal<int>(0);
  final emoteText6 = signal<int>(0);
  final emoteText7 = signal<int>(0);
  final emoteText8 = signal<int>(0);
  final emoteText9 = signal<int>(0);
  final emoteText10 = signal<int>(0);
  final emoteText11 = signal<int>(0);
  final emoteText12 = signal<int>(0);
  final emoteText13 = signal<int>(0);
  final emoteText14 = signal<int>(0);
  final emoteText15 = signal<int>(0);

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
      id: id.value,
      name: nameController.text,
      emoteId: emoteId.value,
      emoteText0: emoteText0.value,
      emoteText1: emoteText1.value,
      emoteText2: emoteText2.value,
      emoteText3: emoteText3.value,
      emoteText4: emoteText4.value,
      emoteText5: emoteText5.value,
      emoteText6: emoteText6.value,
      emoteText7: emoteText7.value,
      emoteText8: emoteText8.value,
      emoteText9: emoteText9.value,
      emoteText10: emoteText10.value,
      emoteText11: emoteText11.value,
      emoteText12: emoteText12.value,
      emoteText13: emoteText13.value,
      emoteText14: emoteText14.value,
      emoteText15: emoteText15.value,
    );
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
    nameController.dispose();
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
    id.value = emoteText.id;
    nameController.text = emoteText.name;
    emoteId.value = emoteText.emoteId;

    /// EmoteText
    emoteText0.value = emoteText.emoteText0;
    emoteText1.value = emoteText.emoteText1;
    emoteText2.value = emoteText.emoteText2;
    emoteText3.value = emoteText.emoteText3;
    emoteText4.value = emoteText.emoteText4;
    emoteText5.value = emoteText.emoteText5;
    emoteText6.value = emoteText.emoteText6;
    emoteText7.value = emoteText.emoteText7;
    emoteText8.value = emoteText.emoteText8;
    emoteText9.value = emoteText.emoteText9;
    emoteText10.value = emoteText.emoteText10;
    emoteText11.value = emoteText.emoteText11;
    emoteText12.value = emoteText.emoteText12;
    emoteText13.value = emoteText.emoteText13;
    emoteText14.value = emoteText.emoteText14;
    emoteText15.value = emoteText.emoteText15;
  }
}
