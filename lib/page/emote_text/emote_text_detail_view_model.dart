import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class EmoteTextDetailViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<EmoteTextRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  late final idController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final emoteIdController = registerController(IntFieldController());

  /// EmoteText
  late final emoteTextControllers = List.generate(
    16,
    (_) => registerController(IntFieldController()),
  );

  final emote = signal(EmoteTextEntity());

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final existed = await _repository.getEmoteText(t.id);
      if (existed == null) {
        final id = await _repository.storeEmoteText(t);
        idController.init(id);
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
      id: idController.collect(),
      name: nameController.collect(),
      emoteId: emoteIdController.collect(),
      emoteText0: emoteTextControllers[0].collect(),
      emoteText1: emoteTextControllers[1].collect(),
      emoteText2: emoteTextControllers[2].collect(),
      emoteText3: emoteTextControllers[3].collect(),
      emoteText4: emoteTextControllers[4].collect(),
      emoteText5: emoteTextControllers[5].collect(),
      emoteText6: emoteTextControllers[6].collect(),
      emoteText7: emoteTextControllers[7].collect(),
      emoteText8: emoteTextControllers[8].collect(),
      emoteText9: emoteTextControllers[9].collect(),
      emoteText10: emoteTextControllers[10].collect(),
      emoteText11: emoteTextControllers[11].collect(),
      emoteText12: emoteTextControllers[12].collect(),
      emoteText13: emoteTextControllers[13].collect(),
      emoteText14: emoteTextControllers[14].collect(),
      emoteText15: emoteTextControllers[15].collect(),
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
    disposeControllers();
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createEmoteText();
        emote.value = blank;
        _initControllers(blank);
        return;
      }
      emote.value = (await _repository.getEmoteText(id))!;
      _initControllers(emote.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载表情文本(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(EmoteTextEntity emoteText) {
    idController.init(emoteText.id);
    nameController.init(emoteText.name);
    emoteIdController.init(emoteText.emoteId);
    emoteTextControllers[0].init(emoteText.emoteText0);
    emoteTextControllers[1].init(emoteText.emoteText1);
    emoteTextControllers[2].init(emoteText.emoteText2);
    emoteTextControllers[3].init(emoteText.emoteText3);
    emoteTextControllers[4].init(emoteText.emoteText4);
    emoteTextControllers[5].init(emoteText.emoteText5);
    emoteTextControllers[6].init(emoteText.emoteText6);
    emoteTextControllers[7].init(emoteText.emoteText7);
    emoteTextControllers[8].init(emoteText.emoteText8);
    emoteTextControllers[9].init(emoteText.emoteText9);
    emoteTextControllers[10].init(emoteText.emoteText10);
    emoteTextControllers[11].init(emoteText.emoteText11);
    emoteTextControllers[12].init(emoteText.emoteText12);
    emoteTextControllers[13].init(emoteText.emoteText13);
    emoteTextControllers[14].init(emoteText.emoteText14);
    emoteTextControllers[15].init(emoteText.emoteText15);
  }
}
