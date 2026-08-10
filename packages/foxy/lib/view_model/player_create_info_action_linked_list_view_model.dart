import 'dart:math';

import 'package:foxy/entity/player_create_info_action_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/player_create_info_action_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'player_create_info_action_linked_list_view_model.g.dart';

@FoxyDetailViewModel(selects: {'class_', 'race', 'type'}, skeleton: false)
class PlayerCreateInfoActionLinkedListViewModel
    with FieldControllerMixin, _PlayerCreateInfoActionLinkedListViewModelMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoActionRepository>();

  final actionType = signal(0);
  final linkKey = signal<PlayerCreateInfoKey?>(null);
  final items = signal<List<BriefPlayerCreateInfoActionEntity>>([]);
  final editingKey = signal<PlayerCreateInfoActionKey?>(null);
  final selectedKey = signal<PlayerCreateInfoActionKey?>(null);
  final page = signal(1);
  final total = signal(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  int _refreshToken = 0;
  int _interactionToken = 0;

  PlayerCreateInfoActionLinkedListViewModel() {
    typeController.addListener(_syncActionType);
  }

  Future<void> create() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createPlayerCreateInfoAction(
        link.race,
        link.class_,
      );
      if (token != _interactionToken || linkKey.value != link) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyError.message(error);
      rethrow;
    }
  }

  Future<void> destroy(PlayerCreateInfoActionKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyPlayerCreateInfoAction(key);
      if (token != _interactionToken || linkKey.value != link) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() {
    typeController.removeListener(_syncActionType);
    disposeControllers();
  }

  Future<void> edit(PlayerCreateInfoActionKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getPlayerCreateInfoAction(key);
      if (token != _interactionToken || linkKey.value != link) return;
      if (candidate == null) {
        throw RecordNotFoundException('record not found');
      }
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      editingKey.value = null;
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      if (token == _interactionToken) loading.value = false;
    }
  }

  Future<void> initSignals({required PlayerCreateInfoKey linkKey}) =>
      setLinkKey(linkKey);

  Future<void> paginate(int page) async {
    _interactionToken++;
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final candidate = _collectCandidate();
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
      if (token != _interactionToken || linkKey.value != link) return;
      _logActivity(
        originalKey == null
            ? ActivityActionType.create
            : ActivityActionType.update,
        candidate,
      );
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> setLinkKey(PlayerCreateInfoKey linkKey) async {
    _interactionToken++;
    if (this.linkKey.value != linkKey) page.value = 1;
    this.linkKey.value = linkKey;
    final link = linkKey;
    editingKey.value = null;
    selectedKey.value = null;
    _applyCandidate(
      PlayerCreateInfoActionEntity(race: link.race, class_: link.class_),
    );
    await _refresh();
  }

  Future<void> _refresh() async {
    final link = linkKey.value;
    if (link == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countPlayerCreateInfoActions(
        link.race,
        link.class_,
      );
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefPlayerCreateInfoActions(
        link.race,
        link.class_,
        page: nextPage,
      );
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      editingKey.value = null;
      selectedKey.value = null;
    } catch (error) {
      if (token == _refreshToken) errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void _syncActionType() => actionType.value = typeController.collect();
}
