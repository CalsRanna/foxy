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
  final idController = TextEditingController();

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
  final nameLangFlagsController = TextEditingController();

  /// Item IDs
  final itemId0Controller = TextEditingController();
  final itemId1Controller = TextEditingController();
  final itemId2Controller = TextEditingController();
  final itemId3Controller = TextEditingController();
  final itemId4Controller = TextEditingController();
  final itemId5Controller = TextEditingController();
  final itemId6Controller = TextEditingController();
  final itemId7Controller = TextEditingController();
  final itemId8Controller = TextEditingController();
  final itemId9Controller = TextEditingController();
  final itemId10Controller = TextEditingController();
  final itemId11Controller = TextEditingController();
  final itemId12Controller = TextEditingController();
  final itemId13Controller = TextEditingController();
  final itemId14Controller = TextEditingController();
  final itemId15Controller = TextEditingController();
  final itemId16Controller = TextEditingController();

  /// Set Spell IDs
  final setSpellId0Controller = TextEditingController();
  final setSpellId1Controller = TextEditingController();
  final setSpellId2Controller = TextEditingController();
  final setSpellId3Controller = TextEditingController();
  final setSpellId4Controller = TextEditingController();
  final setSpellId5Controller = TextEditingController();
  final setSpellId6Controller = TextEditingController();
  final setSpellId7Controller = TextEditingController();

  /// Set Thresholds
  final setThreshold0Controller = TextEditingController();
  final setThreshold1Controller = TextEditingController();
  final setThreshold2Controller = TextEditingController();
  final setThreshold3Controller = TextEditingController();
  final setThreshold4Controller = TextEditingController();
  final setThreshold5Controller = TextEditingController();
  final setThreshold6Controller = TextEditingController();
  final setThreshold7Controller = TextEditingController();

  /// Required
  final requiredSkillController = TextEditingController();
  final requiredSkillRankController = TextEditingController();

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
      id: _parseInt(idController.text),
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
      nameLangFlags: _parseInt(nameLangFlagsController.text),
      itemId0: _parseInt(itemId0Controller.text),
      itemId1: _parseInt(itemId1Controller.text),
      itemId2: _parseInt(itemId2Controller.text),
      itemId3: _parseInt(itemId3Controller.text),
      itemId4: _parseInt(itemId4Controller.text),
      itemId5: _parseInt(itemId5Controller.text),
      itemId6: _parseInt(itemId6Controller.text),
      itemId7: _parseInt(itemId7Controller.text),
      itemId8: _parseInt(itemId8Controller.text),
      itemId9: _parseInt(itemId9Controller.text),
      itemId10: _parseInt(itemId10Controller.text),
      itemId11: _parseInt(itemId11Controller.text),
      itemId12: _parseInt(itemId12Controller.text),
      itemId13: _parseInt(itemId13Controller.text),
      itemId14: _parseInt(itemId14Controller.text),
      itemId15: _parseInt(itemId15Controller.text),
      itemId16: _parseInt(itemId16Controller.text),
      setSpellId0: _parseInt(setSpellId0Controller.text),
      setSpellId1: _parseInt(setSpellId1Controller.text),
      setSpellId2: _parseInt(setSpellId2Controller.text),
      setSpellId3: _parseInt(setSpellId3Controller.text),
      setSpellId4: _parseInt(setSpellId4Controller.text),
      setSpellId5: _parseInt(setSpellId5Controller.text),
      setSpellId6: _parseInt(setSpellId6Controller.text),
      setSpellId7: _parseInt(setSpellId7Controller.text),
      setThreshold0: _parseInt(setThreshold0Controller.text),
      setThreshold1: _parseInt(setThreshold1Controller.text),
      setThreshold2: _parseInt(setThreshold2Controller.text),
      setThreshold3: _parseInt(setThreshold3Controller.text),
      setThreshold4: _parseInt(setThreshold4Controller.text),
      setThreshold5: _parseInt(setThreshold5Controller.text),
      setThreshold6: _parseInt(setThreshold6Controller.text),
      setThreshold7: _parseInt(setThreshold7Controller.text),
      requiredSkill: _parseInt(requiredSkillController.text),
      requiredSkillRank: _parseInt(requiredSkillRankController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
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
    idController.dispose();
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
    nameLangFlagsController.dispose();
    itemId0Controller.dispose();
    itemId1Controller.dispose();
    itemId2Controller.dispose();
    itemId3Controller.dispose();
    itemId4Controller.dispose();
    itemId5Controller.dispose();
    itemId6Controller.dispose();
    itemId7Controller.dispose();
    itemId8Controller.dispose();
    itemId9Controller.dispose();
    itemId10Controller.dispose();
    itemId11Controller.dispose();
    itemId12Controller.dispose();
    itemId13Controller.dispose();
    itemId14Controller.dispose();
    itemId15Controller.dispose();
    itemId16Controller.dispose();
    setSpellId0Controller.dispose();
    setSpellId1Controller.dispose();
    setSpellId2Controller.dispose();
    setSpellId3Controller.dispose();
    setSpellId4Controller.dispose();
    setSpellId5Controller.dispose();
    setSpellId6Controller.dispose();
    setSpellId7Controller.dispose();
    setThreshold0Controller.dispose();
    setThreshold1Controller.dispose();
    setThreshold2Controller.dispose();
    setThreshold3Controller.dispose();
    setThreshold4Controller.dispose();
    setThreshold5Controller.dispose();
    setThreshold6Controller.dispose();
    setThreshold7Controller.dispose();
    requiredSkillController.dispose();
    requiredSkillRankController.dispose();
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
    idController.text = itemSet.id.toString();
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
    nameLangFlagsController.text = itemSet.nameLangFlags.toString();
    itemId0Controller.text = itemSet.itemId0.toString();
    itemId1Controller.text = itemSet.itemId1.toString();
    itemId2Controller.text = itemSet.itemId2.toString();
    itemId3Controller.text = itemSet.itemId3.toString();
    itemId4Controller.text = itemSet.itemId4.toString();
    itemId5Controller.text = itemSet.itemId5.toString();
    itemId6Controller.text = itemSet.itemId6.toString();
    itemId7Controller.text = itemSet.itemId7.toString();
    itemId8Controller.text = itemSet.itemId8.toString();
    itemId9Controller.text = itemSet.itemId9.toString();
    itemId10Controller.text = itemSet.itemId10.toString();
    itemId11Controller.text = itemSet.itemId11.toString();
    itemId12Controller.text = itemSet.itemId12.toString();
    itemId13Controller.text = itemSet.itemId13.toString();
    itemId14Controller.text = itemSet.itemId14.toString();
    itemId15Controller.text = itemSet.itemId15.toString();
    itemId16Controller.text = itemSet.itemId16.toString();
    setSpellId0Controller.text = itemSet.setSpellId0.toString();
    setSpellId1Controller.text = itemSet.setSpellId1.toString();
    setSpellId2Controller.text = itemSet.setSpellId2.toString();
    setSpellId3Controller.text = itemSet.setSpellId3.toString();
    setSpellId4Controller.text = itemSet.setSpellId4.toString();
    setSpellId5Controller.text = itemSet.setSpellId5.toString();
    setSpellId6Controller.text = itemSet.setSpellId6.toString();
    setSpellId7Controller.text = itemSet.setSpellId7.toString();
    setThreshold0Controller.text = itemSet.setThreshold0.toString();
    setThreshold1Controller.text = itemSet.setThreshold1.toString();
    setThreshold2Controller.text = itemSet.setThreshold2.toString();
    setThreshold3Controller.text = itemSet.setThreshold3.toString();
    setThreshold4Controller.text = itemSet.setThreshold4.toString();
    setThreshold5Controller.text = itemSet.setThreshold5.toString();
    setThreshold6Controller.text = itemSet.setThreshold6.toString();
    setThreshold7Controller.text = itemSet.setThreshold7.toString();
    requiredSkillController.text = itemSet.requiredSkill.toString();
    requiredSkillRankController.text = itemSet.requiredSkillRank.toString();
  }
}
