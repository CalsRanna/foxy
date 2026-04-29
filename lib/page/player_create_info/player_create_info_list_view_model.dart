import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log.dart';
import 'package:foxy/entity/player_create_info.dart';
import 'package:foxy/entity/player_create_info_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoListViewModel {
  final raceController = TextEditingController();
  final classController = TextEditingController();
  final repository = PlayerCreateInfoRepository();

  final page = signal(1);
  final infos = signal<List<PlayerCreateInfo>>([]);
  final total = signal(0);

  final _routerFacade = GetIt.instance.get<RouterFacade>();

  Future<void> initSignals() async {
    infos.value = await _search();
    total.value = await _count();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> reset() async {
    raceController.clear();
    classController.clear();
    page.value = 1;
    infos.value = await _search();
    total.value = await _count();
  }

  Future<void> paginate(int newPage) async {
    page.value = newPage;
    await _refresh();
  }

  void navigateToDetail({PlayerCreateInfo? info}) {
    final id = info != null ? 'pci_${info.race}_${info.class_}' : 'pci_new';
    final label = info != null ? '种族${info.race}-职业${info.class_}' : '新建出生信息';
    _routerFacade.navigateToDetail(
      id: id,
      label: label,
      route: PlayerCreateInfoDetailRoute(
        race: info?.race,
        playerClass: info?.class_,
        label: label,
      ),
      parentMenu: RouterMenu.more,
    );
  }

  Future<void> copyPlayerCreateInfo(PlayerCreateInfo info) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制该出生信息记录？class 将自动+1。',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyPlayerCreateInfo(info.buildCredential());
      _logActivity(ActivityActionType.copy, info.race);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deletePlayerCreateInfo(PlayerCreateInfo info) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除该出生信息记录？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyPlayerCreateInfo(info.buildCredential());
      _logActivity(ActivityActionType.delete, info.race);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final log = ActivityLog(
      module: 'player_create_info',
      actionType: action,
      entityId: id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  PlayerCreateInfoFilterEntity _buildFilter() {
    return PlayerCreateInfoFilterEntity(
      race: raceController.text,
      class_: classController.text,
    );
  }

  Future<List<PlayerCreateInfo>> _search() async {
    return repository.getPlayerCreateInfos(
      filter: _buildFilter(),
      page: page.value,
    );
  }

  Future<int> _count() async {
    return repository.countPlayerCreateInfos(filter: _buildFilter());
  }

  Future<void> _refresh() async {
    infos.value = await _search();
    total.value = await _count();
  }

  void dispose() {
    raceController.dispose();
    classController.dispose();
  }
}
