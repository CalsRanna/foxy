import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/format_util.dart';
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

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      final isCreate = t.id == 0;
      if (isCreate) {
        final id = await _repository.storeQuestInfo(t);
        t = t.copyWith(id: id);
        idController.text = '$id';
      } else {
        await _repository.updateQuestInfo(t);
      }
      info.value = t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
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

  void applyInfoNameLocales(List<DbcLocaleFieldValue> values) {
    info.value = info.value.copyWith(
      infoNameLangEnUS: values.valueOf('enUS'),
      infoNameLangKoKR: values.valueOf('koKR'),
      infoNameLangFrFR: values.valueOf('frFR'),
      infoNameLangDeDE: values.valueOf('deDE'),
      infoNameLangZhCN: values.valueOf('zhCN'),
      infoNameLangZhTW: values.valueOf('zhTW'),
      infoNameLangEsES: values.valueOf('esES'),
      infoNameLangEsMX: values.valueOf('esMX'),
      infoNameLangRuRU: values.valueOf('ruRU'),
      infoNameLangJaJP: values.valueOf('jaJP'),
      infoNameLangPtPT: values.valueOf('ptPT'),
      infoNameLangPtBR: values.valueOf('ptBR'),
      infoNameLangItIT: values.valueOf('itIT'),
      infoNameLangUnk1: values.valueOf('unk1'),
      infoNameLangUnk2: values.valueOf('unk2'),
      infoNameLangUnk3: values.valueOf('unk3'),
    );
    nameController.text = values.zhCN;
  }

  void pop() {
    routerFacade.goBack();
  }

  QuestInfoEntity _collectFromControllers() {
    return info.value.copyWith(
      id: _pi(idController.text),
      infoNameLangZhCN: nameController.text,
    );
  }

  void _logActivity(ActivityActionType action, QuestInfoEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_info',
      actionType: action,
      entityId: t.id,
      entityName: t.infoNameLangZhCN,
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
    nameController.text = table.infoNameLangZhCN;
  }
}
