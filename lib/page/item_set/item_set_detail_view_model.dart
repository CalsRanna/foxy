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
  final _repository = GetIt.instance.get<ItemSetRepository>();
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
  final nameLangFlags = signal<int>(0);

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
  String _fmt(num v) {
    if (v is double) {
      final s = v.toString();
      if (s.contains('.') && s.endsWith('0')) {
        return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return s;
    }
    return v.toString();
  }

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        await _repository.storeItemSet(t);
      } else {
        await _repository.updateItemSet(t);
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
      id: _pi(idController.text),
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
      itemId0: _pi(itemId0Controller.text),
      itemId1: _pi(itemId1Controller.text),
      itemId2: _pi(itemId2Controller.text),
      itemId3: _pi(itemId3Controller.text),
      itemId4: _pi(itemId4Controller.text),
      itemId5: _pi(itemId5Controller.text),
      itemId6: _pi(itemId6Controller.text),
      itemId7: _pi(itemId7Controller.text),
      itemId8: _pi(itemId8Controller.text),
      itemId9: _pi(itemId9Controller.text),
      itemId10: _pi(itemId10Controller.text),
      itemId11: _pi(itemId11Controller.text),
      itemId12: _pi(itemId12Controller.text),
      itemId13: _pi(itemId13Controller.text),
      itemId14: _pi(itemId14Controller.text),
      itemId15: _pi(itemId15Controller.text),
      itemId16: _pi(itemId16Controller.text),
      setSpellId0: _pi(setSpellId0Controller.text),
      setSpellId1: _pi(setSpellId1Controller.text),
      setSpellId2: _pi(setSpellId2Controller.text),
      setSpellId3: _pi(setSpellId3Controller.text),
      setSpellId4: _pi(setSpellId4Controller.text),
      setSpellId5: _pi(setSpellId5Controller.text),
      setSpellId6: _pi(setSpellId6Controller.text),
      setSpellId7: _pi(setSpellId7Controller.text),
      setThreshold0: _pi(setThreshold0Controller.text),
      setThreshold1: _pi(setThreshold1Controller.text),
      setThreshold2: _pi(setThreshold2Controller.text),
      setThreshold3: _pi(setThreshold3Controller.text),
      setThreshold4: _pi(setThreshold4Controller.text),
      setThreshold5: _pi(setThreshold5Controller.text),
      setThreshold6: _pi(setThreshold6Controller.text),
      setThreshold7: _pi(setThreshold7Controller.text),
      requiredSkill: _pi(requiredSkillController.text),
      requiredSkillRank: _pi(requiredSkillRankController.text),
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
    idController.dispose();
    itemId0Controller.dispose();
    itemId10Controller.dispose();
    itemId11Controller.dispose();
    itemId12Controller.dispose();
    itemId13Controller.dispose();
    itemId14Controller.dispose();
    itemId15Controller.dispose();
    itemId16Controller.dispose();
    itemId1Controller.dispose();
    itemId2Controller.dispose();
    itemId3Controller.dispose();
    itemId4Controller.dispose();
    itemId5Controller.dispose();
    itemId6Controller.dispose();
    itemId7Controller.dispose();
    itemId8Controller.dispose();
    itemId9Controller.dispose();
    nameLangDeDEController.dispose();
    nameLangEnUSController.dispose();
    nameLangEsESController.dispose();
    nameLangEsMXController.dispose();
    nameLangFrFRController.dispose();
    nameLangItITController.dispose();
    nameLangJaJPController.dispose();
    nameLangKoKRController.dispose();
    nameLangPtBRController.dispose();
    nameLangPtPTController.dispose();
    nameLangRuRUController.dispose();
    nameLangUnk1Controller.dispose();
    nameLangUnk2Controller.dispose();
    nameLangUnk3Controller.dispose();
    nameLangZhCNController.dispose();
    nameLangZhTWController.dispose();
    requiredSkillController.dispose();
    requiredSkillRankController.dispose();
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
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      itemSet.value = (await _repository.getItemSet(id))!;
      _initControllers(itemSet.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载套装(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ItemSetEntity itemSet) {
    idController.text = _fmt(itemSet.id);
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
    itemId0Controller.text = _fmt(itemSet.itemId0);
    itemId1Controller.text = _fmt(itemSet.itemId1);
    itemId2Controller.text = _fmt(itemSet.itemId2);
    itemId3Controller.text = _fmt(itemSet.itemId3);
    itemId4Controller.text = _fmt(itemSet.itemId4);
    itemId5Controller.text = _fmt(itemSet.itemId5);
    itemId6Controller.text = _fmt(itemSet.itemId6);
    itemId7Controller.text = _fmt(itemSet.itemId7);
    itemId8Controller.text = _fmt(itemSet.itemId8);
    itemId9Controller.text = _fmt(itemSet.itemId9);
    itemId10Controller.text = _fmt(itemSet.itemId10);
    itemId11Controller.text = _fmt(itemSet.itemId11);
    itemId12Controller.text = _fmt(itemSet.itemId12);
    itemId13Controller.text = _fmt(itemSet.itemId13);
    itemId14Controller.text = _fmt(itemSet.itemId14);
    itemId15Controller.text = _fmt(itemSet.itemId15);
    itemId16Controller.text = _fmt(itemSet.itemId16);
    setSpellId0Controller.text = _fmt(itemSet.setSpellId0);
    setSpellId1Controller.text = _fmt(itemSet.setSpellId1);
    setSpellId2Controller.text = _fmt(itemSet.setSpellId2);
    setSpellId3Controller.text = _fmt(itemSet.setSpellId3);
    setSpellId4Controller.text = _fmt(itemSet.setSpellId4);
    setSpellId5Controller.text = _fmt(itemSet.setSpellId5);
    setSpellId6Controller.text = _fmt(itemSet.setSpellId6);
    setSpellId7Controller.text = _fmt(itemSet.setSpellId7);
    setThreshold0Controller.text = _fmt(itemSet.setThreshold0);
    setThreshold1Controller.text = _fmt(itemSet.setThreshold1);
    setThreshold2Controller.text = _fmt(itemSet.setThreshold2);
    setThreshold3Controller.text = _fmt(itemSet.setThreshold3);
    setThreshold4Controller.text = _fmt(itemSet.setThreshold4);
    setThreshold5Controller.text = _fmt(itemSet.setThreshold5);
    setThreshold6Controller.text = _fmt(itemSet.setThreshold6);
    setThreshold7Controller.text = _fmt(itemSet.setThreshold7);
    requiredSkillController.text = _fmt(itemSet.requiredSkill);
    requiredSkillRankController.text = _fmt(itemSet.requiredSkillRank);
  }
}
