import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_emote_text_entity.dart';
import 'package:foxy/entity/emote_text_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class EmoteTextListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());
  late final nameController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<EmoteTextRepository>();

  final page = signal(1);
  final emotes = signal(<BriefEmoteTextEntity>[]);
  final total = signal(0);

  Future<void> copyEmoteText(int key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $key 的表情文本？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyEmoteText(key);
      _logActivity(ActivityActionType.copy, key);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteEmoteText(int key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $key 的表情文本？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyEmoteText(key);
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
        _repository.getBriefEmoteTexts(page: 1),
        _repository.countEmoteTexts(),
      ).wait;
      if (token != _refreshToken) return;
      emotes.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载表情文本列表失败: $e');
      DialogUtil.instance.error('加载表情文本列表失败: $e');
    }
  }

  void navigateToDetail({int? key, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建表情文本';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      label: label,
      route: EmoteTextDetailRoute(emoteTextKey: key),
      parentMenu: RouterMenu.emoteText,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    nameController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  EmoteTextFilterEntity _buildFilter() {
    return EmoteTextFilterEntity(
      id: entryController.collect(),
      name: nameController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, int key) {
    final templates = emotes.value;
    final template = templates.where((t) => t.key == key).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLogEntity(
      module: 'emote_text',
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
        _repository.getBriefEmoteTexts(page: page.value, filter: filter),
        _repository.countEmoteTexts(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      emotes.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新表情文本列表失败: $e');
      DialogUtil.instance.error('刷新表情文本列表失败: $e');
    }
  }
}
