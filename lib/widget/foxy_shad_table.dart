import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Extended ShadTable component with double-click and right-click
/// callbacks carrying details
class FoxyShadTable extends StatefulWidget {
  /// Cell builder callback
  final ShadTableCellBuilder builder;

  /// Column count
  final int columnCount;

  /// Row count
  final int rowCount;

  /// Header builder callback
  final ShadTableCell Function(BuildContext context, int column)? header;

  /// Footer builder callback
  final ShadTableCell Function(BuildContext context, int column)? footer;

  /// Whether the height adapts to the content
  /// When true, the table height is computed from the row count and needs
  /// no external constraints; vertical scrolling is disabled
  final bool shrinkWrap;

  /// Row height, used to compute the total height under shrinkWrap
  /// Defaults to 48 (matching ShadTable's default row height)
  final double rowHeight;

  /// Whether loading
  /// When true, shows the header and a loading indicator
  final bool loading;

  /// Column builder
  final TableSpanBuilder? columnBuilder;

  /// Row builder
  final TableSpanBuilder? rowBuilder;

  /// Row height
  final TableSpanExtent? Function(int row)? rowSpanExtent;

  /// Column width
  final TableSpanExtent? Function(int column)? columnSpanExtent;

  /// Row background decoration
  final TableSpanDecoration? Function(int row)? rowSpanBackgroundDecoration;

  /// Row foreground decoration
  final TableSpanDecoration? Function(int row)? rowSpanForegroundDecoration;

  /// Column background decoration
  final TableSpanDecoration? Function(int column)?
  columnSpanBackgroundDecoration;

  /// Column foreground decoration
  final TableSpanDecoration? Function(int column)?
  columnSpanForegroundDecoration;

  /// Hovered-row index change callback
  final ValueChanged<int?>? onHoveredRowIndex;

  /// Horizontal scroll controller
  final ScrollController? horizontalScrollController;

  /// Vertical scroll controller
  final ScrollController? verticalScrollController;

  /// Fixed row count
  final int? pinnedRowCount;

  /// Fixed column count
  final int? pinnedColumnCount;

  /// Pagination browse baseline version.
  ///
  /// When this changes (page turn / search / reset / delete shrinking the
  /// page count), the vertical scroll returns to the first row; in-page
  /// data changes (delete, copy, edit-save) keep the position. When null,
  /// no scroll-to-top is triggered (e.g. shrinkWrap tables on detail
  /// pages).
  final int? queryVersion;

  /// Whether this is the primary scroll view
  final bool? primary;

  /// Diagonal drag behavior
  final DiagonalDragBehavior? diagonalDragBehavior;

  /// Drag-start behavior
  final DragStartBehavior? dragStartBehavior;

  /// Keyboard dismiss behavior
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  /// Vertical scroll physics
  final ScrollPhysics? verticalScrollPhysics;

  /// Horizontal scroll physics
  final ScrollPhysics? horizontalScrollPhysics;

  /// Supported device kinds
  final Set<PointerDeviceKind>? supportedDevices;

  // ============ Raw ShadTable callbacks ============

  /// Row tap callback
  final void Function(int row)? onRowTap;

  /// Row press callback
  final void Function(int row)? onRowTapDown;

  /// Row release callback
  final void Function(int row)? onRowTapUp;

  /// Row tap-cancel callback
  final void Function(int row)? onRowTapCancel;

  /// Row right-click callback
  final void Function(int row)? onRowSecondaryTap;

  /// Row right-release callback
  final void Function(int row)? onRowSecondaryTapUp;

  /// Row right-cancel callback
  final void Function(int row)? onRowSecondaryTapCancel;

  /// Column tap callback
  final void Function(int column)? onColumnTap;

  /// Column press callback
  final void Function(int column)? onColumnTapDown;

  /// Column release callback
  final void Function(int column)? onColumnTapUp;

  /// Column tap-cancel callback
  final void Function(int column)? onColumnTapCancel;

  /// Column right-click callback
  final void Function(int column)? onColumnSecondaryTap;

  /// Column right-press callback
  final void Function(int column)? onColumnSecondaryTapDown;

  /// Column right-release callback
  final void Function(int column)? onColumnSecondaryTapUp;

  /// Column right-cancel callback
  final void Function(int column)? onColumnSecondaryTapCancel;

  // ============ Extended callbacks ============

  /// Row double-tap callback
  final void Function(int row)? onRowDoubleTap;

  /// Row right-press callback (with details)
  /// [row] - row index (data rows, header excluded)
  /// [details] - click details, including globalPosition etc.
  final void Function(int row, TapDownDetails details)?
  onRowSecondaryTapDownWithDetails;

  const FoxyShadTable({
    super.key,
    required this.builder,
    required this.columnCount,
    required this.rowCount,
    this.header,
    this.footer,
    this.shrinkWrap = false,
    this.rowHeight = 48,
    this.loading = false,
    this.columnBuilder,
    this.rowBuilder,
    this.rowSpanExtent,
    this.columnSpanExtent,
    this.rowSpanBackgroundDecoration,
    this.rowSpanForegroundDecoration,
    this.columnSpanBackgroundDecoration,
    this.columnSpanForegroundDecoration,
    this.onHoveredRowIndex,
    this.horizontalScrollController,
    this.verticalScrollController,
    this.pinnedRowCount,
    this.pinnedColumnCount,
    this.primary,
    this.diagonalDragBehavior,
    this.dragStartBehavior,
    this.keyboardDismissBehavior,
    this.verticalScrollPhysics,
    this.horizontalScrollPhysics,
    this.supportedDevices,
    this.onRowTap,
    this.onRowTapDown,
    this.onRowTapUp,
    this.onRowTapCancel,
    this.onRowSecondaryTap,
    this.onRowSecondaryTapUp,
    this.onRowSecondaryTapCancel,
    this.onColumnTap,
    this.onColumnTapDown,
    this.onColumnTapUp,
    this.onColumnTapCancel,
    this.onColumnSecondaryTap,
    this.onColumnSecondaryTapDown,
    this.onColumnSecondaryTapUp,
    this.onColumnSecondaryTapCancel,
    this.onRowDoubleTap,
    this.onRowSecondaryTapDownWithDetails,
    this.queryVersion,
  });

  @override
  State<FoxyShadTable> createState() => _FoxyShadTableState();
}

class _FoxyShadTableState extends State<FoxyShadTable> {
  static const _doubleTapTimeout = Duration(milliseconds: 300);
  // For double-tap detection
  int? _lastTappedRow;
  Timer? _doubleTapTimer;

  // For right-click position capture
  Offset? _lastSecondaryTapPosition;

  // Vertical scroll controller: reused when provided externally, created
  // internally otherwise; used to return to the first row on version
  // changes
  late final ScrollController _verticalScrollController =
      widget.verticalScrollController ?? ScrollController();

  @override
  Widget build(BuildContext context) {
    // Compute the height under shrinkWrap
    double? calculatedHeight;
    if (widget.shrinkWrap) {
      int totalRows = widget.rowCount;
      if (widget.header != null) totalRows += 1;
      if (widget.footer != null) totalRows += 1;
      calculatedHeight = totalRows * widget.rowHeight;
    }

    // Disable vertical scrolling under shrinkWrap
    final effectiveVerticalScrollPhysics = widget.shrinkWrap
        ? const NeverScrollableScrollPhysics()
        : widget.verticalScrollPhysics;

    Widget table = ShadTable(
      builder: widget.builder,
      columnCount: widget.columnCount,
      rowCount: widget.rowCount,
      header: widget.header,
      footer: widget.footer,
      columnBuilder: widget.columnBuilder,
      rowBuilder: widget.rowBuilder,
      rowSpanExtent: widget.rowSpanExtent,
      columnSpanExtent: widget.columnSpanExtent,
      rowSpanBackgroundDecoration: widget.rowSpanBackgroundDecoration,
      rowSpanForegroundDecoration: widget.rowSpanForegroundDecoration,
      columnSpanBackgroundDecoration: widget.columnSpanBackgroundDecoration,
      columnSpanForegroundDecoration: widget.columnSpanForegroundDecoration,
      onHoveredRowIndex: widget.onHoveredRowIndex,
      horizontalScrollController: widget.horizontalScrollController,
      verticalScrollController: _verticalScrollController,
      pinnedRowCount: widget.pinnedRowCount,
      pinnedColumnCount: widget.pinnedColumnCount,
      primary: widget.primary,
      diagonalDragBehavior: widget.diagonalDragBehavior,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      verticalScrollPhysics: effectiveVerticalScrollPhysics,
      horizontalScrollPhysics: widget.horizontalScrollPhysics,
      supportedDevices: widget.supportedDevices,
      // Row taps use custom handling (supports double-tap detection)
      onRowTap: _handleRowTap,
      onRowTapDown: widget.onRowTapDown,
      onRowTapUp: widget.onRowTapUp,
      onRowTapCancel: widget.onRowTapCancel,
      onRowSecondaryTap: widget.onRowSecondaryTap,
      // Row right-press uses custom handling (provides details)
      onRowSecondaryTapDown: _handleRowSecondaryTapDown,
      onRowSecondaryTapUp: widget.onRowSecondaryTapUp,
      onRowSecondaryTapCancel: widget.onRowSecondaryTapCancel,
      onColumnTap: widget.onColumnTap,
      onColumnTapDown: widget.onColumnTapDown,
      onColumnTapUp: widget.onColumnTapUp,
      onColumnTapCancel: widget.onColumnTapCancel,
      onColumnSecondaryTap: widget.onColumnSecondaryTap,
      onColumnSecondaryTapDown: widget.onColumnSecondaryTapDown,
      onColumnSecondaryTapUp: widget.onColumnSecondaryTapUp,
      onColumnSecondaryTapCancel: widget.onColumnSecondaryTapCancel,
    );

    if (widget.rowCount == 0 || widget.loading) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: widget.rowHeight, child: table),
          SizedBox(
            height: widget.rowHeight,
            child: Center(
              child: widget.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('暂无数据'),
            ),
          ),
        ],
      );
    }

    // Use a Listener to capture right-click positions
    if (widget.onRowSecondaryTapDownWithDetails != null) {
      table = Listener(onPointerDown: _handlePointerDown, child: table);
    }

    // Wrap in a SizedBox under shrinkWrap
    if (widget.shrinkWrap && calculatedHeight != null) {
      table = SizedBox(height: calculatedHeight, child: table);
    }

    return table;
  }

  @override
  void didUpdateWidget(FoxyShadTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When the browse baseline changes (page turn/search/reset/delete
    // shrinking the page count), scroll vertically back to the first row.
    // At this moment the old TableView's ScrollPosition is still attached,
    // so jumpTo takes effect immediately; if already unmounted (no
    // position) it silently no-ops, and after remount PageStorage also
    // restores 0.
    if (widget.queryVersion != oldWidget.queryVersion) {
      _verticalScrollController.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _doubleTapTimer?.cancel();
    // Only release internally created controllers; externally provided ones
    // are the caller's responsibility
    if (widget.verticalScrollController == null) {
      _verticalScrollController.dispose();
    }
    super.dispose();
  }

  void _handlePointerDown(PointerDownEvent event) {
    // Capture the right-click position
    if (event.buttons == kSecondaryMouseButton) {
      _lastSecondaryTapPosition = event.position;
    }
  }

  void _handleRowSecondaryTapDown(int row) {
    // ShadTable's row includes the header; adjust for it
    final dataRow = widget.header != null ? row - 1 : row;

    // Ignore clicks on the header row
    if (dataRow < 0) return;

    // Combine the row index with the previously captured position
    if (widget.onRowSecondaryTapDownWithDetails != null &&
        _lastSecondaryTapPosition != null) {
      final details = TapDownDetails(
        globalPosition: _lastSecondaryTapPosition!,
        localPosition: _lastSecondaryTapPosition!,
      );
      widget.onRowSecondaryTapDownWithDetails!(dataRow, details);
    }
  }

  void _handleRowTap(int row) {
    // ShadTable's row includes the header; adjust for it
    final dataRow = widget.header != null ? row - 1 : row;

    // Ignore clicks on the header row
    if (dataRow < 0) return;

    // Handle double-tap detection first
    if (widget.onRowDoubleTap != null) {
      if (_lastTappedRow == dataRow && _doubleTapTimer?.isActive == true) {
        // Double-tap fired
        _doubleTapTimer?.cancel();
        _lastTappedRow = null;
        widget.onRowDoubleTap!(dataRow);
        return;
      }

      // Start a new double-tap detection window
      _lastTappedRow = dataRow;
      _doubleTapTimer?.cancel();
      _doubleTapTimer = Timer(_doubleTapTimeout, () {
        _lastTappedRow = null;
      });
    }

    // Fire the original onRowTap
    widget.onRowTap?.call(dataRow);
  }
}
