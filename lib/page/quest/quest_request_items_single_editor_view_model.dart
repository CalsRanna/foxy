import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_request_items_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestRequestItemsSingleEditorViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestRequestItemsRepository>();

  final parentKey = signal<int?>(null);
  final editingKey = signal<int?>(null);
  final entity = signal<QuestRequestItemsEntity?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

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

  int _refreshToken = 0;
  int _parentToken = 0;

  Future<void> initSignals({required int parentKey}) {
    return setParentKey(parentKey);
  }

  Future<void> setParentKey(int parentKey) async {
    if (this.parentKey.value == parentKey && entity.value != null) return;
    _parentToken++;
    this.parentKey.value = parentKey;
    editingKey.value = null;
    await _refresh();
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    final parentSnapshot = parentKey.value;
    if (parentSnapshot == null) throw StateError('父记录尚未加载');
    final parentToken = _parentToken;
    final candidate = _collectCandidate();
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeQuestRequestItems(candidate);
      } else {
        await _repository.updateQuestRequestItems(originalKey, candidate);
      }
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.id;
      await _refresh();
    } catch (error) {
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final key = editingKey.value;
    if (key == null) return;
    final parentSnapshot = parentKey.value;
    final parentToken = _parentToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyQuestRequestItems(key);
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      editingKey.value = null;
      await _refresh();
    } catch (error) {
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

QuestRequestItemsEntity _collectCandidate() {
    return QuestRequestItemsEntity(
      id: idController.collect(),
      emoteOnComplete: emoteOnCompleteController.collect(),
      emoteOnIncomplete: emoteOnIncompleteController.collect(),
      completionText: completionTextController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

void _applyCandidate(QuestRequestItemsEntity model) {
    idController.init(model.id);
    emoteOnCompleteController.init(model.emoteOnComplete);
    emoteOnIncompleteController.init(model.emoteOnIncomplete);
    completionTextController.init(model.completionText);
    verifiedBuildController.init(model.verifiedBuild);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentSnapshot = parentKey.value;
    if (parentSnapshot == null) {
      entity.value = null;
      editingKey.value = null;
      return;
    }
    loading.value = true;
    errorMessage.value = null;
    try {
      final existing = await _repository.getQuestRequestItems(parentSnapshot);
      if (token != _refreshToken) return;
      final candidate =
          existing ?? await _repository.createQuestRequestItems(parentSnapshot);
      if (token != _refreshToken) return;
      entity.value = candidate;
      editingKey.value = existing == null ? null : parentSnapshot;
      _applyCandidate(candidate);
    } catch (error, stackTrace) {
      if (token != _refreshToken) return;
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载单行编辑器失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() {
    disposeControllers();
  }
}
