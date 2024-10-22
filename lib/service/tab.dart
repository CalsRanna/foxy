import 'package:flutter/material.dart';

class FoxyTab extends StatefulWidget {
  final List<Widget> tabs;
  const FoxyTab({super.key, required this.tabs});

  @override
  State<FoxyTab> createState() => _FoxyTabState();
}

class FoxyTabItem extends StatelessWidget {
  final bool active;
  final void Function()? onTap;
  final Widget child;
  const FoxyTabItem({
    super.key,
    this.active = false,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final textStyle = TextStyle(color: active ? primary : null);
    var container = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DefaultTextStyle.merge(style: textStyle, child: child),
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: container,
    );
  }
}

class _FoxyTabState extends State<FoxyTab> {
  int index = 0;
  List<GlobalKey> keys = [];
  List<double> width = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    var boxDecoration = BoxDecoration(
      border: Border(bottom: BorderSide(color: outline.withOpacity(0.2))),
    );
    final children = List.generate(widget.tabs.length, _buildItem);
    var listView = ListView(
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
    return Stack(children: [container, animatedPositioned]);
  }

  void handleTap(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  void initState() {
    super.initState();
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

  FoxyTabItem _buildItem(int i) {
    return FoxyTabItem(
      key: keys[i],
      active: i == index,
      onTap: () => handleTap(i),
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
