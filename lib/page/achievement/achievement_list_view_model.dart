import 'package:foxy/entity/achievement_filter_entity.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class AchievementListViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<AchievementRepository>();

  final items = signal(<BriefAchievementEntity>[]);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final entryController = registerController(StringFieldController());

  late final titleController = registerController(StringFieldController());

  int _refreshToken = 0;

  Future<void> initSignals() async {
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    titleController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> copy(int key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyAchievement(key);
      _logActivity(ActivityActionType.copy, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(int key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyAchievement(key);
      _logActivity(ActivityActionType.delete, key);
      await _refresh();
    } catch (error) {
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  AchievementFilterEntity _collectFilter() {
    return AchievementFilterEntity(
      id: entryController.collect(),
      title: titleController.collect(),
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
        _repository.getBriefAchievements(page: currentPage, filter: filter),
        _repository.countAchievements(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      items.value = nextItems;
      total.value = nextTotal;
    } catch (error) {
      if (token != _refreshToken) return;
      LoggerUtil.instance.e('刷新列表失败: $error');
      errorMessage.value = '刷新列表失败: $error';
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'achievement',
      actionType: action,
      entityName: 'Achievement $key',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
