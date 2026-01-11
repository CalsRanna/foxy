import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FoxyPagination extends StatelessWidget {
  final int page;
  final int pageSize;
  final int total;
  final void Function(int)? onChange;
  const FoxyPagination({
    super.key,
    this.page = 1,
    this.pageSize = 50,
    required this.total,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    // 确保 count 至少为 1
    final count = max(1, (total / pageSize).ceil());
    final canGoLeft = page > 1;
    final canGoRight = page < count;
    final left = _Tile(
      disabled: !canGoLeft,
      onClick: canGoLeft ? () => change(-1, count) : null,
      child: const Icon(Icons.chevron_left),
    );
    final right = _Tile(
      disabled: !canGoRight,
      onClick: canGoRight ? () => change(1, count) : null,
      child: const Icon(Icons.chevron_right),
    );
    final first = _Tile(
      active: page == 1,
      onClick: () => handleClick(1),
      child: const Text('1'),
    );

    // 只有当 count > 1 时才显示 last，避免重复显示 "1"
    final showLast = count > 1;
    final last = showLast
        ? _Tile(
            active: page == count,
            onClick: () => handleClick(count),
            child: Text('$count'),
          )
        : null;

    List<_Tile> tiles = [];
    // 只有当 count > 2 时才需要中间的页码
    if (count > 2) {
      final lower = max(2, page - 2);
      final upper = min(page + 2, count - 1);
      for (var i = lower; i <= upper; i++) {
        tiles.add(
          _Tile(
            active: page == i,
            onClick: () => handleClick(i),
            child: Text('$i'),
          ),
        );
      }
      if (lower > 2) {
        final less = _Tile(
          onClick: () => change(-3, count),
          child: const Text('...'),
        );
        tiles.insert(0, less);
      }
      if (upper < count - 2) {
        final more = _Tile(
          onClick: () => change(3, count),
          child: const Text('...'),
        );
        tiles.add(more);
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [left, first, ...tiles, if (last != null) last, right],
    );
  }

  void change(int step, int count) {
    onChange?.call((page + step).clamp(1, count));
  }

  void handleClick(int index) {
    onChange?.call(index);
  }
}

class _Tile extends StatefulWidget {
  final bool active;
  final bool disabled;
  final void Function()? onClick;
  final Widget child;
  const _Tile({
    this.active = false,
    this.disabled = false,
    this.onClick,
    required this.child,
  });

  @override
  State<_Tile> createState() => _TileState();
}

class _TileState extends State<_Tile> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final surfaceContainer = colorScheme.surfaceContainer;
    final disabledColor = colorScheme.onSurface.withValues(alpha: 0.38);

    final isDisabled = widget.disabled;
    final color = isDisabled
        ? disabledColor
        : (widget.active || hovered)
        ? primary
        : null;

    var iconTheme = IconTheme.merge(
      data: IconThemeData(color: color),
      child: widget.child,
    );
    var merge = DefaultTextStyle.merge(
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
      child: iconTheme,
    );
    var boxDecoration = BoxDecoration(
      border: widget.active ? Border.all(color: primary) : null,
      borderRadius: BorderRadius.circular(4),
      color: (!isDisabled && hovered) ? surfaceContainer : null,
    );
    var container = Container(
      alignment: Alignment.center,
      decoration: boxDecoration,
      height: 32,
      margin: EdgeInsets.all(4),
      width: 32,
      child: merge,
    );
    var gestureDetector = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isDisabled ? null : handleTap,
      child: container,
    );
    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: isDisabled ? null : handleEnter,
      onExit: isDisabled ? null : handleExit,
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
