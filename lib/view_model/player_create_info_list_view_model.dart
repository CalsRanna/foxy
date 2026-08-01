import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoListViewModel with FieldControllerMixin, QueryVersionMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoRepository>();

  final items = signal<List<BriefPlayerCreateInfoEntity>>([]);

  @override
  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final raceController = registerController(StringFieldController());

  late final classController = registerController(StringFieldController());

  int _refreshToken = 0;

  Future<void> destroy(PlayerCreateInfoKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyPlayerCreateInfo(key);
      _logActivity(ActivityActionType.delete, key);
      normalizePageAfterDelete(total.value - 1);
      await _refresh();
    } catch (error) {
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals() async {
    await _refresh();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    markQueryVersion();
    await _refresh();
  }

  Future<void> reset() async {
    raceController.init('');
    classController.init('');
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    markQueryVersion();
    await _refresh();
  }

  PlayerCreateInfoFilter _collectFilter() {
    return PlayerCreateInfoFilter(
      race: raceController.collect(),
      class_: classController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, PlayerCreateInfoKey key) {
    final log = ActivityLogEntity(
      module: 'player_create_info',
      actionType: action,
      entityName: 'PlayerCreateInfo ${key.race}/${key.class_}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final filter = _collectFilter();
    final currentPage = page.value;
    loading.value = true;
    errorMessage.value = null;
    try {
      final (nextItems, nextTotal) = await (
        _repository.getBriefPlayerCreateInfos(
          filter: filter,
          page: currentPage,
        ),
        _repository.countPlayerCreateInfos(filter: filter),
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
}
