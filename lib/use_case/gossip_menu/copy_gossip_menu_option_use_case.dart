import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/gossip_menu_option_locale_repository.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';

final class CopyGossipMenuOptionUseCase {
  CopyGossipMenuOptionUseCase({
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

  Future<GossipMenuOptionKey> execute(GossipMenuOptionKey sourceKey) async {
    GossipMenuOptionKey? targetKey;
    await _transaction.execute(() async {
      final source = await _optionRepository.getGossipMenuOption(sourceKey);
      if (source == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      final blank = await _optionRepository.createGossipMenuOption(
        source.menuId,
      );
      final candidate = source.copyWith(optionId: blank.optionId);
      await _optionRepository.storeGossipMenuOption(candidate);
      final nextKey = GossipMenuOptionKey.fromEntity(candidate);
      targetKey = nextKey;

      final locales = await _localeRepository
          .getGossipMenuOptionLocalesForOption(sourceKey);
      for (final locale in locales) {
        await _localeRepository.storeGossipMenuOptionLocale(
          locale.copyWith(menuId: nextKey.menuId, optionId: nextKey.optionId),
        );
      }
    });
    final result = targetKey!;
    _activityLogService.recordBestEffort(
      ActivityLogEntity(
        module: 'gossip_menu_option',
        actionType: ActivityActionType.copy,
        entityName: 'GossipMenuOption ${result.menuId}/${result.optionId}',
        createdAt: DateTime.now(),
      ),
    );
    return result;
  }
}
