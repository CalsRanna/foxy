import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';

final class ActivityLogService {
  final ActivityLogRepository _repository;

  ActivityLogService(this._repository);

  void recordBestEffort(ActivityLogEntity log) {
    try {
      _repository.storeActivityLogBestEffort(log);
    } catch (_) {
      // Activity logging must never turn a completed primary write into failure.
    }
  }
}
