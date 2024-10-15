import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ArcaneTable extends StatelessWidget {
  final List<ArcaneTableRow>? body;
  final ArcaneTableHeader header;

  const ArcaneTable({super.key, this.body, required this.header});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final borderSide = BorderSide(color: outline.withOpacity(0.25));
    final boxDecoration = BoxDecoration(border: Border(bottom: borderSide));
    final defaultBody = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(child: Text('暂无数据')),
    );
    return Column(children: [
      Container(decoration: boxDecoration, child: header),
      Expanded(child: ListView(children: body ?? [defaultBody]))
    ]);
  }
}

class ArcaneTableCell extends StatelessWidget {
  final double? width;
  final Widget? child;
  const ArcaneTableCell({super.key, this.width, this.child});

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(horizontal: 8, vertical: 16);
    final cell = Container(padding: edgeInsets, width: width, child: child);
    return Expanded(flex: width == null ? 1 : 0, child: cell);
  }
}

class ArcaneTableHeader extends StatelessWidget {
  final List<ArcaneTableCell> children;
  const ArcaneTableHeader({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final textStyle = TextStyle(color: outline, fontWeight: FontWeight.bold);
    final row = Row(children: children);
    return DefaultTextStyle.merge(style: textStyle, child: row);
  }
}

class ArcaneTableRow extends StatefulWidget {
  final List<ArcaneTableCell> children;
  const ArcaneTableRow({super.key, required this.children});

  @override
  State<ArcaneTableRow> createState() => _ArcaneTableRowState();
}

class _ArcaneTableRowState extends State<ArcaneTableRow> {
  bool hovered = false;

  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryContainer = colorScheme.primaryContainer;
    final outline = colorScheme.outline;
    final borderSide = BorderSide(color: outline.withOpacity(0.25));
    final boxDecoration = BoxDecoration(
      border: Border(bottom: borderSide),
      color: hovered ? primaryContainer : null,
    );
    final row = Container(
      decoration: boxDecoration,
      child: Row(children: widget.children),
    );
    final gestureDetector = GestureDetector(
      onDoubleTap: handleDoubleTap,
      child: row,
    );
    final listener = Listener(
      onPointerDown: handlePointerDown,
      child: gestureDetector,
    );
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: handleEnter,
      onExit: handleExit,
      child: listener,
    );
  }

  void handleDoubleTap() {
    print('Double clicked');
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

  void handlePointerDown(PointerDownEvent event) {
    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kSecondaryMouseButton) {
      print('Right clicked');
      print(event.localPosition);
      print(event.position);
      entry = OverlayEntry(builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: removeEntry,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: event.position.dx,
              top: event.position.dy,
              width: 200,
              child: Material(
                  child: Column(
                children: [
                  ListTile(onTap: () {}, title: Text('编辑')),
                  ListTile(onTap: () {}, title: Text('复制')),
                  Divider(),
                  ListTile(onTap: () {}, title: Text('删除')),
                ],
              )),
            )
          ],
        );
      });
      Overlay.of(context).insert(entry!);
    }
  }

  void removeEntry() {
    print('remove entry');
    entry?.remove();
  }
}
