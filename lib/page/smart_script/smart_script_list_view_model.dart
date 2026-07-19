import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_smart_script_entity.dart';
import 'package:foxy/entity/smart_script_filter_entity.dart';
import 'package:foxy/entity/smart_script_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SmartScriptListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryOrGuidController = registerController(
    StringFieldController(),
  );
  late final commentController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<SmartScriptRepository>();

  final page = signal(1);
  final scripts = signal(<BriefSmartScriptEntity>[]);
  final total = signal(0);

  Future<void> copySmartScript(SmartScriptKey key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制该脚本行（entryorguid=${key.entryOrGuid}, id=${key.id}）？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copySmartScript(key);
      _logActivity(ActivityActionType.copy, key);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteSmartScript(SmartScriptKey key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description:
            '是否删除脚本行（entryorguid=${key.entryOrGuid}, id=${key.id}）？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroySmartScript(key);
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
        _repository.getBriefSmartScripts(),
        _repository.countSmartScripts(),
      ).wait;
      if (token != _refreshToken) return;
      scripts.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载SmartAI脚本列表失败: $e');
      DialogUtil.instance.error('加载SmartAI脚本列表失败: $e');
    }
  }

  void navigateToDetail({SmartScriptKey? key}) {
    final routerFacade = GetIt.instance.get<RouterFacade>();
    final label = key == null
        ? '新建脚本'
        : '脚本 ${key.entryOrGuid}/${key.sourceType}/${key.id}/${key.link}';
    routerFacade.navigateToDetail(
      label: label,
      route: SmartScriptDetailRoute(scriptKey: key),
      parentMenu: RouterMenu.smartScript,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryOrGuidController.init('');
    commentController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  SmartScriptFilterEntity _buildFilter() {
    return SmartScriptFilterEntity(
      entryOrGuid: entryOrGuidController.collect(),
      comment: commentController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, SmartScriptKey key) {
    final templates = scripts.value;
    final template = templates.where((t) => t.key == key).firstOrNull;
    final name = template?.comment ?? '';
    final log = ActivityLogEntity(
      module: 'smart_script',
      actionType: action,
      entityName:
          'SmartScript ${key.entryOrGuid}/${key.sourceType}/${key.id}/${key.link}'
          '${name.isEmpty ? '' : ' - $name'}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefSmartScripts(page: page.value, filter: filter),
        _repository.countSmartScripts(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      scripts.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新SmartAI脚本列表失败: $e');
      DialogUtil.instance.error('刷新SmartAI脚本列表失败: $e');
    }
  }
}
