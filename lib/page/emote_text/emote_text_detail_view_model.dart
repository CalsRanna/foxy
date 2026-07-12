import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class EmoteTextDetailViewModel {
  final _repository = GetIt.instance.get<EmoteTextRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final emoteIdController = TextEditingController();

  /// EmoteText
  final emoteTextControllers = List.generate(
    16,
    (_) => TextEditingController(),
  );

  final emote = signal(EmoteTextEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        final id = await _repository.storeEmoteText(t);
        idController.text = '$id';
      } else {
        await _repository.updateEmoteText(t);
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
      id: _pi(idController.text),
      name: nameController.text,
      emoteId: _pi(emoteIdController.text),
      emoteText0: _pi(emoteTextControllers[0].text),
      emoteText1: _pi(emoteTextControllers[1].text),
      emoteText2: _pi(emoteTextControllers[2].text),
      emoteText3: _pi(emoteTextControllers[3].text),
      emoteText4: _pi(emoteTextControllers[4].text),
      emoteText5: _pi(emoteTextControllers[5].text),
      emoteText6: _pi(emoteTextControllers[6].text),
      emoteText7: _pi(emoteTextControllers[7].text),
      emoteText8: _pi(emoteTextControllers[8].text),
      emoteText9: _pi(emoteTextControllers[9].text),
      emoteText10: _pi(emoteTextControllers[10].text),
      emoteText11: _pi(emoteTextControllers[11].text),
      emoteText12: _pi(emoteTextControllers[12].text),
      emoteText13: _pi(emoteTextControllers[13].text),
      emoteText14: _pi(emoteTextControllers[14].text),
      emoteText15: _pi(emoteTextControllers[15].text),
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    emoteIdController.dispose();
    for (final c in emoteTextControllers) {
      c.dispose();
    }
    idController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      emote.value = (await _repository.getEmoteText(id))!;
      _initControllers(emote.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载表情文本(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(EmoteTextEntity emoteText) {
    /// Basic
    idController.text = _fmt(emoteText.id);
    nameController.text = emoteText.name;
    emoteIdController.text = _fmt(emoteText.emoteId);

    /// EmoteText
    emoteTextControllers[0].text = _fmt(emoteText.emoteText0);
    emoteTextControllers[1].text = _fmt(emoteText.emoteText1);
    emoteTextControllers[2].text = _fmt(emoteText.emoteText2);
    emoteTextControllers[3].text = _fmt(emoteText.emoteText3);
    emoteTextControllers[4].text = _fmt(emoteText.emoteText4);
    emoteTextControllers[5].text = _fmt(emoteText.emoteText5);
    emoteTextControllers[6].text = _fmt(emoteText.emoteText6);
    emoteTextControllers[7].text = _fmt(emoteText.emoteText7);
    emoteTextControllers[8].text = _fmt(emoteText.emoteText8);
    emoteTextControllers[9].text = _fmt(emoteText.emoteText9);
    emoteTextControllers[10].text = _fmt(emoteText.emoteText10);
    emoteTextControllers[11].text = _fmt(emoteText.emoteText11);
    emoteTextControllers[12].text = _fmt(emoteText.emoteText12);
    emoteTextControllers[13].text = _fmt(emoteText.emoteText13);
    emoteTextControllers[14].text = _fmt(emoteText.emoteText14);
    emoteTextControllers[15].text = _fmt(emoteText.emoteText15);
  }
}
