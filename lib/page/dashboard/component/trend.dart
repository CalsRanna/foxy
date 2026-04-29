import 'package:flutter/material.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/widget/card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Trend extends StatelessWidget {
  final List<ActivityLogEntity> activities;

  const Trend({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return const FoxyCard(
        title: Text('动态'),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text('暂无动态', style: TextStyle(color: Colors.grey)),
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

  IconData _actionIcon(ActivityActionType type) {
    return switch (type) {
      ActivityActionType.create => LucideIcons.plus,
      ActivityActionType.update => LucideIcons.pencil,
      ActivityActionType.delete => LucideIcons.trash2,
      ActivityActionType.copy => LucideIcons.copy,
    };
  }

  Color _actionColor(ActivityActionType type, ColorScheme colorScheme) {
    return switch (type) {
      ActivityActionType.create => Colors.green,
      ActivityActionType.update => Colors.blue,
      ActivityActionType.delete => Colors.red,
      ActivityActionType.copy => Colors.orange,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final name = activity.entityName.isNotEmpty
        ? activity.entityName
        : '#${activity.entityId}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        children: [
          Icon(
            _actionIcon(activity.actionType),
            size: 14,
            color: _actionColor(activity.actionType, colorScheme),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${activity.actionType.label} $name',
              style: textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            _timeAgo(activity.createdAt),
            style: textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    return Divider(color: outline.withValues(alpha: 0.2), height: 1);
  }
}
