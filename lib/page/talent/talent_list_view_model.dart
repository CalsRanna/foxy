import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/entity/talent_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class TalentListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());
  late final spellController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<TalentRepository>();

  final page = signal(1);
  final talents = signal(<BriefTalentEntity>[]);
  final total = signal(0);

  Future<void> copyTalent(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的天赋？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyTalent(id);
      _logActivity(ActivityActionType.copy, id);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteTalent(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的天赋？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyTalent(id);
      _logActivity(ActivityActionType.delete, id);
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
      final (items, count) = await (
        _repository.getBriefTalents(),
        _repository.countTalents(),
      ).wait;
      if (token != _refreshToken) return;
      talents.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载天赋列表失败: $e');
      DialogUtil.instance.error('加载天赋列表失败: $e');
    }
  }

  void navigateToDetail({int? id}) {
    final label = id != null ? '天赋 #$id' : '新建天赋';
    final routeId = id != null ? 'talent_$id' : 'talent_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: TalentDetailRoute(id: id),
      parentMenu: RouterMenu.talent,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    spellController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  TalentFilterEntity _buildFilter() {
    return TalentFilterEntity(
      id: entryController.collect(),
      spell: spellController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, int id) {
    final log = ActivityLogEntity(
      module: 'talent',
      actionType: action,
      entityId: id,
      entityName: id.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefTalents(page: page.value, filter: filter),
        _repository.countTalents(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      talents.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新天赋列表失败: $e');
      DialogUtil.instance.error('刷新天赋列表失败: $e');
    }
  }
}
