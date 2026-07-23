import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/npc_text_locale_key.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/npc_text_locale_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';

final class DestroyNpcTextInput {
  const DestroyNpcTextInput({required this.key, required this.localeKey});

  final int key;
  final NpcTextLocaleKey? localeKey;
}

final class DestroyNpcTextUseCase {
  DestroyNpcTextUseCase({
    required DatabaseTransaction transaction,
    required NpcTextRepository npcTextRepository,
    required NpcTextLocaleRepository localeRepository,
    required ActivityLogService activityLogService,
  }) : _transaction = transaction,
       _npcTextRepository = npcTextRepository,
       _localeRepository = localeRepository,
       _activityLogService = activityLogService;

  final DatabaseTransaction _transaction;
  final NpcTextRepository _npcTextRepository;
  final NpcTextLocaleRepository _localeRepository;
  final ActivityLogService _activityLogService;

  Future<void> execute(DestroyNpcTextInput input) async {
    await _transaction.execute(() async {
      final localeKey = input.localeKey;
      if (localeKey != null) {
        await _localeRepository.destroyNpcTextLocale(localeKey);
      }
      await _npcTextRepository.destroyNpcText(input.key);
    });
    _activityLogService.recordBestEffort(
      ActivityLogEntity(
        module: 'npc_text',
        actionType: ActivityActionType.delete,
        entityName: 'NpcText ${input.key}',
        createdAt: DateTime.now(),
      ),
    );
  }
}
