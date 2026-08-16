import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/util/table_layout_util.dart';
import 'package:foxy/widget/foxy_loading_indicator.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One column of [FoxyDataTable]: a fixed-pixel column or a flex column
/// that shares the remaining width by ratio.
///
/// Every column carries its own label, width and cell builder, so column
/// order, header text and row rendering stay in one place.
class FoxyTableColumn<T> {
  /// Header label (rendered via [ShadTableCell.header] unless [headerCell]
  /// overrides it).
  final String label;

  /// Fixed pixel width; null for a flex column ([flex] shares the leftover).
  final double? width;

  /// Ratio of the remaining width for flex columns. Ratios are normalized
  /// against the sum of all flex ratios, so `flex: 3` and `flex: 7` split
  /// the leftover 3:7 without manual math.
  final double flex;

  /// Cell builder for every data row.
  final Widget Function(BuildContext context, T row) cell;

  /// Optional header override (rendered instead of the default label text).
  final ShadTableCell Function(BuildContext context)? headerCell;

  // The field is `double?` while the fixed constructor takes a required
  // non-null `double`, so `this.width` cannot be an initializing formal.
  const FoxyTableColumn.fixed({
    required this.label,
    required double width,
    required this.cell,
    this.headerCell,
  }) : width = width, // ignore: prefer_initializing_formals
       flex = 0;

  const FoxyTableColumn.flex({
    required this.label,
    this.flex = 1,
    required this.cell,
    this.headerCell,
  }) : width = null;
}

/// A typed column-declaration table built directly on shadcn's [ShadTable].
///
/// Each column is one [FoxyTableColumn] carrying its own label, width
/// (fixed or flex ratio) and cell builder — replacing the three
/// index-aligned callbacks (`header` / `columnSpanExtent` / `builder`) of
/// the raw table. The LayoutBuilder and remaining-width computation live
/// here, once, so call sites declare only the columns.
///
/// Row-interaction callbacks receive the typed row instead of an index.
/// Styling and behavior match the previous FoxyShadTable usage exactly
/// (fixed header, right-click position, double-tap detection,
/// queryVersion scroll-to-top, loading / empty state). This component is
/// now the sole table entry point; FoxyShadTable was removed.
class FoxyDataTable<T> extends StatefulWidget {
  /// Column declarations, in display order.
  final List<FoxyTableColumn<T>> columns;

  /// Data rows of the current page.
  final List<T> rows;

  /// Row tap (data rows only, header excluded).
  final void Function(T row)? onRowTap;

  /// Row double-tap (data rows only).
  final void Function(T row)? onRowDoubleTap;

  /// Row right-press with its global position, for context menus.
  final void Function(T row, TapDownDetails details)?
  onRowSecondaryTapDownWithDetails;

  /// Row key selector for the selected-row highlight: when [selectedKey]
  /// equals the key of a row, that row is highlighted.
  final Object? Function(T row)? keyOf;

  /// Currently selected key (compare with [keyOf]); null disables the
  /// highlight.
  final Object? selectedKey;

  /// Whether the height adapts to the row count (embedded detail-page
  /// tables); disables vertical scrolling.
  final bool shrinkWrap;

  /// Fixed header row count (1 = sticky header).
  final int? pinnedRowCount;

  /// Whether a loading state is shown (header + spinner instead of rows).
  final bool loading;

  /// Pagination browse baseline: when it changes, the table scrolls back
  /// to the first row (page turn / search / reset).
  final int? queryVersion;

  /// External vertical scroll controller; when provided, the caller owns
  /// its lifecycle (this widget never disposes it).
  final ScrollController? verticalScrollController;

  const FoxyDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
    this.onRowDoubleTap,
    this.onRowSecondaryTapDownWithDetails,
    this.keyOf,
    this.selectedKey,
    this.shrinkWrap = false,
    this.pinnedRowCount,
    this.loading = false,
    this.queryVersion,
    this.verticalScrollController,
  });

  @override
  State<FoxyDataTable<T>> createState() => _FoxyDataTableState<T>();
}

class _FoxyDataTableState<T> extends State<FoxyDataTable<T>> {
  static const _doubleTapTimeout = Duration(milliseconds: 300);

  /// Row height, matching ShadTable's default row height.
  static const _rowHeight = 48.0;

  // Double-tap detection state.
  int? _lastTappedRow;
  Timer? _doubleTapTimer;

  // Right-click position capture.
  Offset? _lastSecondaryTapPosition;

  /// Vertical scroll controller: reused when provided externally, created
  /// internally otherwise; used to return to the first row on queryVersion
  /// changes.
  late final ScrollController _verticalScrollController =
      widget.verticalScrollController ?? ScrollController();

  @override
  Widget build(BuildContext context) {
    final columns = widget.columns;
    // Fixed-width sum and flex-ratio sum, computed once per build.
    var fixedTotal = 0.0;
    var flexTotal = 0.0;
    for (final column in columns) {
      final width = column.width;
      if (width != null) {
        fixedTotal += width;
      } else {
        flexTotal += column.flex;
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Remaining width for flex columns; floors at 120 in windows
        // narrower than the fixed columns (same rule as TableLayoutUtil.flexColumnWidth).
        final remaining = TableLayoutUtil.flexColumnWidth(
          constraints.maxWidth,
          fixedTotal,
        );
        final rows = widget.rows;

        Widget table = ShadTable(
          builder: (context, vicinity) {
            final row = vicinity.row;
            if (row < 0 || row >= rows.length) {
              return const ShadTableCell(child: SizedBox());
            }
            return ShadTableCell(
              child: columns[vicinity.column].cell(context, rows[row]),
            );
          },
          columnCount: columns.length,
          rowCount: rows.length,
          header: (context, column) {
            final headerCell = columns[column].headerCell;
            if (headerCell != null) return headerCell(context);
            final label = columns[column].label;
            // Empty label → blank header cell (e.g. a checkbox column).
            return ShadTableCell.header(
              child: label.isEmpty ? const SizedBox() : Text(label),
            );
          },
          columnSpanExtent: (column) {
            final width = columns[column].width;
            if (width != null) return FixedTableSpanExtent(width);
            return FixedTableSpanExtent(
              flexTotal == 0
                  ? remaining
                  : remaining * columns[column].flex / flexTotal,
            );
          },
          onRowTap: _handleRowTap,
          onRowSecondaryTapDown: _handleRowSecondaryTapDown,
          rowSpanBackgroundDecoration: (row) {
            final keyOf = widget.keyOf;
            final selectedKey = widget.selectedKey;
            if (keyOf == null || selectedKey == null) return null;
            final dataRow = row - 1; // header occupies row 0
            if (dataRow < 0 || dataRow >= rows.length) return null;
            if (keyOf(rows[dataRow]) == selectedKey) {
              return TableSpanDecoration(
                color: ShadTheme.of(context).colorScheme.accent,
              );
            }
            return null;
          },
          pinnedRowCount: widget.pinnedRowCount,
          verticalScrollController: _verticalScrollController,
          verticalScrollPhysics: widget.shrinkWrap
              ? const NeverScrollableScrollPhysics()
              : null,
        );

        if (rows.isEmpty || widget.loading) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: _rowHeight, child: table),
              SizedBox(
                height: _rowHeight,
                child: Center(
                  child: widget.loading
                      ? const FoxyLoadingIndicator(size: 20, strokeWidth: 2)
                      : const Text('暂无数据'),
                ),
              ),
            ],
          );
        }

        // Use a Listener to capture right-click positions.
        if (widget.onRowSecondaryTapDownWithDetails != null) {
          table = Listener(onPointerDown: _handlePointerDown, child: table);
        }

        // Wrap in a SizedBox under shrinkWrap: header (1) + data rows.
        if (widget.shrinkWrap) {
          table = SizedBox(
            height: (rows.length + 1) * _rowHeight,
            child: table,
          );
        }

        return table;
      },
    );
  }

  @override
  void didUpdateWidget(covariant FoxyDataTable<T> oldWidget) {
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
    // are the caller's responsibility.
    if (widget.verticalScrollController == null) {
      _verticalScrollController.dispose();
    }
    super.dispose();
  }

  void _handlePointerDown(PointerDownEvent event) {
    // Capture the right-click position.
    if (event.buttons == kSecondaryMouseButton) {
      _lastSecondaryTapPosition = event.position;
    }
  }

  void _handleRowSecondaryTapDown(int row) {
    // ShadTable's row includes the header; the header occupies row 0.
    final dataRow = row - 1;
    if (dataRow < 0 || dataRow >= widget.rows.length) return;
    // Combine the row index with the previously captured position.
    final position = _lastSecondaryTapPosition;
    if (position == null) return;
    widget.onRowSecondaryTapDownWithDetails?.call(
      widget.rows[dataRow],
      TapDownDetails(globalPosition: position, localPosition: position),
    );
  }

  void _handleRowTap(int row) {
    // ShadTable's row includes the header; the header occupies row 0.
    final dataRow = row - 1;
    if (dataRow < 0 || dataRow >= widget.rows.length) return;

    // Handle double-tap detection first.
    final onRowDoubleTap = widget.onRowDoubleTap;
    if (onRowDoubleTap != null) {
      if (_lastTappedRow == dataRow && _doubleTapTimer?.isActive == true) {
        // Double-tap fired.
        _doubleTapTimer?.cancel();
        _lastTappedRow = null;
        onRowDoubleTap(widget.rows[dataRow]);
        return;
      }
      // Start a new double-tap detection window.
      _lastTappedRow = dataRow;
      _doubleTapTimer?.cancel();
      _doubleTapTimer = Timer(_doubleTapTimeout, () {
        _lastTappedRow = null;
      });
    }

    // Fire the original onRowTap.
    widget.onRowTap?.call(widget.rows[dataRow]);
  }
}
