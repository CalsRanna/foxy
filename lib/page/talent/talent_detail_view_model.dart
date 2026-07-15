import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/talent_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class TalentDetailViewModel
    with ViewModelValidationMixin, TalentValidationMixin, FieldControllerMixin {
  final _repository = GetIt.instance.get<TalentRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  late final idController = registerController(IntFieldController());
  late final tabIdController = registerController(IntFieldController());
  late final tierIdController = registerController(IntFieldController());
  late final columnIndexController = registerController(IntFieldController());
  late final flagsController = registerController(IntFieldController());
  late final requiredSpellIdController = registerController(
    IntFieldController(),
  );
  late final spellRank0Controller = registerController(IntFieldController());
  late final spellRank1Controller = registerController(IntFieldController());
  late final spellRank2Controller = registerController(IntFieldController());
  late final spellRank3Controller = registerController(IntFieldController());
  late final spellRank4Controller = registerController(IntFieldController());
  late final spellRank5Controller = registerController(IntFieldController());
  late final spellRank6Controller = registerController(IntFieldController());
  late final spellRank7Controller = registerController(IntFieldController());
  late final spellRank8Controller = registerController(IntFieldController());
  late final prereqTalent0Controller = registerController(IntFieldController());
  late final prereqTalent1Controller = registerController(IntFieldController());
  late final prereqTalent2Controller = registerController(IntFieldController());
  late final prereqRank0Controller = registerController(IntFieldController());
  late final prereqRank1Controller = registerController(IntFieldController());
  late final prereqRank2Controller = registerController(IntFieldController());
  late final categoryMask0Controller = registerController(IntFieldController());
  late final categoryMask1Controller = registerController(IntFieldController());

  final talent = signal(TalentEntity());

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      validateTalentFields(t);
      final existed = await _repository.getTalent(t.id);
      late final TalentEntity saved;
      if (existed == null) {
        final id = await _repository.storeTalent(t);
        idController.init(id);
        saved = t.copyWith(id: id);
      } else {
        await _repository.updateTalent(t);
        saved = t;
      }
      talent.value = saved;
      _logActivity(
        existed == null ? ActivityActionType.create : ActivityActionType.update,
        saved,
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
      id: idController.collect(),
      tabId: tabIdController.collect(),
      tierId: tierIdController.collect(),
      columnIndex: columnIndexController.collect(),
      spellRank0: spellRank0Controller.collect(),
      spellRank1: spellRank1Controller.collect(),
      spellRank2: spellRank2Controller.collect(),
      spellRank3: spellRank3Controller.collect(),
      spellRank4: spellRank4Controller.collect(),
      spellRank5: spellRank5Controller.collect(),
      spellRank6: spellRank6Controller.collect(),
      spellRank7: spellRank7Controller.collect(),
      spellRank8: spellRank8Controller.collect(),
      prereqTalent0: prereqTalent0Controller.collect(),
      prereqTalent1: prereqTalent1Controller.collect(),
      prereqTalent2: prereqTalent2Controller.collect(),
      prereqRank0: prereqRank0Controller.collect(),
      prereqRank1: prereqRank1Controller.collect(),
      prereqRank2: prereqRank2Controller.collect(),
      flags: flagsController.collect(),
      requiredSpellId: requiredSpellIdController.collect(),
      categoryMask0: categoryMask0Controller.collect(),
      categoryMask1: categoryMask1Controller.collect(),
    );
  }

  void dispose() {
    disposeControllers();
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
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createTalent();
        talent.value = blank;
        _initControllers(blank);
        return;
      }
      talent.value = (await _repository.getTalent(id))!;
      _initControllers(talent.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载天赋(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(TalentEntity talent) {
    idController.init(talent.id);
    tabIdController.init(talent.tabId);
    tierIdController.init(talent.tierId);
    columnIndexController.init(talent.columnIndex);
    spellRank0Controller.init(talent.spellRank0);
    spellRank1Controller.init(talent.spellRank1);
    spellRank2Controller.init(talent.spellRank2);
    spellRank3Controller.init(talent.spellRank3);
    spellRank4Controller.init(talent.spellRank4);
    spellRank5Controller.init(talent.spellRank5);
    spellRank6Controller.init(talent.spellRank6);
    spellRank7Controller.init(talent.spellRank7);
    spellRank8Controller.init(talent.spellRank8);
    prereqTalent0Controller.init(talent.prereqTalent0);
    prereqTalent1Controller.init(talent.prereqTalent1);
    prereqTalent2Controller.init(talent.prereqTalent2);
    prereqRank0Controller.init(talent.prereqRank0);
    prereqRank1Controller.init(talent.prereqRank1);
    prereqRank2Controller.init(talent.prereqRank2);
    flagsController.init(talent.flags);
    requiredSpellIdController.init(talent.requiredSpellId);
    categoryMask0Controller.init(talent.categoryMask0);
    categoryMask1Controller.init(talent.categoryMask1);
  }
}
