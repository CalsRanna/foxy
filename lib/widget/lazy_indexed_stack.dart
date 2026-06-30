import 'package:flutter/material.dart';

/// 懒加载的 IndexedStack 变体，用于替代详情页 Tab 中原有的尺寸测量式分页容器。
///
/// - 仅在某个 index 首次被访问时才挂载其 widget（懒加载）；
/// - 已访问的 index 常驻保活（State 保留），切走时用 [Offstage] 隐藏，
///   不参与布局、不占用尺寸，也不会被 dispose；
/// - 整体尺寸跟随当前页（唯一非 Offstage 的子项）。
///
/// 适用于子项内部含需要"有界高度"组件（如 ShadTable）且已通过 shrinkWrap
/// 自适应高度的场景——避免尺寸测量的重建级联。
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
            Offstage(
              offstage: i != widget.index,
              child: widget.children[i],
            ),
      ],
    );
  }
}
