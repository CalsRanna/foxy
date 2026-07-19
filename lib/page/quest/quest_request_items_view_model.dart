import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/entity/quest_request_items_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_request_items_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestRequestItemsViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestRequestItemsRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final editingKey = signal<QuestRequestItemsKey?>(null);

  late final idController = registerController(IntFieldController());
  late final emoteOnCompleteController = registerController(
    IntFieldController(),
  );
  late final emoteOnIncompleteController = registerController(
    IntFieldController(),
  );
  late final completionTextController = registerController(
    StringFieldController(),
  );
  late final verifiedBuildController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({required int questId}) async {
    try {
      final key = QuestRequestItemsKey(id: questId);
      final existing = await _repository.getQuestRequestItems(key);
      if (existing != null) {
        editingKey.value = key;
        _initSignals(existing);
      } else {
        editingKey.value = null;
        final blank = await _repository.createQuestRequestItems(questId);
        _initSignals(blank);
      }
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collect();
      final originalKey = editingKey.value;
      if (originalKey == null) {
        await _repository.storeQuestRequestItems(model);
      } else {
        await _repository.updateQuestRequestItems(originalKey, model);
      }
      editingKey.value = QuestRequestItemsKey.fromEntity(model);

      if (!context.mounted) return;
      var toast = ShadToast(description: Text('提交物品数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  QuestRequestItemsEntity _collect() {
    return QuestRequestItemsEntity(
      id: idController.collect(),
      emoteOnComplete: emoteOnCompleteController.collect(),
      emoteOnIncomplete: emoteOnIncompleteController.collect(),
      completionText: completionTextController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _initSignals(QuestRequestItemsEntity model) {
    idController.init(model.id);
    emoteOnCompleteController.init(model.emoteOnComplete);
    emoteOnIncompleteController.init(model.emoteOnIncomplete);
    completionTextController.init(model.completionText);
    verifiedBuildController.init(model.verifiedBuild);
  }
}
