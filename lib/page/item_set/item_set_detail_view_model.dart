import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemSetDetailViewModel {
  final _repository = GetIt.instance.get<ItemSetRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = IntFieldController();

  /// Name lang
  final nameLangEnUSController = StringFieldController();
  final nameLangKoKRController = StringFieldController();
  final nameLangFrFRController = StringFieldController();
  final nameLangDeDEController = StringFieldController();
  final nameLangZhCNController = StringFieldController();
  final nameLangZhTWController = StringFieldController();
  final nameLangEsESController = StringFieldController();
  final nameLangEsMXController = StringFieldController();
  final nameLangRuRUController = StringFieldController();
  final nameLangJaJPController = StringFieldController();
  final nameLangPtPTController = StringFieldController();
  final nameLangPtBRController = StringFieldController();
  final nameLangItITController = StringFieldController();
  final nameLangUnk1Controller = StringFieldController();
  final nameLangUnk2Controller = StringFieldController();
  final nameLangUnk3Controller = StringFieldController();
  final nameLangFlags = signal<int>(0);

  /// Item IDs
  final itemId0Controller = IntFieldController();
  final itemId1Controller = IntFieldController();
  final itemId2Controller = IntFieldController();
  final itemId3Controller = IntFieldController();
  final itemId4Controller = IntFieldController();
  final itemId5Controller = IntFieldController();
  final itemId6Controller = IntFieldController();
  final itemId7Controller = IntFieldController();
  final itemId8Controller = IntFieldController();
  final itemId9Controller = IntFieldController();
  final itemId10Controller = IntFieldController();
  final itemId11Controller = IntFieldController();
  final itemId12Controller = IntFieldController();
  final itemId13Controller = IntFieldController();
  final itemId14Controller = IntFieldController();
  final itemId15Controller = IntFieldController();
  final itemId16Controller = IntFieldController();

  /// Set Spell IDs
  final setSpellId0Controller = IntFieldController();
  final setSpellId1Controller = IntFieldController();
  final setSpellId2Controller = IntFieldController();
  final setSpellId3Controller = IntFieldController();
  final setSpellId4Controller = IntFieldController();
  final setSpellId5Controller = IntFieldController();
  final setSpellId6Controller = IntFieldController();
  final setSpellId7Controller = IntFieldController();

  /// Set Thresholds
  final setThreshold0Controller = IntFieldController();
  final setThreshold1Controller = IntFieldController();
  final setThreshold2Controller = IntFieldController();
  final setThreshold3Controller = IntFieldController();
  final setThreshold4Controller = IntFieldController();
  final setThreshold5Controller = IntFieldController();
  final setThreshold6Controller = IntFieldController();
  final setThreshold7Controller = IntFieldController();

  /// Required
  final requiredSkillController = IntFieldController();
  final requiredSkillRankController = IntFieldController();

  /// 按索引访问套装物品/法术控制器
  List<IntFieldController> get itemIdControllers => [
    itemId0Controller,
    itemId1Controller,
    itemId2Controller,
    itemId3Controller,
    itemId4Controller,
    itemId5Controller,
    itemId6Controller,
    itemId7Controller,
    itemId8Controller,
    itemId9Controller,
    itemId10Controller,
    itemId11Controller,
    itemId12Controller,
    itemId13Controller,
    itemId14Controller,
    itemId15Controller,
    itemId16Controller,
  ];

  List<IntFieldController> get setSpellIdControllers => [
    setSpellId0Controller,
    setSpellId1Controller,
    setSpellId2Controller,
    setSpellId3Controller,
    setSpellId4Controller,
    setSpellId5Controller,
    setSpellId6Controller,
    setSpellId7Controller,
  ];

  late final _controllers = <FieldController>[
    idController,
    nameLangEnUSController,
    nameLangKoKRController,
    nameLangFrFRController,
    nameLangDeDEController,
    nameLangZhCNController,
    nameLangZhTWController,
    nameLangEsESController,
    nameLangEsMXController,
    nameLangRuRUController,
    nameLangJaJPController,
    nameLangPtPTController,
    nameLangPtBRController,
    nameLangItITController,
    nameLangUnk1Controller,
    nameLangUnk2Controller,
    nameLangUnk3Controller,
    ...itemIdControllers,
    ...setSpellIdControllers,
    setThreshold0Controller,
    setThreshold1Controller,
    setThreshold2Controller,
    setThreshold3Controller,
    setThreshold4Controller,
    setThreshold5Controller,
    setThreshold6Controller,
    setThreshold7Controller,
    requiredSkillController,
    requiredSkillRankController,
  ];

  final itemSet = signal(ItemSetEntity());

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      final isCreate = (await _repository.getItemSet(t.id)) == null;
      if (isCreate) {
        final id = await _repository.storeItemSet(t);
        t = t.copyWith(id: id);
        idController.init(id);
      } else {
        await _repository.updateItemSet(t);
      }
      itemSet.value = t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('套装数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void applyNameLocales(List<DbcLocaleFieldValue> values) {
    nameLangEnUSController.init(values.valueOf('enUS'));
    nameLangKoKRController.init(values.valueOf('koKR'));
    nameLangFrFRController.init(values.valueOf('frFR'));
    nameLangDeDEController.init(values.valueOf('deDE'));
    nameLangZhCNController.init(values.valueOf('zhCN'));
    nameLangZhTWController.init(values.valueOf('zhTW'));
    nameLangEsESController.init(values.valueOf('esES'));
    nameLangEsMXController.init(values.valueOf('esMX'));
    nameLangRuRUController.init(values.valueOf('ruRU'));
    nameLangJaJPController.init(values.valueOf('jaJP'));
    nameLangPtPTController.init(values.valueOf('ptPT'));
    nameLangPtBRController.init(values.valueOf('ptBR'));
    nameLangItITController.init(values.valueOf('itIT'));
    nameLangUnk1Controller.init(values.valueOf('unk1'));
    nameLangUnk2Controller.init(values.valueOf('unk2'));
    nameLangUnk3Controller.init(values.valueOf('unk3'));
    itemSet.value = _collectFromControllers();
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 ItemSetEntity
  ItemSetEntity _collectFromControllers() {
    return ItemSetEntity(
      id: idController.collect(),
      nameLangEnUS: nameLangEnUSController.collect(),
      nameLangKoKR: nameLangKoKRController.collect(),
      nameLangFrFR: nameLangFrFRController.collect(),
      nameLangDeDE: nameLangDeDEController.collect(),
      nameLangZhCN: nameLangZhCNController.collect(),
      nameLangZhTW: nameLangZhTWController.collect(),
      nameLangEsES: nameLangEsESController.collect(),
      nameLangEsMX: nameLangEsMXController.collect(),
      nameLangRuRU: nameLangRuRUController.collect(),
      nameLangJaJP: nameLangJaJPController.collect(),
      nameLangPtPT: nameLangPtPTController.collect(),
      nameLangPtBR: nameLangPtBRController.collect(),
      nameLangItIT: nameLangItITController.collect(),
      nameLangUnk1: nameLangUnk1Controller.collect(),
      nameLangUnk2: nameLangUnk2Controller.collect(),
      nameLangUnk3: nameLangUnk3Controller.collect(),
      nameLangFlags: nameLangFlags.value,
      itemId0: itemId0Controller.collect(),
      itemId1: itemId1Controller.collect(),
      itemId2: itemId2Controller.collect(),
      itemId3: itemId3Controller.collect(),
      itemId4: itemId4Controller.collect(),
      itemId5: itemId5Controller.collect(),
      itemId6: itemId6Controller.collect(),
      itemId7: itemId7Controller.collect(),
      itemId8: itemId8Controller.collect(),
      itemId9: itemId9Controller.collect(),
      itemId10: itemId10Controller.collect(),
      itemId11: itemId11Controller.collect(),
      itemId12: itemId12Controller.collect(),
      itemId13: itemId13Controller.collect(),
      itemId14: itemId14Controller.collect(),
      itemId15: itemId15Controller.collect(),
      itemId16: itemId16Controller.collect(),
      setSpellId0: setSpellId0Controller.collect(),
      setSpellId1: setSpellId1Controller.collect(),
      setSpellId2: setSpellId2Controller.collect(),
      setSpellId3: setSpellId3Controller.collect(),
      setSpellId4: setSpellId4Controller.collect(),
      setSpellId5: setSpellId5Controller.collect(),
      setSpellId6: setSpellId6Controller.collect(),
      setSpellId7: setSpellId7Controller.collect(),
      setThreshold0: setThreshold0Controller.collect(),
      setThreshold1: setThreshold1Controller.collect(),
      setThreshold2: setThreshold2Controller.collect(),
      setThreshold3: setThreshold3Controller.collect(),
      setThreshold4: setThreshold4Controller.collect(),
      setThreshold5: setThreshold5Controller.collect(),
      setThreshold6: setThreshold6Controller.collect(),
      setThreshold7: setThreshold7Controller.collect(),
      requiredSkill: requiredSkillController.collect(),
      requiredSkillRank: requiredSkillRankController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, ItemSetEntity t) {
    final log = ActivityLogEntity(
      module: 'item_set',
      actionType: action,
      entityId: t.id,
      entityName: '',
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
        final blank = await _repository.createItemSet();
        itemSet.value = blank;
        _initControllers(blank);
        return;
      }
      itemSet.value = (await _repository.getItemSet(id))!;
      _initControllers(itemSet.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载套装(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ItemSetEntity itemSet) {
    idController.init(itemSet.id);
    nameLangEnUSController.init(itemSet.nameLangEnUS);
    nameLangKoKRController.init(itemSet.nameLangKoKR);
    nameLangFrFRController.init(itemSet.nameLangFrFR);
    nameLangDeDEController.init(itemSet.nameLangDeDE);
    nameLangZhCNController.init(itemSet.nameLangZhCN);
    nameLangZhTWController.init(itemSet.nameLangZhTW);
    nameLangEsESController.init(itemSet.nameLangEsES);
    nameLangEsMXController.init(itemSet.nameLangEsMX);
    nameLangRuRUController.init(itemSet.nameLangRuRU);
    nameLangJaJPController.init(itemSet.nameLangJaJP);
    nameLangPtPTController.init(itemSet.nameLangPtPT);
    nameLangPtBRController.init(itemSet.nameLangPtBR);
    nameLangItITController.init(itemSet.nameLangItIT);
    nameLangUnk1Controller.init(itemSet.nameLangUnk1);
    nameLangUnk2Controller.init(itemSet.nameLangUnk2);
    nameLangUnk3Controller.init(itemSet.nameLangUnk3);
    nameLangFlags.value = itemSet.nameLangFlags;
    itemId0Controller.init(itemSet.itemId0);
    itemId1Controller.init(itemSet.itemId1);
    itemId2Controller.init(itemSet.itemId2);
    itemId3Controller.init(itemSet.itemId3);
    itemId4Controller.init(itemSet.itemId4);
    itemId5Controller.init(itemSet.itemId5);
    itemId6Controller.init(itemSet.itemId6);
    itemId7Controller.init(itemSet.itemId7);
    itemId8Controller.init(itemSet.itemId8);
    itemId9Controller.init(itemSet.itemId9);
    itemId10Controller.init(itemSet.itemId10);
    itemId11Controller.init(itemSet.itemId11);
    itemId12Controller.init(itemSet.itemId12);
    itemId13Controller.init(itemSet.itemId13);
    itemId14Controller.init(itemSet.itemId14);
    itemId15Controller.init(itemSet.itemId15);
    itemId16Controller.init(itemSet.itemId16);
    setSpellId0Controller.init(itemSet.setSpellId0);
    setSpellId1Controller.init(itemSet.setSpellId1);
    setSpellId2Controller.init(itemSet.setSpellId2);
    setSpellId3Controller.init(itemSet.setSpellId3);
    setSpellId4Controller.init(itemSet.setSpellId4);
    setSpellId5Controller.init(itemSet.setSpellId5);
    setSpellId6Controller.init(itemSet.setSpellId6);
    setSpellId7Controller.init(itemSet.setSpellId7);
    setThreshold0Controller.init(itemSet.setThreshold0);
    setThreshold1Controller.init(itemSet.setThreshold1);
    setThreshold2Controller.init(itemSet.setThreshold2);
    setThreshold3Controller.init(itemSet.setThreshold3);
    setThreshold4Controller.init(itemSet.setThreshold4);
    setThreshold5Controller.init(itemSet.setThreshold5);
    setThreshold6Controller.init(itemSet.setThreshold6);
    setThreshold7Controller.init(itemSet.setThreshold7);
    requiredSkillController.init(itemSet.requiredSkill);
    requiredSkillRankController.init(itemSet.requiredSkillRank);
  }
}
