import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int page;
  final int pageSize;
  final int total;
  final void Function(int)? onChange;
  const Pagination({
    super.key,
    this.page = 1,
    this.pageSize = 50,
    required this.total,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final count = (total / pageSize).ceil();
    final left = _PaginationTile(
      onClick: () => change(-1, count),
      child: const Icon(Icons.chevron_left),
    );
    final right = _PaginationTile(
      onClick: () => change(1, count),
      child: const Icon(Icons.chevron_right),
    );
    final first = _PaginationTile(
      active: page == 1,
      onClick: () => handleClick(1),
      child: const Text('1'),
    );
    final last = _PaginationTile(
      active: page == count,
      onClick: () => handleClick(count),
      child: Text('$count'),
    );
    final lower = max(2, page - 2);
    final upper = min(page + 2, count - 1);
    List<_PaginationTile> tiles = [];
    for (var i = lower; i <= upper; i++) {
      tiles.add(_PaginationTile(
        active: page == i,
        onClick: () => handleClick(i),
        child: Text('$i'),
      ));
    }
    if (lower > 2) {
      final less = _PaginationTile(
        onClick: () => change(-3, count),
        child: const Text('...'),
      );
      tiles.insert(0, less);
    }
    if (upper < count - 2) {
      final more = _PaginationTile(
        onClick: () => change(3, count),
        child: const Text('...'),
      );
      tiles.add(more);
    }
    if (count == 0) return const SizedBox();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [left, first, ...tiles, last, right],
    );
  }

  void change(int step, int count) {
    onChange?.call(page.clamp(1, count));
  }

  void handleClick(int index) {
    onChange?.call(index);
  }
}

class _PaginationTile extends StatefulWidget {
  final bool active;
  final void Function()? onClick;
  final Widget child;
  const _PaginationTile({
    this.active = false,
    this.onClick,
    required this.child,
  });

  @override
  State<_PaginationTile> createState() => _PaginationTileState();
}

class _PaginationTileState extends State<_PaginationTile> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final surfaceContainer = colorScheme.surfaceContainer;
    final color = (widget.active || hovered) ? primary : null;
    var iconTheme = IconTheme(
      data: IconThemeData(color: color),
      child: widget.child,
    );
    var merge = DefaultTextStyle.merge(
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
      child: iconTheme,
    );
    var boxDecoration = BoxDecoration(
      border: widget.active ? Border.all(color: primary) : null,
      borderRadius: BorderRadius.circular(4),
      color: hovered ? surfaceContainer : null,
    );
    var container = Container(
      alignment: Alignment.center,
      decoration: boxDecoration,
      height: 32,
      width: 32,
      child: merge,
    );
    var gestureDetector = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: handleTap,
      child: container,
    );
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: handleEnter,
      onExit: handleExit,
      child: gestureDetector,
    );
  }

  void handleEnter(PointerEnterEvent event) {
    setState(() {
      hovered = true;
    });
  }

  void handleExit(PointerExitEvent event) {
    setState(() {
      hovered = false;
    });
  }

  void handleTap() {
    widget.onClick?.call();
  }
}
