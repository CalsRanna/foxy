import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foxy/service/creature.dart';

class ArcaneTable extends StatelessWidget {
  const ArcaneTable({
    super.key,
    required this.templates,
  });

  final List<CreatureTemplate> templates;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: outline.withOpacity(0.25))),
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: outline, fontWeight: FontWeight.bold),
          child: const Row(
            children: [
              _ArcaneTableCell(width: 100, child: Text('编号')),
              _ArcaneTableCell(child: Text('姓名')),
              _ArcaneTableCell(child: Text('称号')),
              _ArcaneTableCell(child: Text('最小等级')),
              _ArcaneTableCell(child: Text('最大等级')),
            ],
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _ArcaneTableRow(template: templates[index]);
          },
          itemCount: templates.length,
        ),
      )
    ]);
  }
}

class _ArcaneTableRow extends StatefulWidget {
  final CreatureTemplate template;
  const _ArcaneTableRow({super.key, required this.template});

  @override
  State<_ArcaneTableRow> createState() => _ArcaneTableRowState();
}

class _ArcaneTableRowState extends State<_ArcaneTableRow> {
  bool hovered = false;

  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryContainer = colorScheme.primaryContainer;
    final outline = colorScheme.outline;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: handleEnter,
      onExit: handleExit,
      child: Listener(
        onPointerDown: handlePointerDown,
        child: GestureDetector(
          onDoubleTap: handleDoubleTap,
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: outline.withOpacity(0.25))),
              color: hovered ? primaryContainer : null,
            ),
            child: Row(
              children: [
                _ArcaneTableCell(
                    width: 100, child: Text(widget.template.entry.toString())),
                _ArcaneTableCell(child: Text(widget.template.name)),
                _ArcaneTableCell(child: Text(widget.template.subName)),
                _ArcaneTableCell(
                    child: Text(widget.template.minLevel.toString())),
                _ArcaneTableCell(
                    child: Text(widget.template.maxLevel.toString())),
              ],
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

  void handleDoubleTap() {
    print('Double clicked');
  }
}

class _ArcaneTableCell extends StatelessWidget {
  final double? width;
  final Widget? child;
  const _ArcaneTableCell({super.key, this.width, this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: width == null ? 1 : 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        width: width,
        child: child,
      ),
    );
  }
}
