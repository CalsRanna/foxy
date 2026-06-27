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
  final _repository = GetIt.instance.get<AchievementRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
  final factionController = TextEditingController();
  final instanceIdController = TextEditingController();
  final supercedesController = TextEditingController();

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
  final categoryController = TextEditingController();
  final pointsController = TextEditingController();
  final uiOrderController = TextEditingController();
  final flagsController = TextEditingController();
  final iconIdController = TextEditingController();

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
  final minimumCriteriaController = TextEditingController();
  final sharesCriteriaController = TextEditingController();

  final achievement = signal(AchievementEntity());

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
        await _repository.storeAchievement(t);
      } else {
        await _repository.updateAchievement(t);
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
      id: _pi(idController.text),
      faction: _pi(factionController.text),
      instanceId: _pi(instanceIdController.text),
      supercedes: _pi(supercedesController.text),
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
      category: _pi(categoryController.text),
      points: _pi(pointsController.text),
      uiOrder: _pi(uiOrderController.text),
      flags: _pi(flagsController.text),
      iconId: _pi(iconIdController.text),
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
      minimumCriteria: _pi(minimumCriteriaController.text),
      sharesCriteria: _pi(sharesCriteriaController.text),
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
    categoryController.dispose();
    descriptionLangDeDEController.dispose();
    descriptionLangEnUSController.dispose();
    descriptionLangEsESController.dispose();
    descriptionLangEsMXController.dispose();
    descriptionLangFrFRController.dispose();
    descriptionLangItITController.dispose();
    descriptionLangJaJPController.dispose();
    descriptionLangKoKRController.dispose();
    descriptionLangPtBRController.dispose();
    descriptionLangPtPTController.dispose();
    descriptionLangRuRUController.dispose();
    descriptionLangUnk1Controller.dispose();
    descriptionLangUnk2Controller.dispose();
    descriptionLangUnk3Controller.dispose();
    descriptionLangZhCNController.dispose();
    descriptionLangZhTWController.dispose();
    factionController.dispose();
    flagsController.dispose();
    iconIdController.dispose();
    idController.dispose();
    instanceIdController.dispose();
    minimumCriteriaController.dispose();
    pointsController.dispose();
    rewardLangDeDEController.dispose();
    rewardLangEnUSController.dispose();
    rewardLangEsESController.dispose();
    rewardLangEsMXController.dispose();
    rewardLangFrFRController.dispose();
    rewardLangItITController.dispose();
    rewardLangJaJPController.dispose();
    rewardLangKoKRController.dispose();
    rewardLangPtBRController.dispose();
    rewardLangPtPTController.dispose();
    rewardLangRuRUController.dispose();
    rewardLangUnk1Controller.dispose();
    rewardLangUnk2Controller.dispose();
    rewardLangUnk3Controller.dispose();
    rewardLangZhCNController.dispose();
    rewardLangZhTWController.dispose();
    sharesCriteriaController.dispose();
    supercedesController.dispose();
    titleLangDeDEController.dispose();
    titleLangEnUSController.dispose();
    titleLangEsESController.dispose();
    titleLangEsMXController.dispose();
    titleLangFrFRController.dispose();
    titleLangItITController.dispose();
    titleLangJaJPController.dispose();
    titleLangKoKRController.dispose();
    titleLangPtBRController.dispose();
    titleLangPtPTController.dispose();
    titleLangRuRUController.dispose();
    titleLangUnk1Controller.dispose();
    titleLangUnk2Controller.dispose();
    titleLangUnk3Controller.dispose();
    titleLangZhCNController.dispose();
    titleLangZhTWController.dispose();
    uiOrderController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      achievement.value = (await _repository.getAchievement(id))!;
      _initControllers(achievement.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载成就(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(AchievementEntity achievement) {
    idController.text = _fmt(achievement.id);
    factionController.text = _fmt(achievement.faction);
    instanceIdController.text = _fmt(achievement.instanceId);
    supercedesController.text = _fmt(achievement.supercedes);
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
    categoryController.text = _fmt(achievement.category);
    pointsController.text = _fmt(achievement.points);
    uiOrderController.text = _fmt(achievement.uiOrder);
    flagsController.text = _fmt(achievement.flags);
    iconIdController.text = _fmt(achievement.iconId);
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
    minimumCriteriaController.text = _fmt(achievement.minimumCriteria);
    sharesCriteriaController.text = _fmt(achievement.sharesCriteria);
  }
}
