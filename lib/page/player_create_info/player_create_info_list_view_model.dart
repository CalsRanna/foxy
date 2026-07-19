import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final raceController = registerController(StringFieldController());
  late final classController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<PlayerCreateInfoRepository>();

  final page = signal(1);
  final infos = signal<List<BriefPlayerCreateInfoEntity>>([]);
  final total = signal(0);

  final _routerFacade = GetIt.instance.get<RouterFacade>();

  Future<void> deletePlayerCreateInfo(BriefPlayerCreateInfoEntity info) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除该出生信息记录？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyPlayerCreateInfo(info.key);
      _logActivity(ActivityActionType.delete, info);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (_search(), _count()).wait;
      if (token != _refreshToken) return;
      infos.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载角色创建信息列表失败: $e');
      DialogUtil.instance.error('加载角色创建信息列表失败: $e');
    }
  }

  void navigateToDetail({BriefPlayerCreateInfoEntity? info}) {
    final label = info != null ? '种族${info.race}-职业${info.class_}' : '新建出生信息';
    _routerFacade.navigateToDetail(
      label: label,
      route: PlayerCreateInfoDetailRoute(playerCreateInfoKey: info?.key),
      parentMenu: RouterMenu.more,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    raceController.init('');
    classController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  PlayerCreateInfoFilterEntity _buildFilter() {
    return PlayerCreateInfoFilterEntity(
      race: raceController.collect(),
      class_: classController.collect(),
    );
  }

  Future<int> _count() async {
    return _repository.countPlayerCreateInfos(filter: _buildFilter());
  }

  void _logActivity(
    ActivityActionType action,
    BriefPlayerCreateInfoEntity info,
  ) {
    final log = ActivityLogEntity(
      module: 'player_create_info',
      actionType: action,
      entityName: 'PlayerCreateInfo ${info.race}/${info.class_}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (_search(), _count()).wait;
      if (token != _refreshToken) return;
      infos.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新角色创建信息列表失败: $e');
      DialogUtil.instance.error('刷新角色创建信息列表失败: $e');
    }
  }

  Future<List<BriefPlayerCreateInfoEntity>> _search() async {
    return _repository.getBriefPlayerCreateInfos(
      filter: _buildFilter(),
      page: page.value,
    );
  }
}
