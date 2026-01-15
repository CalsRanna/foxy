import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 扩展的 ShadTable 组件，支持双击和右键点击带详情的回调
class FoxyShadTable extends StatefulWidget {
  /// 构建单元格的回调
  final ShadTableCellBuilder builder;

  /// 列数
  final int columnCount;

  /// 行数
  final int rowCount;

  /// 构建表头的回调
  final ShadTableCell Function(BuildContext context, int column)? header;

  /// 构建表尾的回调
  final ShadTableCell Function(BuildContext context, int column)? footer;

  /// 是否根据内容自适应高度
  /// 当为 true 时，表格高度将根据行数自动计算，不再需要外部约束
  /// 同时会禁用垂直滚动
  final bool shrinkWrap;

  /// 行高，用于 shrinkWrap 时计算总高度
  /// 默认为 48（与 ShadTable 默认行高一致）
  final double rowHeight;

  /// 是否正在加载
  /// 当为 true 时，显示表头和加载指示器
  final bool loading;

  /// 列构建器
  final TableSpanBuilder? columnBuilder;

  /// 行构建器
  final TableSpanBuilder? rowBuilder;

  /// 行高度
  final TableSpanExtent? Function(int row)? rowSpanExtent;

  /// 列宽度
  final TableSpanExtent? Function(int column)? columnSpanExtent;

  /// 行背景装饰
  final TableSpanDecoration? Function(int row)? rowSpanBackgroundDecoration;

  /// 行前景装饰
  final TableSpanDecoration? Function(int row)? rowSpanForegroundDecoration;

  /// 列背景装饰
  final TableSpanDecoration? Function(int column)?
  columnSpanBackgroundDecoration;

  /// 列前景装饰
  final TableSpanDecoration? Function(int column)?
  columnSpanForegroundDecoration;

  /// 悬停行索引变化回调
  final ValueChanged<int?>? onHoveredRowIndex;

  /// 水平滚动控制器
  final ScrollController? horizontalScrollController;

  /// 垂直滚动控制器
  final ScrollController? verticalScrollController;

  /// 固定行数
  final int? pinnedRowCount;

  /// 固定列数
  final int? pinnedColumnCount;

  /// 是否为主滚动视图
  final bool? primary;

  /// 对角拖动行为
  final DiagonalDragBehavior? diagonalDragBehavior;

  /// 拖动开始行为
  final DragStartBehavior? dragStartBehavior;

  /// 键盘关闭行为
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  /// 垂直滚动物理特性
  final ScrollPhysics? verticalScrollPhysics;

  /// 水平滚动物理特性
  final ScrollPhysics? horizontalScrollPhysics;

  /// 支持的设备类型
  final Set<PointerDeviceKind>? supportedDevices;

  // ============ 原始 ShadTable 回调 ============

  /// 行点击回调
  final void Function(int row)? onRowTap;

  /// 行按下回调
  final void Function(int row)? onRowTapDown;

  /// 行抬起回调
  final void Function(int row)? onRowTapUp;

  /// 行点击取消回调
  final void Function(int row)? onRowTapCancel;

  /// 行右键点击回调
  final void Function(int row)? onRowSecondaryTap;

  /// 行右键抬起回调
  final void Function(int row)? onRowSecondaryTapUp;

  /// 行右键取消回调
  final void Function(int row)? onRowSecondaryTapCancel;

  /// 列点击回调
  final void Function(int column)? onColumnTap;

  /// 列按下回调
  final void Function(int column)? onColumnTapDown;

  /// 列抬起回调
  final void Function(int column)? onColumnTapUp;

  /// 列点击取消回调
  final void Function(int column)? onColumnTapCancel;

  /// 列右键点击回调
  final void Function(int column)? onColumnSecondaryTap;

  /// 列右键按下回调
  final void Function(int column)? onColumnSecondaryTapDown;

  /// 列右键抬起回调
  final void Function(int column)? onColumnSecondaryTapUp;

  /// 列右键取消回调
  final void Function(int column)? onColumnSecondaryTapCancel;

  // ============ 扩展回调 ============

  /// 行双击回调
  final void Function(int row)? onRowDoubleTap;

  /// 行右键按下回调（带详情）
  /// [row] - 行索引（数据行，不包含 header）
  /// [details] - 点击详情，包含 globalPosition 等信息
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
  });

  @override
  State<FoxyShadTable> createState() => _FoxyShadTableState();
}

class _FoxyShadTableState extends State<FoxyShadTable> {
  // 用于双击检测
  int? _lastTappedRow;
  Timer? _doubleTapTimer;
  static const _doubleTapTimeout = Duration(milliseconds: 300);

  // 用于右键点击位置捕获
  Offset? _lastSecondaryTapPosition;

  @override
  void dispose() {
    _doubleTapTimer?.cancel();
    super.dispose();
  }

  void _handleRowTap(int row) {
    // ShadTable 返回的 row 包含 header，需要调整
    final dataRow = widget.header != null ? row - 1 : row;

    // 忽略 header 行的点击
    if (dataRow < 0) return;

    // 先处理双击检测
    if (widget.onRowDoubleTap != null) {
      if (_lastTappedRow == dataRow && _doubleTapTimer?.isActive == true) {
        // 双击触发
        _doubleTapTimer?.cancel();
        _lastTappedRow = null;
        widget.onRowDoubleTap!(dataRow);
        return;
      }

      // 开始新的双击检测周期
      _lastTappedRow = dataRow;
      _doubleTapTimer?.cancel();
      _doubleTapTimer = Timer(_doubleTapTimeout, () {
        _lastTappedRow = null;
      });
    }

    // 触发原始的 onRowTap
    widget.onRowTap?.call(dataRow);
  }

  void _handleRowSecondaryTapDown(int row) {
    // ShadTable 返回的 row 包含 header，需要调整
    final dataRow = widget.header != null ? row - 1 : row;

    // 忽略 header 行的点击
    if (dataRow < 0) return;

    // 组合行索引和之前捕获的位置
    if (widget.onRowSecondaryTapDownWithDetails != null &&
        _lastSecondaryTapPosition != null) {
      final details = TapDownDetails(
        globalPosition: _lastSecondaryTapPosition!,
        localPosition: _lastSecondaryTapPosition!,
      );
      widget.onRowSecondaryTapDownWithDetails!(dataRow, details);
    }
  }

  void _handlePointerDown(PointerDownEvent event) {
    // 捕获右键点击的位置
    if (event.buttons == kSecondaryMouseButton) {
      _lastSecondaryTapPosition = event.position;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 计算 shrinkWrap 时的高度
    double? calculatedHeight;
    if (widget.shrinkWrap) {
      int totalRows = widget.rowCount;
      if (widget.header != null) totalRows += 1;
      if (widget.footer != null) totalRows += 1;
      calculatedHeight = totalRows * widget.rowHeight;
    }

    // shrinkWrap 时禁用垂直滚动
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
      verticalScrollController: widget.verticalScrollController,
      pinnedRowCount: widget.pinnedRowCount,
      pinnedColumnCount: widget.pinnedColumnCount,
      primary: widget.primary,
      diagonalDragBehavior: widget.diagonalDragBehavior,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      verticalScrollPhysics: effectiveVerticalScrollPhysics,
      horizontalScrollPhysics: widget.horizontalScrollPhysics,
      supportedDevices: widget.supportedDevices,
      // 行点击使用自定义处理（支持双击检测）
      onRowTap: _handleRowTap,
      onRowTapDown: widget.onRowTapDown,
      onRowTapUp: widget.onRowTapUp,
      onRowTapCancel: widget.onRowTapCancel,
      onRowSecondaryTap: widget.onRowSecondaryTap,
      // 行右键按下使用自定义处理（提供详情）
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

    // 使用 Listener 捕获右键点击位置
    if (widget.onRowSecondaryTapDownWithDetails != null) {
      table = Listener(onPointerDown: _handlePointerDown, child: table);
    }

    // shrinkWrap 时用 SizedBox 包裹
    if (widget.shrinkWrap && calculatedHeight != null) {
      table = SizedBox(height: calculatedHeight, child: table);
    }

    return table;
  }
}
