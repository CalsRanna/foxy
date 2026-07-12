import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/repository/quest_request_items_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestRequestItemsViewModel {
  final _repository = GetIt.instance.get<QuestRequestItemsRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);

  final idController = IntFieldController();
  final emoteOnCompleteController = IntFieldController();
  final emoteOnIncompleteController = IntFieldController();
  final completionTextController = StringFieldController();

  late final _controllers = <FieldController>[
    idController,
    emoteOnCompleteController,
    emoteOnIncompleteController,
    completionTextController,
  ];

  int _originalId = 0;

  Future<void> initSignals({required int questId}) async {
    try {
      this.questId.value = questId;
      final existing = await _repository.getQuestRequestItems(questId);
      if (existing != null) {
        _originalId = existing.id;
        _initSignals(existing);
      } else {
        final blank = await _repository.createQuestRequestItems(questId);
        _initSignals(blank);
      }
      idController.init(questId);
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collect();
      if (_originalId == 0) {
        await _repository.storeQuestRequestItems(model);
      } else {
        await _repository.updateQuestRequestItems(_originalId, model);
      }
      _originalId = model.id;

      if (!context.mounted) return;
      var toast = ShadToast(description: Text('提交物品数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void _initSignals(QuestRequestItemsEntity model) {
    emoteOnCompleteController.init(model.emoteOnComplete);
    emoteOnIncompleteController.init(model.emoteOnIncomplete);
    completionTextController.init(model.completionText);
  }

  QuestRequestItemsEntity _collect() {
    return QuestRequestItemsEntity(
      id: questId.value,
      emoteOnComplete: emoteOnCompleteController.collect(),
      emoteOnIncomplete: emoteOnIncompleteController.collect(),
      completionText: completionTextController.collect(),
    );
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }
}
