import 'package:flutter/widgets.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class AchievementDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final id = signal<int>(0);
  final faction = signal<int>(0);
  final instanceId = signal<int>(0);
  final supercedes = signal<int>(0);

  /// Title languages
  final titleLangEnUSController = TextEditingController();
  final titleLangKoKRController = TextEditingController();
  final titleLangFrFRController = TextEditingController();
  final titleLangDeDEController = TextEditingController();
  final titleLangZhCNController = TextEditingController();
  final titleLangZhTWController = TextEditingController();
  final titleLangEsESController = TextEditingController();
  final titleLangEsMXController = TextEditingController();
  final titleLangRuRUController = TextEditingController();
  final titleLangJaJPController = TextEditingController();
  final titleLangPtPTController = TextEditingController();
  final titleLangPtBRController = TextEditingController();
  final titleLangItITController = TextEditingController();
  final titleLangUnk1Controller = TextEditingController();
  final titleLangUnk2Controller = TextEditingController();
  final titleLangUnk3Controller = TextEditingController();
  final titleLangFlags = signal<int>(0);

  /// Description languages
  final descriptionLangEnUSController = TextEditingController();
  final descriptionLangKoKRController = TextEditingController();
  final descriptionLangFrFRController = TextEditingController();
  final descriptionLangDeDEController = TextEditingController();
  final descriptionLangZhCNController = TextEditingController();
  final descriptionLangZhTWController = TextEditingController();
  final descriptionLangEsESController = TextEditingController();
  final descriptionLangEsMXController = TextEditingController();
  final descriptionLangRuRUController = TextEditingController();
  final descriptionLangJaJPController = TextEditingController();
  final descriptionLangPtPTController = TextEditingController();
  final descriptionLangPtBRController = TextEditingController();
  final descriptionLangItITController = TextEditingController();
  final descriptionLangUnk1Controller = TextEditingController();
  final descriptionLangUnk2Controller = TextEditingController();
  final descriptionLangUnk3Controller = TextEditingController();
  final descriptionLangFlags = signal<int>(0);

  /// Category / Points / UI / Flags / Icon
  final category = signal<int>(0);
  final points = signal<int>(0);
  final uiOrder = signal<int>(0);
  final flags = signal<int>(0);
  final iconId = signal<int>(0);

  /// Reward languages
  final rewardLangEnUSController = TextEditingController();
  final rewardLangKoKRController = TextEditingController();
  final rewardLangFrFRController = TextEditingController();
  final rewardLangDeDEController = TextEditingController();
  final rewardLangZhCNController = TextEditingController();
  final rewardLangZhTWController = TextEditingController();
  final rewardLangEsESController = TextEditingController();
  final rewardLangEsMXController = TextEditingController();
  final rewardLangRuRUController = TextEditingController();
  final rewardLangJaJPController = TextEditingController();
  final rewardLangPtPTController = TextEditingController();
  final rewardLangPtBRController = TextEditingController();
  final rewardLangItITController = TextEditingController();
  final rewardLangUnk1Controller = TextEditingController();
  final rewardLangUnk2Controller = TextEditingController();
  final rewardLangUnk3Controller = TextEditingController();
  final rewardLangFlags = signal<int>(0);

  /// Minimum / Shares
  final minimumCriteria = signal<int>(0);
  final sharesCriteria = signal<int>(0);

  final achievement = signal(AchievementEntity());

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = AchievementRepository();
      if (t.id == 0) {
        await repository.storeAchievement(t);
      } else {
        await repository.updateAchievement(t);
      }
      achievement.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('成就数据已保存'));
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

  /// 从所有 Controller 收集数据构建 AchievementEntity
  AchievementEntity _collectFromControllers() {
    return AchievementEntity(
      id: id.value,
      faction: faction.value,
      instanceId: instanceId.value,
      supercedes: supercedes.value,
      titleLangEnUS: titleLangEnUSController.text,
      titleLangKoKR: titleLangKoKRController.text,
      titleLangFrFR: titleLangFrFRController.text,
      titleLangDeDE: titleLangDeDEController.text,
      titleLangZhCN: titleLangZhCNController.text,
      titleLangZhTW: titleLangZhTWController.text,
      titleLangEsES: titleLangEsESController.text,
      titleLangEsMX: titleLangEsMXController.text,
      titleLangRuRU: titleLangRuRUController.text,
      titleLangJaJP: titleLangJaJPController.text,
      titleLangPtPT: titleLangPtPTController.text,
      titleLangPtBR: titleLangPtBRController.text,
      titleLangItIT: titleLangItITController.text,
      titleLangUnk1: titleLangUnk1Controller.text,
      titleLangUnk2: titleLangUnk2Controller.text,
      titleLangUnk3: titleLangUnk3Controller.text,
      titleLangFlags: titleLangFlags.value,
      descriptionLangEnUS: descriptionLangEnUSController.text,
      descriptionLangKoKR: descriptionLangKoKRController.text,
      descriptionLangFrFR: descriptionLangFrFRController.text,
      descriptionLangDeDE: descriptionLangDeDEController.text,
      descriptionLangZhCN: descriptionLangZhCNController.text,
      descriptionLangZhTW: descriptionLangZhTWController.text,
      descriptionLangEsES: descriptionLangEsESController.text,
      descriptionLangEsMX: descriptionLangEsMXController.text,
      descriptionLangRuRU: descriptionLangRuRUController.text,
      descriptionLangJaJP: descriptionLangJaJPController.text,
      descriptionLangPtPT: descriptionLangPtPTController.text,
      descriptionLangPtBR: descriptionLangPtBRController.text,
      descriptionLangItIT: descriptionLangItITController.text,
      descriptionLangUnk1: descriptionLangUnk1Controller.text,
      descriptionLangUnk2: descriptionLangUnk2Controller.text,
      descriptionLangUnk3: descriptionLangUnk3Controller.text,
      descriptionLangFlags: descriptionLangFlags.value,
      category: category.value,
      points: points.value,
      uiOrder: uiOrder.value,
      flags: flags.value,
      iconId: iconId.value,
      rewardLangEnUS: rewardLangEnUSController.text,
      rewardLangKoKR: rewardLangKoKRController.text,
      rewardLangFrFR: rewardLangFrFRController.text,
      rewardLangDeDE: rewardLangDeDEController.text,
      rewardLangZhCN: rewardLangZhCNController.text,
      rewardLangZhTW: rewardLangZhTWController.text,
      rewardLangEsES: rewardLangEsESController.text,
      rewardLangEsMX: rewardLangEsMXController.text,
      rewardLangRuRU: rewardLangRuRUController.text,
      rewardLangJaJP: rewardLangJaJPController.text,
      rewardLangPtPT: rewardLangPtPTController.text,
      rewardLangPtBR: rewardLangPtBRController.text,
      rewardLangItIT: rewardLangItITController.text,
      rewardLangUnk1: rewardLangUnk1Controller.text,
      rewardLangUnk2: rewardLangUnk2Controller.text,
      rewardLangUnk3: rewardLangUnk3Controller.text,
      rewardLangFlags: rewardLangFlags.value,
      minimumCriteria: minimumCriteria.value,
      sharesCriteria: sharesCriteria.value,
    );
  }

  void _logActivity(ActivityActionType action, AchievementEntity t) {
    final log = ActivityLogEntity(
      module: 'achievement',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    titleLangEnUSController.dispose();
    titleLangKoKRController.dispose();
    titleLangFrFRController.dispose();
    titleLangDeDEController.dispose();
    titleLangZhCNController.dispose();
    titleLangZhTWController.dispose();
    titleLangEsESController.dispose();
    titleLangEsMXController.dispose();
    titleLangRuRUController.dispose();
    titleLangJaJPController.dispose();
    titleLangPtPTController.dispose();
    titleLangPtBRController.dispose();
    titleLangItITController.dispose();
    titleLangUnk1Controller.dispose();
    titleLangUnk2Controller.dispose();
    titleLangUnk3Controller.dispose();
    descriptionLangEnUSController.dispose();
    descriptionLangKoKRController.dispose();
    descriptionLangFrFRController.dispose();
    descriptionLangDeDEController.dispose();
    descriptionLangZhCNController.dispose();
    descriptionLangZhTWController.dispose();
    descriptionLangEsESController.dispose();
    descriptionLangEsMXController.dispose();
    descriptionLangRuRUController.dispose();
    descriptionLangJaJPController.dispose();
    descriptionLangPtPTController.dispose();
    descriptionLangPtBRController.dispose();
    descriptionLangItITController.dispose();
    descriptionLangUnk1Controller.dispose();
    descriptionLangUnk2Controller.dispose();
    descriptionLangUnk3Controller.dispose();
    rewardLangEnUSController.dispose();
    rewardLangKoKRController.dispose();
    rewardLangFrFRController.dispose();
    rewardLangDeDEController.dispose();
    rewardLangZhCNController.dispose();
    rewardLangZhTWController.dispose();
    rewardLangEsESController.dispose();
    rewardLangEsMXController.dispose();
    rewardLangRuRUController.dispose();
    rewardLangJaJPController.dispose();
    rewardLangPtPTController.dispose();
    rewardLangPtBRController.dispose();
    rewardLangItITController.dispose();
    rewardLangUnk1Controller.dispose();
    rewardLangUnk2Controller.dispose();
    rewardLangUnk3Controller.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      achievement.value = (await AchievementRepository().getAchievement(id))!;
      _initControllers(achievement.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载成就(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(AchievementEntity achievement) {
    id.value = achievement.id;
    faction.value = achievement.faction;
    instanceId.value = achievement.instanceId;
    supercedes.value = achievement.supercedes;
    titleLangEnUSController.text = achievement.titleLangEnUS;
    titleLangKoKRController.text = achievement.titleLangKoKR;
    titleLangFrFRController.text = achievement.titleLangFrFR;
    titleLangDeDEController.text = achievement.titleLangDeDE;
    titleLangZhCNController.text = achievement.titleLangZhCN;
    titleLangZhTWController.text = achievement.titleLangZhTW;
    titleLangEsESController.text = achievement.titleLangEsES;
    titleLangEsMXController.text = achievement.titleLangEsMX;
    titleLangRuRUController.text = achievement.titleLangRuRU;
    titleLangJaJPController.text = achievement.titleLangJaJP;
    titleLangPtPTController.text = achievement.titleLangPtPT;
    titleLangPtBRController.text = achievement.titleLangPtBR;
    titleLangItITController.text = achievement.titleLangItIT;
    titleLangUnk1Controller.text = achievement.titleLangUnk1;
    titleLangUnk2Controller.text = achievement.titleLangUnk2;
    titleLangUnk3Controller.text = achievement.titleLangUnk3;
    titleLangFlags.value = achievement.titleLangFlags;
    descriptionLangEnUSController.text = achievement.descriptionLangEnUS;
    descriptionLangKoKRController.text = achievement.descriptionLangKoKR;
    descriptionLangFrFRController.text = achievement.descriptionLangFrFR;
    descriptionLangDeDEController.text = achievement.descriptionLangDeDE;
    descriptionLangZhCNController.text = achievement.descriptionLangZhCN;
    descriptionLangZhTWController.text = achievement.descriptionLangZhTW;
    descriptionLangEsESController.text = achievement.descriptionLangEsES;
    descriptionLangEsMXController.text = achievement.descriptionLangEsMX;
    descriptionLangRuRUController.text = achievement.descriptionLangRuRU;
    descriptionLangJaJPController.text = achievement.descriptionLangJaJP;
    descriptionLangPtPTController.text = achievement.descriptionLangPtPT;
    descriptionLangPtBRController.text = achievement.descriptionLangPtBR;
    descriptionLangItITController.text = achievement.descriptionLangItIT;
    descriptionLangUnk1Controller.text = achievement.descriptionLangUnk1;
    descriptionLangUnk2Controller.text = achievement.descriptionLangUnk2;
    descriptionLangUnk3Controller.text = achievement.descriptionLangUnk3;
    descriptionLangFlags.value = achievement.descriptionLangFlags;
    category.value = achievement.category;
    points.value = achievement.points;
    uiOrder.value = achievement.uiOrder;
    flags.value = achievement.flags;
    iconId.value = achievement.iconId;
    rewardLangEnUSController.text = achievement.rewardLangEnUS;
    rewardLangKoKRController.text = achievement.rewardLangKoKR;
    rewardLangFrFRController.text = achievement.rewardLangFrFR;
    rewardLangDeDEController.text = achievement.rewardLangDeDE;
    rewardLangZhCNController.text = achievement.rewardLangZhCN;
    rewardLangZhTWController.text = achievement.rewardLangZhTW;
    rewardLangEsESController.text = achievement.rewardLangEsES;
    rewardLangEsMXController.text = achievement.rewardLangEsMX;
    rewardLangRuRUController.text = achievement.rewardLangRuRU;
    rewardLangJaJPController.text = achievement.rewardLangJaJP;
    rewardLangPtPTController.text = achievement.rewardLangPtPT;
    rewardLangPtBRController.text = achievement.rewardLangPtBR;
    rewardLangItITController.text = achievement.rewardLangItIT;
    rewardLangUnk1Controller.text = achievement.rewardLangUnk1;
    rewardLangUnk2Controller.text = achievement.rewardLangUnk2;
    rewardLangUnk3Controller.text = achievement.rewardLangUnk3;
    rewardLangFlags.value = achievement.rewardLangFlags;
    minimumCriteria.value = achievement.minimumCriteria;
    sharesCriteria.value = achievement.sharesCriteria;
  }
}
