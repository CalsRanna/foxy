import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_option_key.dart';
import 'package:foxy/entity/gossip_menu_option_locale_key.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/gossip_menu_option_locale_repository.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';

final class DestroyGossipMenuOptionUseCase {
  DestroyGossipMenuOptionUseCase({
    required DatabaseTransaction transaction,
    required GossipMenuOptionRepository optionRepository,
    required GossipMenuOptionLocaleRepository localeRepository,
    required ActivityLogService activityLogService,
  }) : _transaction = transaction,
       _optionRepository = optionRepository,
       _localeRepository = localeRepository,
       _activityLogService = activityLogService;

  final DatabaseTransaction _transaction;
  final GossipMenuOptionRepository _optionRepository;
  final GossipMenuOptionLocaleRepository _localeRepository;
  final ActivityLogService _activityLogService;

  Future<void> execute(GossipMenuOptionKey key) async {
    await _transaction.execute(() async {
      final locales = await _localeRepository
          .getGossipMenuOptionLocalesForOption(key);
      for (final locale in locales) {
        await _localeRepository.destroyGossipMenuOptionLocale(
          GossipMenuOptionLocaleKey.fromEntity(locale),
        );
      }
      await _optionRepository.destroyGossipMenuOption(key);
    });
    _activityLogService.recordBestEffort(
      ActivityLogEntity(
        module: 'gossip_menu_option',
        actionType: ActivityActionType.delete,
        entityName: 'GossipMenuOption ${key.menuId}/${key.optionId}',
        createdAt: DateTime.now(),
      ),
    );
  }
}
