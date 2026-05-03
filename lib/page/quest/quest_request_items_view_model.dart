import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/repository/quest_request_items_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestRequestItemsViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);

  final id = signal<int>(0);
  final emoteOnComplete = signal<int>(0);
  final emoteOnIncomplete = signal<int>(0);
  final completionTextController = TextEditingController();

  int _originalId = 0;

  Future<void> initSignals({required int questId}) async {
    try {
      this.questId.value = questId;
      final repository = QuestRequestItemsRepository();
      final existing = await repository.getQuestRequestItems(questId);
      if (existing != null) {
        _originalId = existing.id;
        _applyToSignals(existing);
      } else {
        final blank = await repository.createQuestRequestItems(questId);
        _applyToSignals(blank);
      }
      id.value = questId;
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collect();
      final repository = QuestRequestItemsRepository();
      if (_originalId == 0) {
        await repository.storeQuestRequestItems(model);
      } else {
        await repository.updateQuestRequestItems(_originalId, model);
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

  void _applyToSignals(QuestRequestItemsEntity model) {
    emoteOnComplete.value = model.emoteOnComplete;
    emoteOnIncomplete.value = model.emoteOnIncomplete;
    completionTextController.text = model.completionText;
  }

  QuestRequestItemsEntity _collect() {
    return QuestRequestItemsEntity(
      id: questId.value,
      emoteOnComplete: emoteOnComplete.value,
      emoteOnIncomplete: emoteOnIncomplete.value,
      completionText: completionTextController.text,
    );
  }

  void dispose() {
    completionTextController.dispose();
  }
}
