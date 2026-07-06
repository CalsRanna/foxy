import 'package:flutter/material.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/widget/foxy_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Trend extends StatelessWidget {
  final List<ActivityLogEntity> activities;

  const Trend({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    if (activities.isEmpty) {
      return FoxyCard(
        title: const Text('动态'),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Center(
            child: Text(
              '暂无动态',
              style: theme.textTheme.muted.copyWith(
                color: theme.colorScheme.mutedForeground,
              ),
            ),
          ),
        ),
      );
    }

    final children = <Widget>[];
    for (var i = 0; i < activities.length; i++) {
      if (i > 0) {
        children.add(_Divider());
      }
      children.add(_TrendItem(activity: activities[i]));
    }

    return FoxyCard(
      title: const Text('动态'),
      child: Column(children: children),
    );
  }
}

class _TrendItem extends StatelessWidget {
  final ActivityLogEntity activity;

  const _TrendItem({required this.activity});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    final name = activity.entityName.isNotEmpty
        ? activity.entityName
        : '#${activity.entityId}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Icon(
            _actionIcon(activity.actionType),
            size: 14,
            color: _actionColor(activity.actionType),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${activity.actionType.label} $name',
              style: theme.textTheme.small,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            _timeAgo(activity.createdAt),
            style: theme.textTheme.muted.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }

  IconData _actionIcon(ActivityActionType type) {
    return switch (type) {
      ActivityActionType.create => LucideIcons.plus,
      ActivityActionType.update => LucideIcons.pencil,
      ActivityActionType.delete => LucideIcons.trash2,
      ActivityActionType.copy => LucideIcons.copy,
    };
  }

  Color _actionColor(ActivityActionType type) {
    return switch (type) {
      ActivityActionType.create => _kCreateColor,
      ActivityActionType.update => _kUpdateColor,
      ActivityActionType.delete => _kDeleteColor,
      ActivityActionType.copy => _kCopyColor,
    };
  }

  String _timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inMinutes < 1) return '刚刚';
    if (diff.inMinutes < 60) return '${diff.inMinutes} 分钟前';
    if (diff.inHours < 24) return '${diff.inHours} 小时前';
    if (diff.inDays < 30) return '${diff.inDays} 天前';
    return '${dateTime.month}-${dateTime.day}';
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(color: outline.withValues(alpha: 0.2), height: 1),
    );
  }
}

/// 动作图标色取自 shadcn 各色系的 `primary`（light），与 shadcn 调色板保持一致，
/// 替代原先硬编码的 Material `Colors.green/blue/red/orange`。
final _kCreateColor = ShadGreenColorScheme.light().primary;
final _kUpdateColor = ShadBlueColorScheme.light().primary;
final _kDeleteColor = ShadRedColorScheme.light().primary;
final _kCopyColor = ShadOrangeColorScheme.light().primary;
