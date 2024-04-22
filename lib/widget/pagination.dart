import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  final int pageSize;
  final int total;
  final void Function(int)? onChange;
  const Pagination({
    super.key,
    this.pageSize = 50,
    required this.total,
    this.onChange,
  });

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int current = 1;

  @override
  Widget build(BuildContext context) {
    final count = (widget.total / widget.pageSize).ceil();
    final left = _PaginationTile(
      onClick: () => change(-1, count),
      child: const Icon(Icons.chevron_left),
    );
    final right = _PaginationTile(
      onClick: () => change(1, count),
      child: const Icon(Icons.chevron_right),
    );
    final first = _PaginationTile(
      active: current == 1,
      onClick: () => handleClick(1),
      child: const Text('1'),
    );
    final last = _PaginationTile(
      active: current == count,
      onClick: () => handleClick(count),
      child: Text('$count'),
    );
    final lower = max(2, current - 2);
    final upper = min(current + 2, count - 1);
    List<_PaginationTile> tiles = [];
    for (var i = lower; i <= upper; i++) {
      tiles.add(_PaginationTile(
        active: current == i,
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
    setState(() {
      current += step;
      current = current.clamp(1, count);
    });
    widget.onChange?.call(current);
  }

  void handleClick(int index) {
    setState(() {
      current = index;
    });
    widget.onChange?.call(current);
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
  State<_PaginationTile> createState() => __PaginationTileState();
}

class __PaginationTileState extends State<_PaginationTile> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final onPrimary = colorScheme.onPrimary;
    final background = (widget.active || hovered) ? primary : null;
    final color = (widget.active || hovered) ? onPrimary : null;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: handleEnter,
      onExit: handleExit,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: handleTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: background,
          ),
          height: 32,
          width: 32,
          child: DefaultTextStyle.merge(
            style: TextStyle(color: color),
            textAlign: TextAlign.center,
            child: IconTheme(
              data: IconThemeData(color: color),
              child: widget.child,
            ),
          ),
        ),
      ),
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
