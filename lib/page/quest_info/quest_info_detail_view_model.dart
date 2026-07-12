import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestInfoDetailViewModel {
  final _repository = GetIt.instance.get<QuestInfoRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final idController = IntFieldController();
  final nameController = StringFieldController();

  late final _controllers = <FieldController>[idController, nameController];

  final info = signal(QuestInfoEntity());

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      final isCreate = (await _repository.getQuestInfo(t.id)) == null;
      if (isCreate) {
        final id = await _repository.storeQuestInfo(t);
        t = t.copyWith(id: id);
        idController.init(id);
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
    nameController.init(values.zhCN);
  }

  void pop() {
    routerFacade.goBack();
  }

  QuestInfoEntity _collectFromControllers() {
    return info.value.copyWith(
      id: idController.collect(),
      infoNameLangZhCN: nameController.collect(),
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createQuestInfo();
        info.value = blank;
        _initControllers(blank);
        return;
      }
      info.value = (await _repository.getQuestInfo(id))!;
      _initControllers(info.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载任务信息(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestInfoEntity table) {
    idController.init(table.id);
    nameController.init(table.infoNameLangZhCN);
  }
}
