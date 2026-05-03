import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemSetDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final id = signal<int>(0);

  /// Name lang
  final nameLangEnUSController = TextEditingController();
  final nameLangKoKRController = TextEditingController();
  final nameLangFrFRController = TextEditingController();
  final nameLangDeDEController = TextEditingController();
  final nameLangZhCNController = TextEditingController();
  final nameLangZhTWController = TextEditingController();
  final nameLangEsESController = TextEditingController();
  final nameLangEsMXController = TextEditingController();
  final nameLangRuRUController = TextEditingController();
  final nameLangJaJPController = TextEditingController();
  final nameLangPtPTController = TextEditingController();
  final nameLangPtBRController = TextEditingController();
  final nameLangItITController = TextEditingController();
  final nameLangUnk1Controller = TextEditingController();
  final nameLangUnk2Controller = TextEditingController();
  final nameLangUnk3Controller = TextEditingController();
  final nameLangFlags = signal<int>(0);

  /// Item IDs
  final itemId0 = signal<int>(0);
  final itemId1 = signal<int>(0);
  final itemId2 = signal<int>(0);
  final itemId3 = signal<int>(0);
  final itemId4 = signal<int>(0);
  final itemId5 = signal<int>(0);
  final itemId6 = signal<int>(0);
  final itemId7 = signal<int>(0);
  final itemId8 = signal<int>(0);
  final itemId9 = signal<int>(0);
  final itemId10 = signal<int>(0);
  final itemId11 = signal<int>(0);
  final itemId12 = signal<int>(0);
  final itemId13 = signal<int>(0);
  final itemId14 = signal<int>(0);
  final itemId15 = signal<int>(0);
  final itemId16 = signal<int>(0);

  /// Set Spell IDs
  final setSpellId0 = signal<int>(0);
  final setSpellId1 = signal<int>(0);
  final setSpellId2 = signal<int>(0);
  final setSpellId3 = signal<int>(0);
  final setSpellId4 = signal<int>(0);
  final setSpellId5 = signal<int>(0);
  final setSpellId6 = signal<int>(0);
  final setSpellId7 = signal<int>(0);

  /// Set Thresholds
  final setThreshold0 = signal<int>(0);
  final setThreshold1 = signal<int>(0);
  final setThreshold2 = signal<int>(0);
  final setThreshold3 = signal<int>(0);
  final setThreshold4 = signal<int>(0);
  final setThreshold5 = signal<int>(0);
  final setThreshold6 = signal<int>(0);
  final setThreshold7 = signal<int>(0);

  /// Required
  final requiredSkill = signal<int>(0);
  final requiredSkillRank = signal<int>(0);

  final itemSet = signal(ItemSetEntity());

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = ItemSetRepository();
      if (t.id == 0) {
        await repository.storeItemSet(t);
      } else {
        await repository.updateItemSet(t);
      }
      itemSet.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
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

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 ItemSetEntity
  ItemSetEntity _collectFromControllers() {
    return ItemSetEntity(
      id: id.value,
      nameLangEnUS: nameLangEnUSController.text,
      nameLangKoKR: nameLangKoKRController.text,
      nameLangFrFR: nameLangFrFRController.text,
      nameLangDeDE: nameLangDeDEController.text,
      nameLangZhCN: nameLangZhCNController.text,
      nameLangZhTW: nameLangZhTWController.text,
      nameLangEsES: nameLangEsESController.text,
      nameLangEsMX: nameLangEsMXController.text,
      nameLangRuRU: nameLangRuRUController.text,
      nameLangJaJP: nameLangJaJPController.text,
      nameLangPtPT: nameLangPtPTController.text,
      nameLangPtBR: nameLangPtBRController.text,
      nameLangItIT: nameLangItITController.text,
      nameLangUnk1: nameLangUnk1Controller.text,
      nameLangUnk2: nameLangUnk2Controller.text,
      nameLangUnk3: nameLangUnk3Controller.text,
      nameLangFlags: nameLangFlags.value,
      itemId0: itemId0.value,
      itemId1: itemId1.value,
      itemId2: itemId2.value,
      itemId3: itemId3.value,
      itemId4: itemId4.value,
      itemId5: itemId5.value,
      itemId6: itemId6.value,
      itemId7: itemId7.value,
      itemId8: itemId8.value,
      itemId9: itemId9.value,
      itemId10: itemId10.value,
      itemId11: itemId11.value,
      itemId12: itemId12.value,
      itemId13: itemId13.value,
      itemId14: itemId14.value,
      itemId15: itemId15.value,
      itemId16: itemId16.value,
      setSpellId0: setSpellId0.value,
      setSpellId1: setSpellId1.value,
      setSpellId2: setSpellId2.value,
      setSpellId3: setSpellId3.value,
      setSpellId4: setSpellId4.value,
      setSpellId5: setSpellId5.value,
      setSpellId6: setSpellId6.value,
      setSpellId7: setSpellId7.value,
      setThreshold0: setThreshold0.value,
      setThreshold1: setThreshold1.value,
      setThreshold2: setThreshold2.value,
      setThreshold3: setThreshold3.value,
      setThreshold4: setThreshold4.value,
      setThreshold5: setThreshold5.value,
      setThreshold6: setThreshold6.value,
      setThreshold7: setThreshold7.value,
      requiredSkill: requiredSkill.value,
      requiredSkillRank: requiredSkillRank.value,
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    nameLangEnUSController.dispose();
    nameLangKoKRController.dispose();
    nameLangFrFRController.dispose();
    nameLangDeDEController.dispose();
    nameLangZhCNController.dispose();
    nameLangZhTWController.dispose();
    nameLangEsESController.dispose();
    nameLangEsMXController.dispose();
    nameLangRuRUController.dispose();
    nameLangJaJPController.dispose();
    nameLangPtPTController.dispose();
    nameLangPtBRController.dispose();
    nameLangItITController.dispose();
    nameLangUnk1Controller.dispose();
    nameLangUnk2Controller.dispose();
    nameLangUnk3Controller.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      itemSet.value = (await ItemSetRepository().getItemSet(id))!;
      _initControllers(itemSet.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载套装(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ItemSetEntity itemSet) {
    id.value = itemSet.id;
    nameLangEnUSController.text = itemSet.nameLangEnUS;
    nameLangKoKRController.text = itemSet.nameLangKoKR;
    nameLangFrFRController.text = itemSet.nameLangFrFR;
    nameLangDeDEController.text = itemSet.nameLangDeDE;
    nameLangZhCNController.text = itemSet.nameLangZhCN;
    nameLangZhTWController.text = itemSet.nameLangZhTW;
    nameLangEsESController.text = itemSet.nameLangEsES;
    nameLangEsMXController.text = itemSet.nameLangEsMX;
    nameLangRuRUController.text = itemSet.nameLangRuRU;
    nameLangJaJPController.text = itemSet.nameLangJaJP;
    nameLangPtPTController.text = itemSet.nameLangPtPT;
    nameLangPtBRController.text = itemSet.nameLangPtBR;
    nameLangItITController.text = itemSet.nameLangItIT;
    nameLangUnk1Controller.text = itemSet.nameLangUnk1;
    nameLangUnk2Controller.text = itemSet.nameLangUnk2;
    nameLangUnk3Controller.text = itemSet.nameLangUnk3;
    nameLangFlags.value = itemSet.nameLangFlags;
    itemId0.value = itemSet.itemId0;
    itemId1.value = itemSet.itemId1;
    itemId2.value = itemSet.itemId2;
    itemId3.value = itemSet.itemId3;
    itemId4.value = itemSet.itemId4;
    itemId5.value = itemSet.itemId5;
    itemId6.value = itemSet.itemId6;
    itemId7.value = itemSet.itemId7;
    itemId8.value = itemSet.itemId8;
    itemId9.value = itemSet.itemId9;
    itemId10.value = itemSet.itemId10;
    itemId11.value = itemSet.itemId11;
    itemId12.value = itemSet.itemId12;
    itemId13.value = itemSet.itemId13;
    itemId14.value = itemSet.itemId14;
    itemId15.value = itemSet.itemId15;
    itemId16.value = itemSet.itemId16;
    setSpellId0.value = itemSet.setSpellId0;
    setSpellId1.value = itemSet.setSpellId1;
    setSpellId2.value = itemSet.setSpellId2;
    setSpellId3.value = itemSet.setSpellId3;
    setSpellId4.value = itemSet.setSpellId4;
    setSpellId5.value = itemSet.setSpellId5;
    setSpellId6.value = itemSet.setSpellId6;
    setSpellId7.value = itemSet.setSpellId7;
    setThreshold0.value = itemSet.setThreshold0;
    setThreshold1.value = itemSet.setThreshold1;
    setThreshold2.value = itemSet.setThreshold2;
    setThreshold3.value = itemSet.setThreshold3;
    setThreshold4.value = itemSet.setThreshold4;
    setThreshold5.value = itemSet.setThreshold5;
    setThreshold6.value = itemSet.setThreshold6;
    setThreshold7.value = itemSet.setThreshold7;
    requiredSkill.value = itemSet.requiredSkill;
    requiredSkillRank.value = itemSet.requiredSkillRank;
  }
}
