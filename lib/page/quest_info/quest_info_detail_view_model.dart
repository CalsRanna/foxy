import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/quest_info_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestInfoDetailViewModel
    with
        ViewModelValidationMixin,
        QuestInfoValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestInfoRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  late final idController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final infoNameLangFlagsController = registerController(
    IntFieldController(),
  );

  final info = signal(QuestInfoEntity());
  final persistedKey = signal<int?>(null);

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

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    try {
      if (key == null) {
        persistedKey.value = null;
        final blank = await _repository.createQuestInfo();
        info.value = blank;
        _initControllers(blank);
        return;
      }
      persistedKey.value = key;
      final entity = await _repository.getQuestInfo(key);
      if (entity == null) {
        throw StateError('原任务信息不存在，可能已被其他操作修改或删除');
      }
      info.value = entity;
      _initControllers(entity);
    } catch (e, s) {
      LoggerUtil.instance.e('加载任务信息(key=$key)失败', error: e, stackTrace: s);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> persist() async {
    final candidate = _collectFromControllers();
    validateQuestInfoFields(candidate);
    final originalKey = persistedKey.value;
    final action = originalKey == null
        ? ActivityActionType.create
        : ActivityActionType.update;
    if (originalKey == null) {
      await _repository.storeQuestInfo(candidate);
    } else {
      await _repository.updateQuestInfo(originalKey, candidate);
    }
    persistedKey.value = candidate.id;
    info.value = candidate;
    routerFacade.updateCurrentLabel(_labelFor(candidate));
    _logActivity(action, candidate);
  }

  Future<void> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('任务信息数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  QuestInfoEntity _collectFromControllers() {
    return info.value.copyWith(
      id: idController.collect(),
      infoNameLangZhCN: nameController.collect(),
      infoNameLangFlags: infoNameLangFlagsController.collect(),
    );
  }

  void _initControllers(QuestInfoEntity table) {
    idController.init(table.id);
    nameController.init(table.infoNameLangZhCN);
    infoNameLangFlagsController.init(table.infoNameLangFlags);
  }

  void _logActivity(ActivityActionType action, QuestInfoEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_info',
      actionType: action,
      entityName: t.infoNameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  String _labelFor(QuestInfoEntity value) {
    return value.infoNameLangZhCN.isNotEmpty
        ? value.infoNameLangZhCN
        : '任务信息 #${value.id}';
  }
}
