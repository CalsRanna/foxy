import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
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
    final existing = await repository.getQuestRequestItems(questId);
    if (existing != null) {
      _originalId = existing.id;
      _applyToControllers(existing);
    } else {
      final blank = await repository.createQuestRequestItems(questId);
      _applyToControllers(blank);
    }
    idController.text = questId.toString();
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collectFromControllers();
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

  void _applyToControllers(QuestRequestItemsEntity model) {
    idController.text = model.id.toString();
    emoteOnCompleteController.text = model.emoteOnComplete.toString();
    emoteOnIncompleteController.text = model.emoteOnIncomplete.toString();
    completionTextController.text = model.completionText;
  }

  QuestRequestItemsEntity _collectFromControllers() {
    return QuestRequestItemsEntity(
      id: questId.value,
      emoteOnComplete: _parseInt(emoteOnCompleteController.text),
      emoteOnIncomplete: _parseInt(emoteOnIncompleteController.text),
      completionText: completionTextController.text,
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void dispose() {
    idController.dispose();
    emoteOnCompleteController.dispose();
    emoteOnIncompleteController.dispose();
    completionTextController.dispose();
  }
}
