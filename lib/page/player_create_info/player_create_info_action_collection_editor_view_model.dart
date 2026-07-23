import 'dart:math';
import 'package:foxy/entity/brief_player_create_info_action_entity.dart';
import 'package:foxy/entity/player_create_info_action_key.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_key.dart';
import 'package:foxy/repository/player_create_info_action_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoActionCollectionEditorViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoActionValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoActionRepository>();

  final actionType = signal(0);
  final parentKey = signal<PlayerCreateInfoKey?>(null);
  final items = signal<List<BriefPlayerCreateInfoActionEntity>>([]);
  final editingKey = signal<PlayerCreateInfoActionKey?>(null);
  final selectedKey = signal<PlayerCreateInfoActionKey?>(null);
  final page = signal(1);
  final total = signal(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final raceController = registerController(IntFieldController());
  late final classController = registerController(IntFieldController());
  late final buttonController = registerController(IntFieldController());
  late final actionController = registerController(IntFieldController());
  late final typeController = registerController(IntFieldController());

  int _refreshToken = 0;
  int _interactionToken = 0;

  PlayerCreateInfoActionCollectionEditorViewModel() {
    typeController.addListener(_syncActionType);
  }

  Future<void> initSignals({required PlayerCreateInfoKey parentKey}) =>
      setParentKey(parentKey);

  Future<void> setParentKey(PlayerCreateInfoKey parentKey) async {
    _interactionToken++;
    if (this.parentKey.value != parentKey) page.value = 1;
    this.parentKey.value = parentKey;
    final parent = parentKey;
    editingKey.value = null;
    selectedKey.value = null;
    _applyCandidate(PlayerCreateInfoActionEntity(race: parent.race, class_: parent.class_));
    await _refresh();
  }

  Future<void> create() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createPlayerCreateInfoAction(parent.race, parent.class_);
      if (token != _interactionToken || parentKey.value != parent) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    }
  }

  Future<void> edit(PlayerCreateInfoActionKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getPlayerCreateInfoAction(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      if (candidate == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      editingKey.value = null;
      errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _interactionToken) loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final candidate = _collectCandidate();
    validatePlayerCreateInfoActionFields(candidate);
    final originalKey = editingKey.value;
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storePlayerCreateInfoAction(candidate);
      } else {
        await _repository.updatePlayerCreateInfoAction(originalKey, candidate);
      }
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(PlayerCreateInfoActionKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyPlayerCreateInfoAction(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> paginate(int page) async {
    _interactionToken++;
    this.page.value = page;
    await _refresh();
  }

  PlayerCreateInfoActionEntity _collectCandidate() => PlayerCreateInfoActionEntity(
    race: raceController.collect(),
    class_: classController.collect(),
    button: buttonController.collect(),
    action: actionController.collect(),
    type: typeController.collect(),
  );

  void _applyCandidate(PlayerCreateInfoActionEntity item) {
    raceController.init(item.race);
    classController.init(item.class_);
    buttonController.init(item.button);
    actionController.init(item.action);
    typeController.init(item.type);
    actionType.value = item.type;
  }

  Future<void> _refresh() async {
    final parent = parentKey.value;
    if (parent == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countPlayerCreateInfoActions(parent.race, parent.class_);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefPlayerCreateInfoActions(parent.race, parent.class_, page: nextPage);
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      editingKey.value = null;
      selectedKey.value = null;
    } catch (error) {
      if (token == _refreshToken) errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() {
    typeController.removeListener(_syncActionType);
    disposeControllers();
  }

  void _syncActionType() => actionType.value = typeController.collect();
}
