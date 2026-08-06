import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/gossip_menu_option_locale_repository.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';

final class SaveGossipMenuOptionInput {
  final GossipMenuOptionKey? originalKey;

  final GossipMenuOptionEntity candidate;
  final GossipMenuOptionLocaleKey? originalLocaleKey;
  final GossipMenuOptionLocaleEntity? localeCandidate;
  const SaveGossipMenuOptionInput({
    required this.originalKey,
    required this.candidate,
    required this.originalLocaleKey,
    required this.localeCandidate,
  });
}

final class SaveGossipMenuOptionResult {
  final GossipMenuOptionKey persistedKey;

  final GossipMenuOptionLocaleKey? localeKey;
  const SaveGossipMenuOptionResult({
    required this.persistedKey,
    required this.localeKey,
  });
}

final class SaveGossipMenuOptionUseCase {
  final DatabaseTransaction _transaction;

  final GossipMenuOptionRepository _optionRepository;
  final GossipMenuOptionLocaleRepository _localeRepository;
  final ActivityLogService _activityLogService;
  SaveGossipMenuOptionUseCase({
    required DatabaseTransaction transaction,
    required GossipMenuOptionRepository optionRepository,
    required GossipMenuOptionLocaleRepository localeRepository,
    required ActivityLogService activityLogService,
  }) : _transaction = transaction,
       _optionRepository = optionRepository,
       _localeRepository = localeRepository,
       _activityLogService = activityLogService;

  Future<SaveGossipMenuOptionResult> execute(
    SaveGossipMenuOptionInput input,
  ) async {
    await _transaction.execute(() async {
      final originalKey = input.originalKey;
      if (originalKey == null) {
        await _optionRepository.storeGossipMenuOption(input.candidate);
      } else {
        await _optionRepository.updateGossipMenuOption(
          originalKey,
          input.candidate,
        );
      }

      final originalLocaleKey = input.originalLocaleKey;
      final localeCandidate = input.localeCandidate;
      if (localeCandidate == null) {
        if (originalLocaleKey != null) {
          await _localeRepository.destroyGossipMenuOptionLocale(
            originalLocaleKey,
          );
        }
      } else if (originalLocaleKey == null) {
        await _localeRepository.storeGossipMenuOptionLocale(localeCandidate);
      } else {
        await _localeRepository.updateGossipMenuOptionLocale(
          originalLocaleKey,
          localeCandidate,
        );
      }
    });

    final persistedKey = GossipMenuOptionKey.fromEntity(input.candidate);
    final localeKey = input.localeCandidate == null
        ? null
        : GossipMenuOptionLocaleKey.fromEntity(input.localeCandidate!);
    _activityLogService.recordBestEffort(
      ActivityLogEntity(
        module: 'gossip_menu_option',
        actionType: input.originalKey == null
            ? ActivityActionType.create
            : ActivityActionType.update,
        entityName:
            'GossipMenuOption ${persistedKey.menuId}/${persistedKey.optionId}',
        createdAt: DateTime.now(),
      ),
    );
    return SaveGossipMenuOptionResult(
      persistedKey: persistedKey,
      localeKey: localeKey,
    );
  }
}
