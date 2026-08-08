import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/use_case/gossip_menu/create_gossip_menu_use_case.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'gossip_menu_detail_view_model.g.dart';

@FoxyDetailViewModel()
class GossipMenuDetailViewModel
    with FieldControllerMixin, _GossipMenuDetailViewModelMixin {
  final _npcTextRepository = GetIt.instance.get<NpcTextRepository>();
  final _createUseCase = GetIt.instance.get<CreateGossipMenuUseCase>();

  int? _reservedTextId;

  @override
  Future<void> initSignals({GossipMenuKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final reservedText = await _npcTextRepository.createNpcText();
        final blank = (await _repository.createGossipMenu()).copyWith(
          textId: reservedText.id,
        );
        if (isDisposed) return;
        _reservedTextId = reservedText.id;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final existing = await _repository.getGossipMenu(key);
      if (existing == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = existing;
      _applyCandidate(existing);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  @override
  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      if (candidate.menuId <= 0) throw ValidationException('invalid MenuID');
      if (candidate.textId <= 0) {
        throw ValidationException('invalid NPC text selection');
      }
      // The reserved text row of the create path (backfilled by
      // CreateGossipMenuUseCase) need not pre-exist; all other paths (edit,
      // or changing textId to another value after creation) must point at a
      // real npc_text row, otherwise core loads the menu with empty text
      // after persisting.
      if (candidate.textId != _reservedTextId) {
        final text = await _npcTextRepository.getNpcText(candidate.textId);
        if (text == null) {
          throw ValidationException(
            'NPC text does not exist: ${candidate.textId}',
          );
        }
      }
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _createUseCase.execute(
          CreateGossipMenuInput(
            candidate: candidate,
            reservedTextId: _reservedTextId,
          ),
        );
      } else {
        await _repository.updateGossipMenu(originalKey, candidate);
      }
      persistedKey.value = GossipMenuKey.fromEntity(candidate);
      entity.value = candidate;
      if (action == ActivityActionType.update) {
        _logActivity(action, candidate);
      }
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }
}
