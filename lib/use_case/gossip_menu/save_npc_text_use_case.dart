import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/npc_text_locale_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';

final class SaveNpcTextInput {
  const SaveNpcTextInput({
    required this.originalKey,
    required this.candidate,
    required this.originalLocaleKey,
    required this.localeCandidate,
  });

  final int? originalKey;
  final NpcTextEntity candidate;
  final NpcTextLocaleKey? originalLocaleKey;
  final NpcTextLocaleEntity? localeCandidate;
}

final class SaveNpcTextResult {
  const SaveNpcTextResult({
    required this.persistedKey,
    required this.localeKey,
  });

  final int persistedKey;
  final NpcTextLocaleKey? localeKey;
}

final class SaveNpcTextUseCase {
  SaveNpcTextUseCase({
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

  Future<SaveNpcTextResult> execute(SaveNpcTextInput input) async {
    final candidate = input.candidate;
    final localeCandidate = input.localeCandidate;
    await _transaction.execute(() async {
      final originalKey = input.originalKey;
      if (originalKey == null) {
        await _npcTextRepository.storeNpcText(candidate);
      } else {
        await _npcTextRepository.updateNpcText(originalKey, candidate);
      }

      final originalLocaleKey = input.originalLocaleKey;
      if (localeCandidate != null) {
        if (originalLocaleKey == null) {
          await _localeRepository.storeNpcTextLocale(localeCandidate);
        } else {
          await _localeRepository.updateNpcTextLocale(
            originalLocaleKey,
            localeCandidate,
          );
        }
      } else if (originalLocaleKey != null) {
        await _localeRepository.destroyNpcTextLocale(originalLocaleKey);
      }
    });

    _activityLogService.recordBestEffort(
      ActivityLogEntity(
        module: 'npc_text',
        actionType: input.originalKey == null
            ? ActivityActionType.create
            : ActivityActionType.update,
        entityName: 'NpcText ${candidate.id}',
        createdAt: DateTime.now(),
      ),
    );
    return SaveNpcTextResult(
      persistedKey: candidate.id,
      localeKey: localeCandidate == null
          ? null
          : NpcTextLocaleKey.fromEntity(localeCandidate),
    );
  }
}
