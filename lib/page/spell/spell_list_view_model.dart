import 'package:foxy/entity/brief_spell_entity.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/spell_filter_entity.dart';
import 'package:foxy/entity/spell_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SpellListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final idController = registerController(StringFieldController());
  late final nameController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<SpellRepository>();

  final page = signal(1);
  final spells = signal(<BriefSpellEntity>[]);
  final total = signal(0);

  Future<void> copySpell(SpellKey key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 ${key.id} 的法术？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copySpell(key);
      _logActivity(ActivityActionType.copy, key);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteSpell(SpellKey key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 ${key.id} 的法术？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroySpell(key);
      _logActivity(ActivityActionType.delete, key);
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
        _repository.getBriefSpells(),
        _repository.countSpells(),
      ).wait;
      if (token != _refreshToken) return;
      spells.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载法术列表失败: $e');
      DialogUtil.instance.error('加载法术列表失败: $e');
    }
  }

  void navigateToDetail({SpellKey? key, String? name}) {
    final label = key == null
        ? '新建法术'
        : name?.isNotEmpty == true
        ? name!
        : '法术 #${key.id}';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      label: label,
      route: SpellDetailRoute(spellKey: key),
      parentMenu: RouterMenu.spell,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    idController.init('');
    nameController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  SpellFilterEntity _buildFilter() {
    return SpellFilterEntity(
      id: idController.collect(),
      name: nameController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, SpellKey key) {
    final templates = spells.value;
    final template = templates.where((t) => t.id == key.id).firstOrNull;
    final name = template?.displayName ?? '';
    final log = ActivityLogEntity(
      module: 'spell',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefSpells(page: page.value, filter: filter),
        _repository.countSpells(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      spells.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新法术列表失败: $e');
      DialogUtil.instance.error('刷新法术列表失败: $e');
    }
  }
}
