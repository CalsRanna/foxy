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
  final id = signal<int>(0);
  final tabId = signal<int>(0);
  final tierId = signal<int>(0);
  final columnIndex = signal<int>(0);
  final flags = signal<int>(0);
  final requiredSpellId = signal<int>(0);
  final spellRank0 = signal<int>(0);
  final spellRank1 = signal<int>(0);
  final spellRank2 = signal<int>(0);
  final spellRank3 = signal<int>(0);
  final spellRank4 = signal<int>(0);
  final spellRank5 = signal<int>(0);
  final spellRank6 = signal<int>(0);
  final spellRank7 = signal<int>(0);
  final spellRank8 = signal<int>(0);
  final prereqTalent0 = signal<int>(0);
  final prereqTalent1 = signal<int>(0);
  final prereqTalent2 = signal<int>(0);
  final prereqRank0 = signal<int>(0);
  final prereqRank1 = signal<int>(0);
  final prereqRank2 = signal<int>(0);
  final categoryMask0 = signal<int>(0);
  final categoryMask1 = signal<int>(0);

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
      id: id.value,
      tabId: tabId.value,
      tierId: tierId.value,
      columnIndex: columnIndex.value,
      spellRank0: spellRank0.value,
      spellRank1: spellRank1.value,
      spellRank2: spellRank2.value,
      spellRank3: spellRank3.value,
      spellRank4: spellRank4.value,
      spellRank5: spellRank5.value,
      spellRank6: spellRank6.value,
      spellRank7: spellRank7.value,
      spellRank8: spellRank8.value,
      prereqTalent0: prereqTalent0.value,
      prereqTalent1: prereqTalent1.value,
      prereqTalent2: prereqTalent2.value,
      prereqRank0: prereqRank0.value,
      prereqRank1: prereqRank1.value,
      prereqRank2: prereqRank2.value,
      flags: flags.value,
      requiredSpellId: requiredSpellId.value,
      categoryMask0: categoryMask0.value,
      categoryMask1: categoryMask1.value,
    );
  }

  void dispose() {}

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
    id.value = talent.id;
    tabId.value = talent.tabId;
    tierId.value = talent.tierId;
    columnIndex.value = talent.columnIndex;
    spellRank0.value = talent.spellRank0;
    spellRank1.value = talent.spellRank1;
    spellRank2.value = talent.spellRank2;
    spellRank3.value = talent.spellRank3;
    spellRank4.value = talent.spellRank4;
    spellRank5.value = talent.spellRank5;
    spellRank6.value = talent.spellRank6;
    spellRank7.value = talent.spellRank7;
    spellRank8.value = talent.spellRank8;
    prereqTalent0.value = talent.prereqTalent0;
    prereqTalent1.value = talent.prereqTalent1;
    prereqTalent2.value = talent.prereqTalent2;
    prereqRank0.value = talent.prereqRank0;
    prereqRank1.value = talent.prereqRank1;
    prereqRank2.value = talent.prereqRank2;
    flags.value = talent.flags;
    requiredSpellId.value = talent.requiredSpellId;
    categoryMask0.value = talent.categoryMask0;
    categoryMask1.value = talent.categoryMask1;
  }
}
