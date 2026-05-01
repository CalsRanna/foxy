import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class TalentDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
  final tabIdController = TextEditingController();
  final tierIdController = TextEditingController();
  final columnIndexController = TextEditingController();
  final flagsController = TextEditingController();
  final requiredSpellIdController = TextEditingController();

  /// SpellRank
  final spellRank0Controller = TextEditingController();
  final spellRank1Controller = TextEditingController();
  final spellRank2Controller = TextEditingController();
  final spellRank3Controller = TextEditingController();
  final spellRank4Controller = TextEditingController();
  final spellRank5Controller = TextEditingController();
  final spellRank6Controller = TextEditingController();
  final spellRank7Controller = TextEditingController();
  final spellRank8Controller = TextEditingController();

  /// PrereqTalent
  final prereqTalent0Controller = TextEditingController();
  final prereqTalent1Controller = TextEditingController();
  final prereqTalent2Controller = TextEditingController();

  /// PrereqRank
  final prereqRank0Controller = TextEditingController();
  final prereqRank1Controller = TextEditingController();
  final prereqRank2Controller = TextEditingController();

  /// CategoryMask
  final categoryMask0Controller = TextEditingController();
  final categoryMask1Controller = TextEditingController();

  final talent = signal(TalentEntity());

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = TalentRepository();
      if (t.id == 0) {
        await repository.storeTalent(t);
      } else {
        await repository.updateTalent(t);
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
      id: _parseInt(idController.text),
      tabId: _parseInt(tabIdController.text),
      tierId: _parseInt(tierIdController.text),
      columnIndex: _parseInt(columnIndexController.text),
      spellRank0: _parseInt(spellRank0Controller.text),
      spellRank1: _parseInt(spellRank1Controller.text),
      spellRank2: _parseInt(spellRank2Controller.text),
      spellRank3: _parseInt(spellRank3Controller.text),
      spellRank4: _parseInt(spellRank4Controller.text),
      spellRank5: _parseInt(spellRank5Controller.text),
      spellRank6: _parseInt(spellRank6Controller.text),
      spellRank7: _parseInt(spellRank7Controller.text),
      spellRank8: _parseInt(spellRank8Controller.text),
      prereqTalent0: _parseInt(prereqTalent0Controller.text),
      prereqTalent1: _parseInt(prereqTalent1Controller.text),
      prereqTalent2: _parseInt(prereqTalent2Controller.text),
      prereqRank0: _parseInt(prereqRank0Controller.text),
      prereqRank1: _parseInt(prereqRank1Controller.text),
      prereqRank2: _parseInt(prereqRank2Controller.text),
      flags: _parseInt(flagsController.text),
      requiredSpellId: _parseInt(requiredSpellIdController.text),
      categoryMask0: _parseInt(categoryMask0Controller.text),
      categoryMask1: _parseInt(categoryMask1Controller.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, TalentEntity t) {
    final log = ActivityLogEntity(
      module: 'talent',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    idController.dispose();
    tabIdController.dispose();
    tierIdController.dispose();
    columnIndexController.dispose();
    flagsController.dispose();
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
    prereqTalent0Controller.dispose();
    prereqTalent1Controller.dispose();
    prereqTalent2Controller.dispose();
    prereqRank0Controller.dispose();
    prereqRank1Controller.dispose();
    prereqRank2Controller.dispose();
    categoryMask0Controller.dispose();
    categoryMask1Controller.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      talent.value = (await TalentRepository().getTalent(id))!;
      _initControllers(talent.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载天赋(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(TalentEntity talent) {
    idController.text = talent.id.toString();
    tabIdController.text = talent.tabId.toString();
    tierIdController.text = talent.tierId.toString();
    columnIndexController.text = talent.columnIndex.toString();
    spellRank0Controller.text = talent.spellRank0.toString();
    spellRank1Controller.text = talent.spellRank1.toString();
    spellRank2Controller.text = talent.spellRank2.toString();
    spellRank3Controller.text = talent.spellRank3.toString();
    spellRank4Controller.text = talent.spellRank4.toString();
    spellRank5Controller.text = talent.spellRank5.toString();
    spellRank6Controller.text = talent.spellRank6.toString();
    spellRank7Controller.text = talent.spellRank7.toString();
    spellRank8Controller.text = talent.spellRank8.toString();
    prereqTalent0Controller.text = talent.prereqTalent0.toString();
    prereqTalent1Controller.text = talent.prereqTalent1.toString();
    prereqTalent2Controller.text = talent.prereqTalent2.toString();
    prereqRank0Controller.text = talent.prereqRank0.toString();
    prereqRank1Controller.text = talent.prereqRank1.toString();
    prereqRank2Controller.text = talent.prereqRank2.toString();
    flagsController.text = talent.flags.toString();
    requiredSpellIdController.text = talent.requiredSpellId.toString();
    categoryMask0Controller.text = talent.categoryMask0.toString();
    categoryMask1Controller.text = talent.categoryMask1.toString();
  }
}
