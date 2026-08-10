import 'package:foxy/constant/game_object_constants.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'game_object_template_detail_view_model.g.dart';

@FoxyDetailViewModel(
  groups: {
    'data0',
    'data1',
    'data10',
    'data11',
    'data12',
    'data13',
    'data14',
    'data15',
    'data16',
    'data17',
    'data18',
    'data19',
    'data2',
    'data20',
    'data21',
    'data22',
    'data23',
    'data3',
    'data4',
    'data5',
    'data6',
    'data7',
    'data8',
    'data9',
  },
  selects: {'type'},
)
class GameObjectTemplateDetailViewModel
    with FieldControllerMixin, _GameObjectTemplateDetailViewModelMixin {
  /// Currently selected GameObject type; drives the Data0..Data23 edit
  /// specs
  final selectedType = signal(0);

  @override
  void dispose() {
    typeController.removeListener(_onTypeChanged);
    disposeControllers();
  }

  @override
  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    typeController.addListener(_onTypeChanged);
    try {
      if (key == null) {
        final blank = await _repository.createGameObjectTemplate();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getGameObjectTemplate(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = FoxyError.message(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  void _onTypeChanged() {
    selectedType.value = typeController.collect();
    _refreshDataFieldEditors();
  }

  void _refreshDataFieldEditors() {
    final type = selectedType.value;
    data0Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 0).editor,
    );
    data1Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 1).editor,
    );
    data2Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 2).editor,
    );
    data3Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 3).editor,
    );
    data4Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 4).editor,
    );
    data5Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 5).editor,
    );
    data6Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 6).editor,
    );
    data7Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 7).editor,
    );
    data8Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 8).editor,
    );
    data9Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 9).editor,
    );
    data10Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 10).editor,
    );
    data11Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 11).editor,
    );
    data12Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 12).editor,
    );
    data13Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 13).editor,
    );
    data14Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 14).editor,
    );
    data15Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 15).editor,
    );
    data16Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 16).editor,
    );
    data17Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 17).editor,
    );
    data18Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 18).editor,
    );
    data19Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 19).editor,
    );
    data20Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 20).editor,
    );
    data21Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 21).editor,
    );
    data22Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 22).editor,
    );
    data23Controller.configure(
      GameObjectConstants.dataFieldSpec(type, 23).editor,
    );
  }
}
