import 'package:flutter/material.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// NPC 文本选择器（供 gossip_menu.TextID 字段使用）
class NpcTextSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;

  const NpcTextSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<NpcTextSelector> createState() => _NpcTextSelectorState();
}

class _NpcTextSelectorState extends State<NpcTextSelector> {
  @override
  Widget build(BuildContext context) {
    final button = ShadButton.ghost(
      height: 20,
      width: 20,
      padding: EdgeInsets.zero,
      onPressed: _openDialog,
      child: Icon(LucideIcons.search, size: 12),
    );
    return ShadInput(
      controller: widget.controller,
      placeholder: Text(widget.placeholder ?? ''),
      trailing: button,
    );
  }

  Future<void> _openDialog() async {
    final current = int.tryParse(widget.controller.text);
    final result = await showShadDialog<int>(
      context: context,
      builder: (context) => _Dialog(initialValue: current),
    );
    if (result == null) return;
    widget.controller.text = result.toString();
  }
}

class _Dialog extends StatefulWidget {
  final int? initialValue;
  const _Dialog({this.initialValue});

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final _idController = TextEditingController();
  final _textController = TextEditingController();

  List<NpcTextEntity> _items = [];
  int _total = 0;
  int _page = 1;
  int? _selectedId;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue != 0) {
      _idController.text = widget.initialValue!.toString();
      _selectedId = widget.initialValue;
    }
    _search();
  }

  @override
  void dispose() {
    _idController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cancel = ShadButton.outline(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('取消'),
    );
    final confirm = ShadButton(
      onPressed: () => Navigator.of(context).pop(_selectedId),
      child: Text('确定'),
    );
    return ShadDialog(
      title: Text('NPC 文本'),
      actions: [
        _buildPagination(),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [cancel, confirm],
        ),
      ],
      actionsMainAxisAlignment: MainAxisAlignment.spaceBetween,
      actionsMainAxisSize: MainAxisSize.max,
      constraints: BoxConstraints(maxWidth: 720),
      child: Column(spacing: 8, children: [_buildFilter(), _buildTable()]),
    );
  }

  Widget _buildFilter() {
    final idInput = ShadInput(
      controller: _idController,
      placeholder: Text('ID'),
    );
    final textInput = ShadInput(
      controller: _textController,
      placeholder: Text('文本内容'),
    );
    final searchBtn = ShadButton(
      onPressed: _doSearch,
      size: ShadButtonSize.sm,
      child: Text('查询'),
    );
    final resetBtn = ShadButton.ghost(
      onPressed: _reset,
      size: ShadButtonSize.sm,
      child: Text('重置'),
    );
    final children = [
      Expanded(child: idInput),
      Expanded(child: textInput),
      Expanded(child: Row(spacing: 8, children: [searchBtn, resetBtn])),
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 8, children: children),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FoxyPagination(
          page: _page,
          pageSize: 50,
          total: _total,
          onChange: _paginate,
        ),
      ],
    );
  }

  Widget _buildTable() {
    final theme = ShadTheme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.5;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth - 120;
          return FoxyShadTable(
            columnCount: 2,
            rowCount: _items.length,
            pinnedRowCount: 1,
            header: (context, column) {
              return switch (column) {
                0 => ShadTableCell.header(child: Text('ID')),
                1 => ShadTableCell.header(child: Text('文本（text0_0 / text0_1）')),
                _ => ShadTableCell.header(child: SizedBox()),
              };
            },
            columnSpanExtent: (column) {
              return switch (column) {
                0 => FixedTableSpanExtent(120),
                1 => FixedTableSpanExtent(width),
                _ => null,
              };
            },
            rowSpanBackgroundDecoration: (row) {
              final dataRow = row - 1;
              if (dataRow < 0 || dataRow >= _items.length) return null;
              if (_items[dataRow].id == _selectedId) {
                return TableSpanDecoration(color: theme.colorScheme.accent);
              }
              return null;
            },
            onRowTap: (row) {
              if (row >= 0 && row < _items.length) {
                setState(() => _selectedId = _items[row].id);
              }
            },
            onRowDoubleTap: (row) {
              if (row >= 0 && row < _items.length) {
                Navigator.of(context).pop(_items[row].id);
              }
            },
            builder: (context, vicinity) {
              if (vicinity.row < 0 || vicinity.row >= _items.length) {
                return ShadTableCell(child: SizedBox());
              }
              final item = _items[vicinity.row];
              final text = item.entries[0].text0.isNotEmpty
                  ? item.entries[0].text0
                  : item.entries[0].text1;
              return switch (vicinity.column) {
                0 => ShadTableCell(child: Text(item.id.toString())),
                1 => ShadTableCell(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _ => ShadTableCell(child: SizedBox()),
              };
            },
          );
        },
      ),
    );
  }

  void _doSearch() {
    _page = 1;
    _search();
  }

  void _paginate(int page) {
    _page = page;
    _search();
  }

  void _reset() {
    _idController.clear();
    _textController.clear();
    _page = 1;
    _search();
  }

  Future<void> _search() async {
    try {
      final repo = NpcTextRepository();
      final id = _idController.text.isEmpty ? null : _idController.text;
      final text = _textController.text.isEmpty ? null : _textController.text;
      final items = await repo.getNpcTextsPaginated(
        id: id,
        text: text,
        page: _page,
      );
      final total = await repo.countNpcTexts(id: id, text: text);
      if (mounted) {
        setState(() {
          _items = items;
          _total = total;
        });
      }
    } finally {}
  }
}
