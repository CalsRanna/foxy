import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:foxy/constant/agent_field_semantics.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/model/activity_log_details.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ActivityLogDetail extends StatelessWidget {
  final ActivityLogEntity activity;

  const ActivityLogDetail({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final details = activity.details;
    final source = details?.sourceKey;
    return ShadDialog(
      constraints: DialogUtil.constraints(context),
      title: Text(
        '${activity.actionType.label} ${activity.entityName}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      titlePinned: true,
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('关闭'),
        ),
      ],
      child: SelectionArea(
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('${activity.module} · ${_timestamp(activity.createdAt)}'),
            if (source != null) Text('复制来源 ${_keyLabel(source)}'),
            if (details == null) const Text('暂无变更明细'),
            ...?details?.rows.map((row) => _RowDetail(row: row)),
          ],
        ),
      ),
    );
  }

  static String _timestamp(DateTime value) {
    final local = value.toLocal();
    final date = [local.year, local.month, local.day].map(_pad).join('-');
    final time = [local.hour, local.minute, local.second].map(_pad).join(':');
    return '$date $time';
  }

  static String _pad(int value) => value.toString().padLeft(2, '0');

  static String _keyLabel(Map<String, Object?> key) => key.entries
      .map((entry) => '${entry.key}=${_value(entry.value)}')
      .join(' · ');

  static String _value(Object? value) => switch (value) {
    null => 'NULL',
    '' => '空字符串',
    _ => '$value',
  };
}

class _RowDetail extends StatelessWidget {
  static const _labels = {
    'creature_template': {'minlevel': '最低等级', 'maxlevel': '最高等级'},
  };

  final ActivityRowChange row;

  const _RowDetail({required this.row});

  @override
  Widget build(BuildContext context) {
    final before = row.beforeKey;
    final after = row.afterKey;
    final keyLabel = switch ((before, after)) {
      (null, final key?) => '新增 · ${ActivityLogDetail._keyLabel(key)}',
      (final key?, null) => '删除 · ${ActivityLogDetail._keyLabel(key)}',
      (final oldKey?, final newKey?)
          when !const DeepCollectionEquality().equals(oldKey, newKey) =>
        '${ActivityLogDetail._keyLabel(oldKey)} → ${ActivityLogDetail._keyLabel(newKey)}',
      (final key?, _) => ActivityLogDetail._keyLabel(key),
      _ => '',
    };
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${row.table} · $keyLabel',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        if (before != null && after != null && row.changes.isEmpty)
          const Text('差异暂不可用'),
        ...row.changes.entries.map((entry) {
          final label =
              _labels[row.table]?[entry.key] ??
              AgentFieldSemantics.values[row.table]?[entry.key]?.label ??
              entry.key;
          return _FieldDetail(label: label, change: entry.value);
        }),
      ],
    );
  }
}

class _FieldDetail extends StatelessWidget {
  final String label;
  final ActivityFieldChange change;

  const _FieldDetail({required this.label, required this.change});

  @override
  Widget build(BuildContext context) {
    final before = ActivityLogDetail._value(change.before);
    final after = ActivityLogDetail._value(change.after);
    if (!before.contains('\n') &&
        !after.contains('\n') &&
        before.length + after.length < 140) {
      return Text('$label  $before → $after');
    }

    final colors = Theme.of(context).colorScheme;
    final lines = _lineDiff(before.split('\n'), after.split('\n'));
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Text.rich(
          TextSpan(
            children: lines.map((line) {
              final (marker, value) = line;
              return TextSpan(
                text: '$marker $value\n',
                style: TextStyle(
                  color: switch (marker) {
                    '−' => colors.error,
                    '+' => colors.primary,
                    _ => colors.onSurfaceVariant,
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // The table stores the longest common subsequence length for each suffix.
  // Very large fields can still show both versions without allocating that table.
  static List<(String, String)> _lineDiff(
    List<String> before,
    List<String> after,
  ) {
    final width = after.length + 1;
    if ((before.length + 1) * width > 50000) {
      return [
        ...before.map((line) => ('−', line)),
        ...after.map((line) => ('+', line)),
      ];
    }
    final lengths = List<int>.filled((before.length + 1) * width, 0);
    for (var old = before.length - 1; old >= 0; old--) {
      for (var next = after.length - 1; next >= 0; next--) {
        final index = old * width + next;
        final dropOld = lengths[index + width];
        final addNew = lengths[index + 1];
        lengths[index] = before[old] == after[next]
            ? 1 + lengths[index + width + 1]
            : dropOld >= addNew
            ? dropOld
            : addNew;
      }
    }

    final result = <(String, String)>[];
    var old = 0;
    var next = 0;
    while (old < before.length || next < after.length) {
      final index = old * width + next;
      if (old < before.length &&
          next < after.length &&
          before[old] == after[next]) {
        result.add((' ', before[old++]));
        next++;
      } else if (old < before.length &&
          (next == after.length ||
              lengths[index + width] >= lengths[index + 1])) {
        result.add(('−', before[old++]));
      } else {
        result.add(('+', after[next++]));
      }
    }
    return result;
  }
}
