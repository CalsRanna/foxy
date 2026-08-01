import 'package:foxy/constant/game_object_constants.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'game_object_template_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: GameObjectTemplateEntity, groups: {'data0', 'data1', 'data10', 'data11', 'data12', 'data13', 'data14', 'data15', 'data16', 'data17', 'data18', 'data19', 'data2', 'data20', 'data21', 'data22', 'data23', 'data3', 'data4', 'data5', 'data6', 'data7', 'data8', 'data9'}, selects: {'type': 0})
class GameObjectTemplateDetailViewModel
    with
        FieldControllerMixin, _GameObjectTemplateDetailViewModelMixin {
  final _repository = GetIt.instance.get<GameObjectTemplateRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<GameObjectTemplateEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// 当前选中的 GameObject 类型，驱动 Data0..Data23 的编辑规格
  final selectedType = signal(0);

  void dispose() {
    typeController.removeListener(_onTypeChanged);
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    typeController.addListener(_onTypeChanged);
    try {
      if (key == null) {
        final blank = await _repository.createGameObjectTemplate();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getGameObjectTemplate(key);
      if (result == null) {
        throw StateError('原游戏对象模板不存在，可能已被其他操作修改或删除');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeGameObjectTemplate(candidate);
      } else {
        await _repository.updateGameObjectTemplate(originalKey, candidate);
      }
      persistedKey.value = candidate.entry;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _logActivity(ActivityActionType action, GameObjectTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'gameobject_template',
      actionType: action,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void _onTypeChanged() {
    selectedType.value = typeController.collect();
    _refreshDataFieldEditors();
  }

  void _refreshDataFieldEditors() {
    final type = selectedType.value;
    data0Controller.configure(gameObjectDataFieldSpec(type, 0).editor);
    data1Controller.configure(gameObjectDataFieldSpec(type, 1).editor);
    data2Controller.configure(gameObjectDataFieldSpec(type, 2).editor);
    data3Controller.configure(gameObjectDataFieldSpec(type, 3).editor);
    data4Controller.configure(gameObjectDataFieldSpec(type, 4).editor);
    data5Controller.configure(gameObjectDataFieldSpec(type, 5).editor);
    data6Controller.configure(gameObjectDataFieldSpec(type, 6).editor);
    data7Controller.configure(gameObjectDataFieldSpec(type, 7).editor);
    data8Controller.configure(gameObjectDataFieldSpec(type, 8).editor);
    data9Controller.configure(gameObjectDataFieldSpec(type, 9).editor);
    data10Controller.configure(gameObjectDataFieldSpec(type, 10).editor);
    data11Controller.configure(gameObjectDataFieldSpec(type, 11).editor);
    data12Controller.configure(gameObjectDataFieldSpec(type, 12).editor);
    data13Controller.configure(gameObjectDataFieldSpec(type, 13).editor);
    data14Controller.configure(gameObjectDataFieldSpec(type, 14).editor);
    data15Controller.configure(gameObjectDataFieldSpec(type, 15).editor);
    data16Controller.configure(gameObjectDataFieldSpec(type, 16).editor);
    data17Controller.configure(gameObjectDataFieldSpec(type, 17).editor);
    data18Controller.configure(gameObjectDataFieldSpec(type, 18).editor);
    data19Controller.configure(gameObjectDataFieldSpec(type, 19).editor);
    data20Controller.configure(gameObjectDataFieldSpec(type, 20).editor);
    data21Controller.configure(gameObjectDataFieldSpec(type, 21).editor);
    data22Controller.configure(gameObjectDataFieldSpec(type, 22).editor);
    data23Controller.configure(gameObjectDataFieldSpec(type, 23).editor);
  }
}
