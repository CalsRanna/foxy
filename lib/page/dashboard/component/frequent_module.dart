import 'package:flutter/material.dart';
import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/card.dart';
import 'package:foxy/widget/feature_card.dart';

/// 仪表盘「常用功能」网格。仅接收已过滤的收藏功能列表，不依赖任何
/// ViewModel；过滤与响应式由 [DashboardViewModel] 侧的 `computed` 负责。
class FrequentModuleComponent extends StatelessWidget {
  final List<FeatureEntity> features;
  final void Function(RouterMenu menu)? onMenuTap;

  const FrequentModuleComponent({
    super.key,
    required this.features,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    const title = Text('常用功能', style: textStyle);
    const kTotalColumns = 3;

    if (features.isEmpty) {
      return FoxyCard(
        title: title,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            '还没有收藏的功能，在"更多功能"中右键卡片即可收藏。',
            style: TextStyle(fontSize: 13),
          ),
        ),
      );
    }

    final theme = Theme.of(context);
    final outline = theme.colorScheme.outline.withValues(alpha: 0.2);
    final totalRows = (features.length + kTotalColumns - 1) ~/ kTotalColumns;

    final tiles = features.map((feature) {
      final index = features.indexOf(feature);
      final col = index % kTotalColumns;
      final row = index ~/ kTotalColumns;

      final border = Border(
        right: col < kTotalColumns - 1
            ? BorderSide(color: outline)
            : BorderSide.none,
        bottom: row < totalRows - 1
            ? BorderSide(color: outline)
            : BorderSide.none,
      );

      return SizedBox(
        height: 160,
        child: FeatureCard(
          seamless: true,
          feature: feature,
          border: border,
          onTap: () {
            final menu = RouterMenu.values.byName(feature.routerMenu);
            onMenuTap?.call(menu);
          },
        ),
      );
    }).toList();

    final rows = <Widget>[];
    for (var i = 0; i < tiles.length; i += kTotalColumns) {
      final end = (i + kTotalColumns > tiles.length)
          ? tiles.length
          : i + kTotalColumns;
      final rowWidgets = tiles
          .sublist(i, end)
          .map((t) => Expanded(child: t))
          .toList();
      while (rowWidgets.length < kTotalColumns) {
        rowWidgets.add(const Expanded(child: SizedBox()));
      }
      rows.add(Row(children: rowWidgets));
    }

    return FoxyCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      ),
    );
  }
}
