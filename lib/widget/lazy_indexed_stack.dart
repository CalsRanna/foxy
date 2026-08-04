import 'package:flutter/material.dart';

/// Lazily-loading IndexedStack variant, replacing the previous
/// size-measuring paginated container in detail-page tabs.
///
/// - A widget is only mounted when its index is first visited (lazy);
/// - Visited indexes stay alive (State preserved); switching away hides
///   them with [Offstage] — no layout participation, no size, never
///   disposed;
/// - Overall size follows the current page (the only non-Offstage child).
///
/// Fits children containing "bounded-height" components (e.g. ShadTable)
/// that already self-size via shrinkWrap — avoiding the rebuild cascade of
/// size measurement.
class LazyIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;

  const LazyIndexedStack({
    super.key,
    required this.index,
    required this.children,
  });

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  final Set<int> _visited = {};

  @override
  Widget build(BuildContext context) {
    _visited.add(widget.index);
    return Stack(
      fit: StackFit.loose,
      children: [
        for (int i = 0; i < widget.children.length; i++)
          if (_visited.contains(i))
            Offstage(offstage: i != widget.index, child: widget.children[i]),
      ],
    );
  }
}
