import 'package:foxy/entity/activity_log_entity.dart';

/// 一条活动日志被写入数据库后产生的领域事件。
///
/// 由 [ActivityLogRepository.storeActivityLog] 在写库成功后发布，
/// 供仪表盘等模块订阅以实时刷新。
class ActivityLoggedEvent {
  final ActivityLogEntity log;
  const ActivityLoggedEvent(this.log);
}
