import 'package:flutter/material.dart';
import 'package:foxy/model/quest_request_items.dart';
import 'package:foxy/repository/quest_request_items_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestRequestItemsViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);

  final idController = TextEditingController();
  final emoteOnCompleteController = TextEditingController();
  final emoteOnIncompleteController = TextEditingController();
  final completionTextController = TextEditingController();

  int _originalId = 0;

  Future<void> initSignals({required int questId}) async {
    this.questId.value = questId;
    final repository = QuestRequestItemsRepository();
    final existing = await repository.find(questId);
    if (existing != null) {
      _originalId = existing.id;
      _applyToControllers(existing);
    } else {
      final blank = await repository.create(questId);
      _applyToControllers(blank);
    }
    idController.text = questId.toString();
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collectFromControllers();
      final repository = QuestRequestItemsRepository();
      if (_originalId == 0) {
        await repository.store(model);
      } else {
        await repository.update(_originalId, model);
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

  void _applyToControllers(QuestRequestItems model) {
    idController.text = model.id.toString();
    emoteOnCompleteController.text = model.emoteOnComplete.toString();
    emoteOnIncompleteController.text = model.emoteOnIncomplete.toString();
    completionTextController.text = model.completionText;
  }

  QuestRequestItems _collectFromControllers() {
    final model = QuestRequestItems();
    model.id = questId.value;
    model.emoteOnComplete = _parseInt(emoteOnCompleteController.text);
    model.emoteOnIncomplete = _parseInt(emoteOnIncompleteController.text);
    model.completionText = completionTextController.text;
    return model;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

  void dispose() {
    idController.dispose();
    emoteOnCompleteController.dispose();
    emoteOnIncompleteController.dispose();
    completionTextController.dispose();
  }
}