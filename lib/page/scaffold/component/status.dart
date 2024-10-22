import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/application.dart';

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final onPrimary = colorScheme.onPrimary;
    final textStyle = TextStyle(
      color: onPrimary,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    );
    final children = [
      Text('MPQ File Ready', style: textStyle),
      const SizedBox(width: 16),
      Text('Dbc File Ready', style: textStyle),
      const SizedBox(width: 16),
      const _MysqlStatus(),
    ];
    final edgeInsets = MediaQuery.paddingOf(context);
    return Container(
      color: primary,
      padding: EdgeInsets.fromLTRB(16, 4, 16, edgeInsets.bottom),
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: children),
    );
  }
}

class _MysqlStatus extends ConsumerWidget {
  const _MysqlStatus();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onPrimary = colorScheme.onPrimary;
    final errorContainer = colorScheme.errorContainer;
    final provider = mysqlVersionProvider;
    final version = ref.watch(provider).valueOrNull ?? '';
    final connected = version.isNotEmpty;
    final color = connected ? onPrimary : errorContainer;
    final text = connected ? 'Mysql Connected: $version' : 'Mysql Disconnected';
    final textStyle = TextStyle(
      color: color,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    );
    return Text(text, style: textStyle);
  }
}
