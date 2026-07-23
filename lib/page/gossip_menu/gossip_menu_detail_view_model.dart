import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/use_case/gossip_menu/create_gossip_menu_use_case.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GossipMenuDetailViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<GossipMenuRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();
  final _npcTextRepository = GetIt.instance.get<NpcTextRepository>();
  final _createUseCase = GetIt.instance.get<CreateGossipMenuUseCase>();

  final entity = signal<GossipMenuEntity?>(null);
  final persistedKey = signal<GossipMenuKey?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final menuIdController = registerController(IntFieldController());
  late final textIdController = registerController(IntFieldController());

  int? _reservedTextId;

  Future<void> initSignals({GossipMenuKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final reservedText = await _npcTextRepository.createNpcText();
        final blank = (await _repository.createGossipMenu()).copyWith(
          textId: reservedText.id,
        );
        _reservedTextId = reservedText.id;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final existing = await _repository.getGossipMenu(key);
      if (existing == null) {
        throw StateError('原对话菜单不存在，可能已被其他操作修改或删除');
      }
      entity.value = existing;
      _applyCandidate(existing);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      if (candidate.menuId <= 0) throw StateError('请输入有效的 MenuID');
      if (candidate.textId <= 0) throw StateError('请选择有效的 NPC 文本');
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
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  GossipMenuEntity _collectCandidate() {
    return GossipMenuEntity(
      menuId: menuIdController.collect(),
      textId: textIdController.collect(),
    );
  }

  void _applyCandidate(GossipMenuEntity candidate) {
    menuIdController.init(candidate.menuId);
    textIdController.init(candidate.textId);
  }

  void _logActivity(ActivityActionType action, GossipMenuEntity t) {
    final log = ActivityLogEntity(
      module: 'gossip_menu',
      actionType: action,
      entityName: 'GossipMenu ${t.menuId}/${t.textId}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
