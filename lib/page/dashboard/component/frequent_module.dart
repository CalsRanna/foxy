import 'package:flutter/material.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/feature_view_model.dart';
import 'package:foxy/widget/card.dart';
import 'package:foxy/widget/feature_card.dart';
import 'package:get_it/get_it.dart';

class FrequentModuleComponent extends StatelessWidget {
  final void Function(RouterMenu menu)? onMenuTap;

  const FrequentModuleComponent({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const title = Text('常用功能', style: textStyle);
    final featureViewModel = GetIt.instance.get<FeatureViewModel>();
    final features = featureViewModel.favoriteFeatures;
    final theme = Theme.of(context);
    final outline = theme.colorScheme.outline.withValues(alpha: 0.2);
    final kTotalColumns = 3;

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

    // 按每行 3 个分组，不足的用空白占位
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
