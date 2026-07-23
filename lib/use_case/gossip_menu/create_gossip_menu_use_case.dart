import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';

final class CreateGossipMenuInput {
  const CreateGossipMenuInput({
    required this.candidate,
    required this.reservedTextId,
  });

  final GossipMenuEntity candidate;
  final int? reservedTextId;
}

final class CreateGossipMenuUseCase {
  CreateGossipMenuUseCase({
    required DatabaseTransaction transaction,
    required GossipMenuRepository gossipMenuRepository,
    required NpcTextRepository npcTextRepository,
    required ActivityLogService activityLogService,
  }) : _transaction = transaction,
       _gossipMenuRepository = gossipMenuRepository,
       _npcTextRepository = npcTextRepository,
       _activityLogService = activityLogService;

  final DatabaseTransaction _transaction;
  final GossipMenuRepository _gossipMenuRepository;
  final NpcTextRepository _npcTextRepository;
  final ActivityLogService _activityLogService;

  Future<void> execute(CreateGossipMenuInput input) async {
    final candidate = input.candidate;
    await _transaction.execute(() async {
      if (candidate.textId == input.reservedTextId) {
        await _npcTextRepository.storeNpcText(
          NpcTextEntity(id: candidate.textId),
        );
      }
      await _gossipMenuRepository.storeGossipMenu(candidate);
    });
    _activityLogService.recordBestEffort(
      ActivityLogEntity(
        module: 'gossip_menu',
        actionType: ActivityActionType.create,
        entityName: 'GossipMenu ${candidate.menuId}/${candidate.textId}',
        createdAt: DateTime.now(),
      ),
    );
  }
}
