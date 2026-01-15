import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class FoxyTab extends StatefulWidget {
  final List<Widget> tabs;
  final List<Widget> contents;
  final Set<int> disabledIndexes;
  const FoxyTab({
    super.key,
    required this.tabs,
    required this.contents,
    this.disabledIndexes = const {},
  });

  @override
  State<FoxyTab> createState() => _FoxyTabState();
}

class FoxyTabItem extends StatelessWidget {
  final bool active;
  final bool disabled;
  final void Function()? onTap;
  final Widget child;
  const FoxyTabItem({
    super.key,
    this.active = false,
    this.disabled = false,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final disabledColor = colorScheme.outline.withValues(alpha: 0.5);
    final textStyle = TextStyle(
      color: disabled ? disabledColor : (active ? primary : null),
    );
    var container = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DefaultTextStyle.merge(style: textStyle, child: child),
    );
    if (disabled) {
      return container;
    }
    var gestureDetector = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: container,
    );
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: gestureDetector,
    );
  }
}

class _FoxyTabState extends State<FoxyTab> {
  int index = 0;
  List<GlobalKey> keys = [];
  List<double> width = [];
  late PageController _pageController;
  double _opacity = 1.0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    keys = widget.tabs.map((e) => GlobalKey()).toList();
    width = List.generate(widget.tabs.length, (index) => 0.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var i = 0; i < keys.length; i++) {
        final key = keys[i];
        final renderBox = key.currentContext?.findRenderObject() as RenderBox;
        width[i] = renderBox.size.width;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    var boxDecoration = BoxDecoration(
      border: Border(bottom: BorderSide(color: outline.withValues(alpha: 0.2))),
    );
    final children = List.generate(widget.tabs.length, _buildItem);
    var listView = ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      children: children,
    );
    var container = Container(
      decoration: boxDecoration,
      height: 40,
      width: double.infinity,
      child: listView,
    );
    var animatedPositioned = AnimatedPositioned(
      bottom: 0,
      duration: Duration(milliseconds: 300),
      left: _getOffset(),
      child: _Indicator(width: width[index]),
    );

    // 构建内容列表
    final contentList = List.generate(widget.contents.length, (i) {
      return widget.contents[i];
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [container, animatedPositioned]),
        AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 150),
          child: ExpandablePageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
            children: contentList,
          ),
        ),
      ],
    );
  }

  void _onPageChanged(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  Future<void> handleTap(int targetIndex) async {
    if (_isAnimating) return;

    final currentIndex = _pageController.page?.round() ?? 0;
    final distance = (targetIndex - currentIndex).abs();

    if (distance <= 1) {
      // 相邻页面，直接滑动
      _pageController.animateToPage(
        targetIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // 距离 > 1，使用淡入淡出 + 瞬间跳转
      _isAnimating = true;

      // 1. 淡出
      setState(() => _opacity = 0.0);
      await Future.delayed(Duration(milliseconds: 150));

      // 2. 瞬间跳转
      _pageController.jumpToPage(targetIndex);

      // 3. 淡入
      setState(() => _opacity = 1.0);
      await Future.delayed(Duration(milliseconds: 150));

      _isAnimating = false;
    }
  }

  FoxyTabItem _buildItem(int i) {
    final isDisabled = widget.disabledIndexes.contains(i);
    return FoxyTabItem(
      key: keys[i],
      active: i == index,
      disabled: isDisabled,
      onTap: isDisabled ? null : () => handleTap(i),
      child: widget.tabs[i],
    );
  }

  double _getOffset() {
    return switch (index) {
      0 => 0,
      _ => width.sublist(0, index).reduce((a, b) => a + b),
    };
  }
}

class _Indicator extends StatelessWidget {
  final double width;
  const _Indicator({required this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    var border = Border(bottom: BorderSide(color: primary, width: 2));
    var boxDecoration = BoxDecoration(border: border);
    return AnimatedContainer(
      decoration: boxDecoration,
      duration: Duration(milliseconds: 300),
      width: width,
    );
  }
}
