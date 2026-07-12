import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class TalentDetailViewModel {
  final _repository = GetIt.instance.get<TalentRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
  final tabIdController = TextEditingController();
  final tierIdController = TextEditingController();
  final columnIndexController = TextEditingController();
  final flagsController = TextEditingController();
  final requiredSpellIdController = TextEditingController();
  final spellRank0Controller = TextEditingController();
  final spellRank1Controller = TextEditingController();
  final spellRank2Controller = TextEditingController();
  final spellRank3Controller = TextEditingController();
  final spellRank4Controller = TextEditingController();
  final spellRank5Controller = TextEditingController();
  final spellRank6Controller = TextEditingController();
  final spellRank7Controller = TextEditingController();
  final spellRank8Controller = TextEditingController();
  final prereqTalent0Controller = TextEditingController();
  final prereqTalent1Controller = TextEditingController();
  final prereqTalent2Controller = TextEditingController();
  final prereqRank0Controller = TextEditingController();
  final prereqRank1Controller = TextEditingController();
  final prereqRank2Controller = TextEditingController();
  final categoryMask0Controller = TextEditingController();
  final categoryMask1Controller = TextEditingController();

  final talent = signal(TalentEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        final id = await _repository.storeTalent(t);
        idController.text = '$id';
      } else {
        await _repository.updateTalent(t);
      }
      talent.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('天赋数据已保存'));
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

  /// 从所有 Controller 收集数据构建 Talent
  TalentEntity _collectFromControllers() {
    return TalentEntity(
      id: _pi(idController.text),
      tabId: _pi(tabIdController.text),
      tierId: _pi(tierIdController.text),
      columnIndex: _pi(columnIndexController.text),
      spellRank0: _pi(spellRank0Controller.text),
      spellRank1: _pi(spellRank1Controller.text),
      spellRank2: _pi(spellRank2Controller.text),
      spellRank3: _pi(spellRank3Controller.text),
      spellRank4: _pi(spellRank4Controller.text),
      spellRank5: _pi(spellRank5Controller.text),
      spellRank6: _pi(spellRank6Controller.text),
      spellRank7: _pi(spellRank7Controller.text),
      spellRank8: _pi(spellRank8Controller.text),
      prereqTalent0: _pi(prereqTalent0Controller.text),
      prereqTalent1: _pi(prereqTalent1Controller.text),
      prereqTalent2: _pi(prereqTalent2Controller.text),
      prereqRank0: _pi(prereqRank0Controller.text),
      prereqRank1: _pi(prereqRank1Controller.text),
      prereqRank2: _pi(prereqRank2Controller.text),
      flags: _pi(flagsController.text),
      requiredSpellId: _pi(requiredSpellIdController.text),
      categoryMask0: _pi(categoryMask0Controller.text),
      categoryMask1: _pi(categoryMask1Controller.text),
    );
  }

  void dispose() {
    categoryMask0Controller.dispose();
    categoryMask1Controller.dispose();
    columnIndexController.dispose();
    flagsController.dispose();
    idController.dispose();
    prereqRank0Controller.dispose();
    prereqRank1Controller.dispose();
    prereqRank2Controller.dispose();
    prereqTalent0Controller.dispose();
    prereqTalent1Controller.dispose();
    prereqTalent2Controller.dispose();
    requiredSpellIdController.dispose();
    spellRank0Controller.dispose();
    spellRank1Controller.dispose();
    spellRank2Controller.dispose();
    spellRank3Controller.dispose();
    spellRank4Controller.dispose();
    spellRank5Controller.dispose();
    spellRank6Controller.dispose();
    spellRank7Controller.dispose();
    spellRank8Controller.dispose();
    tabIdController.dispose();
    tierIdController.dispose();
  }

  void _logActivity(ActivityActionType action, TalentEntity t) {
    final log = ActivityLogEntity(
      module: 'talent',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      talent.value = (await _repository.getTalent(id))!;
      _initControllers(talent.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载天赋(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(TalentEntity talent) {
    idController.text = _fmt(talent.id);
    tabIdController.text = _fmt(talent.tabId);
    tierIdController.text = _fmt(talent.tierId);
    columnIndexController.text = _fmt(talent.columnIndex);
    spellRank0Controller.text = _fmt(talent.spellRank0);
    spellRank1Controller.text = _fmt(talent.spellRank1);
    spellRank2Controller.text = _fmt(talent.spellRank2);
    spellRank3Controller.text = _fmt(talent.spellRank3);
    spellRank4Controller.text = _fmt(talent.spellRank4);
    spellRank5Controller.text = _fmt(talent.spellRank5);
    spellRank6Controller.text = _fmt(talent.spellRank6);
    spellRank7Controller.text = _fmt(talent.spellRank7);
    spellRank8Controller.text = _fmt(talent.spellRank8);
    prereqTalent0Controller.text = _fmt(talent.prereqTalent0);
    prereqTalent1Controller.text = _fmt(talent.prereqTalent1);
    prereqTalent2Controller.text = _fmt(talent.prereqTalent2);
    prereqRank0Controller.text = _fmt(talent.prereqRank0);
    prereqRank1Controller.text = _fmt(talent.prereqRank1);
    prereqRank2Controller.text = _fmt(talent.prereqRank2);
    flagsController.text = _fmt(talent.flags);
    requiredSpellIdController.text = _fmt(talent.requiredSpellId);
    categoryMask0Controller.text = _fmt(talent.categoryMask0);
    categoryMask1Controller.text = _fmt(talent.categoryMask1);
  }
}
