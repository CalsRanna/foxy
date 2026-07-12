import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:foxy/repository/quest_request_items_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestRequestItemsViewModel {
  final _repository = GetIt.instance.get<QuestRequestItemsRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);

  final idController = TextEditingController();
  final emoteOnCompleteController = TextEditingController();
  final emoteOnIncompleteController = TextEditingController();
  final completionTextController = TextEditingController();

  int _originalId = 0;

  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);

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
      idController.text = _fmt(questId);
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
    emoteOnCompleteController.text = _fmt(model.emoteOnComplete);
    emoteOnIncompleteController.text = _fmt(model.emoteOnIncomplete);
    completionTextController.text = model.completionText;
  }

  QuestRequestItemsEntity _collect() {
    return QuestRequestItemsEntity(
      id: questId.value,
      emoteOnComplete: _pi(emoteOnCompleteController.text),
      emoteOnIncomplete: _pi(emoteOnIncompleteController.text),
      completionText: completionTextController.text,
    );
  }

  void dispose() {
    completionTextController.dispose();
    emoteOnCompleteController.dispose();
    emoteOnIncompleteController.dispose();
    idController.dispose();
  }
}
