import 'package:foxy/util/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class CreatureTemplateListViewModel {
  int _refreshToken = 0;
  final entryController = StringFieldController();
  final nameController = StringFieldController();
  final subNameController = StringFieldController();

  late final _controllers = <FieldController>[
    entryController,
    nameController,
    subNameController,
  ];
  final _repository = GetIt.instance.get<CreatureTemplateRepository>();

  final page = signal(1);
  final templates = signal(<BriefCreatureTemplateEntity>[]);
  final total = signal(0);

  Future<void> copyCreatureTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $entry 的生物模板？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyCreatureTemplate(entry);
      _logActivity(ActivityActionType.copy, entry);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteCreatureTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $entry 的生物模板？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyCreatureTemplate(entry);
      _logActivity(ActivityActionType.delete, entry);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }

  Future<void> initSignals() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (
        _repository.getBriefCreatureTemplates(),
        _repository.countCreatureTemplates(),
      ).wait;
      if (token != _refreshToken) return;
      templates.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载生物列表失败: $e');
      DialogUtil.instance.error('加载生物列表失败: $e');
    }
  }

  void navigateToDetail({int? entry, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建生物';
    final id = entry != null ? 'creature_$entry' : 'creature_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: id,
      label: label,
      route: CreatureTemplateDetailRoute(entry: entry, name: name),
      parentMenu: RouterMenu.creatureTemplate,
    );
  }

  CreatureTemplateFilterEntity _buildFilter() {
    return CreatureTemplateFilterEntity(
      entry: entryController.collect(),
      name: nameController.collect(),
      subName: subNameController.collect(),
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    nameController.init('');
    subNameController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefCreatureTemplates(page: page.value, filter: filter),
        _repository.countCreatureTemplates(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      templates.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新生物列表失败: $e');
      DialogUtil.instance.error('刷新生物列表失败: $e');
    }
  }

  void _logActivity(ActivityActionType action, int entry) {
    final templates = this.templates.value;
    final template = templates.where((t) => t.entry == entry).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLogEntity(
      module: 'creature_template',
      actionType: action,
      entityId: entry,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
