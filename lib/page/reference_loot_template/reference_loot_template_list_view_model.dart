import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/reference_loot_template_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/reference_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ReferenceLootTemplateListViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<ReferenceLootTemplateRepository>();

  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final items = signal<List<BriefReferenceLootTemplateEntity>>([]);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final entryController = registerController(StringFieldController());

  late final nameController = registerController(StringFieldController());

  int _refreshToken = 0;

  Future<void> initSignals() => _refresh();

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    nameController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> copy(ReferenceLootTemplateKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyLootTemplate(key);
      _logActivity(ActivityActionType.copy, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(ReferenceLootTemplateKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyReferenceLootTemplate(key);
      _logActivity(ActivityActionType.delete, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  ReferenceLootTemplateFilter _collectFilter() {
    return ReferenceLootTemplateFilter(
      entry: entryController.collect(),
      name: nameController.collect(),
    );
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final filter = _collectFilter();
    final currentPage = page.value;
    loading.value = true;
    errorMessage.value = null;
    try {
      final (nextItems, nextTotal) = await (
        _repository.getBriefLootTemplateRows(filter: filter, page: currentPage),
        _repository.countLootTemplateRows(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      items.value = nextItems;
      total.value = nextTotal;
    } catch (error) {
      if (token != _refreshToken) return;
      LoggerUtil.instance.e('刷新引用掉落模板列表失败: $error');
      errorMessage.value = '刷新引用掉落模板列表失败: $error';
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void _logActivity(ActivityActionType action, ReferenceLootTemplateKey key) {
    _activityLogService.recordBestEffort(
      ActivityLogEntity(
        module: 'reference_loot_template',
        actionType: action,
        entityName: 'ReferenceLoot ${key.entry}/${key.item}',
        createdAt: DateTime.now(),
      ),
    );
  }

  void dispose() => disposeControllers();
}
