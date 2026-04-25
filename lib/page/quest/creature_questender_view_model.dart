import 'package:flutter/widgets.dart';
import 'package:foxy/model/creature_questender.dart';
import 'package:foxy/repository/creature_questender_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureQuestenderViewModel {
  final _repository = CreatureQuestenderRepository();

  final currentQuestId = signal(0);
  final items = signal<List<BriefCreatureQuestender>>([]);
  final loading = signal(false);
  final saving = signal(false);
  final editing = signal(false);
  final creating = signal(false);

  // Form controllers
  final idController = TextEditingController();
  final questController = TextEditingController();

  int _originalId = 0;
  int _originalQuest = 0;

  Future<void> search(int questId) async {
    loading.value = true;
    try {
      currentQuestId.value = questId;
      items.value = await _repository.search(questId);
    } finally {
      loading.value = false;
    }
  }

  Future<void> onCreate() async {
    final blank = await _repository.create(currentQuestId.value);
    _applyToControllers(blank);
    _originalId = blank.id;
    _originalQuest = blank.quest;
    creating.value = true;
    editing.value = false;
  }

  Future<void> onEdit(int id, int quest) async {
    final existing = await _repository.find({'id': id, 'quest': quest});
    if (existing == null) return;
    _applyToControllers(existing);
    _originalId = id;
    _originalQuest = quest;
    creating.value = false;
    editing.value = true;
  }

  Future<void> onSave() async {
    saving.value = true;
    try {
      final model = _collectFromControllers();
      if (creating.value) {
        await _repository.store(model);
      } else {
        await _repository.update(
          {'id': _originalId, 'quest': _originalQuest},
          model,
        );
      }
      DialogUtil.instance.success('保存成功');
      creating.value = false;
      editing.value = false;
      await search(currentQuestId.value);
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('保存失败: ${e.toString()}');
    } finally {
      saving.value = false;
    }
  }

  void onCancel() {
    creating.value = false;
    editing.value = false;
  }

  Future<void> onCopy(int id, int quest) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '此操作不会复制关联表数据，确认继续？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await _repository.copy({'id': id, 'quest': quest});
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await search(currentQuestId.value);
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> onDestroy(int id, int quest) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '将永久删除该记录，确认继续？',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await _repository.destroy({'id': id, 'quest': quest});
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await search(currentQuestId.value);
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void _applyToControllers(CreatureQuestender model) {
    idController.text = model.id.toString();
    questController.text = model.quest.toString();
  }

  CreatureQuestender _collectFromControllers() {
    final model = CreatureQuestender();
    model.id = int.tryParse(idController.text) ?? 0;
    model.quest = int.tryParse(questController.text) ?? 0;
    return model;
  }

  void dispose() {
    idController.dispose();
    questController.dispose();
  }
}