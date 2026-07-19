import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/entity/glyph_property_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GlyphPropertyListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<GlyphPropertyRepository>();

  final page = signal(1);
  final properties = signal(<BriefGlyphPropertyEntity>[]);
  final total = signal(0);

  Future<void> copyGlyphProperty(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的雕文属性？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyGlyphProperty(id);
      _logActivity(ActivityActionType.copy, id);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteGlyphProperty(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的雕文属性？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyGlyphProperty(id);
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
      final filter = GlyphPropertyFilterEntity();
      final (items, count) = await (
        _repository.getBriefGlyphProperties(page: 1, filter: filter),
        _repository.countGlyphProperties(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      properties.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载雕文属性列表失败: $e');
      DialogUtil.instance.error('加载雕文属性列表失败: $e');
    }
  }

  void navigateToDetail({int? id}) {
    final label = id != null ? '雕文属性 #$id' : '新建雕文属性';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      label: label,
      route: GlyphPropertyDetailRoute(id: id),
      parentMenu: RouterMenu.glyphProperty,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  GlyphPropertyFilterEntity _buildFilter() {
    return GlyphPropertyFilterEntity(id: entryController.collect());
  }

  void _logActivity(ActivityActionType action, int id) {
    final log = ActivityLogEntity(
      module: 'glyph_property',
      actionType: action,
      entityName: 'GlyphProperty $id',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefGlyphProperties(page: page.value, filter: filter),
        _repository.countGlyphProperties(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      properties.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新雕文属性列表失败: $e');
      DialogUtil.instance.error('刷新雕文属性列表失败: $e');
    }
  }
}
