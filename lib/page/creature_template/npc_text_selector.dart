import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/npc_text_selector_view_model.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class NpcTextSelector extends StatefulWidget {
  final Signal<int> signal;
  final String? placeholder;

  const NpcTextSelector({
    super.key,
    required this.signal,
    this.placeholder,
  });

  @override
  State<NpcTextSelector> createState() => _NpcTextSelectorState();
}

class _NpcTextSelectorState extends State<NpcTextSelector> {
  final _displayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _syncDisplay();
  }

  void _syncDisplay() {
    final v = widget.signal.value;
    _displayController.text = v == 0 ? '' : v.toString();
  }

  @override
  void dispose() {
    _displayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: _displayController,
      placeholder: Text(widget.placeholder ?? ''),
      readOnly: true,
      trailing: ShadButton.ghost(
        height: 20,
        padding: EdgeInsets.zero,
        onPressed: _openDialog,
        width: 20,
        child: Icon(LucideIcons.search, size: 12),
      ),
    );
  }

  Future<void> _openDialog() async {
    final vm = NpcTextSelectorViewModel();
    if (widget.signal.value != 0) {
      vm.idFilter.value = widget.signal.value.toString();
      vm.selectedId.value = widget.signal.value;
      await vm.search();
    }

    final result = await showShadDialog<int>(
      context: context,
      builder: (context) => _Dialog(vm: vm),
    );
    vm.dispose();
    if (result != null) {
      widget.signal.value = result;
      _syncDisplay();
    }
  }
}

class _Dialog extends StatefulWidget {
  final NpcTextSelectorViewModel vm;

  const _Dialog({required this.vm});

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final _idController = TextEditingController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _idController.text = widget.vm.idFilter.value;
    _textController.text = widget.vm.textFilter.value;
  }

  @override
  void dispose() {
    _idController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text('NPC 文本'),
      actions: [
        Watch((_) {
          return FoxyPagination(
            page: widget.vm.page.value,
            pageSize: 50,
            total: widget.vm.total.value,
            onChange: (p) => widget.vm.paginate(p),
          );
        }),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            ShadButton.outline(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('取消'),
            ),
            ShadButton(
              onPressed: () => Navigator.of(context).pop(widget.vm.selectedId.value),
              child: Text('确定'),
            ),
          ],
        ),
      ],
      actionsMainAxisAlignment: MainAxisAlignment.spaceBetween,
      actionsMainAxisSize: MainAxisSize.max,
      constraints: BoxConstraints(maxWidth: 720),
      child: Column(spacing: 8, children: [
        _buildFilter(),
        _buildTable(),
      ]),
    );
  }

  Widget _buildFilter() {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 8, children: [
        Expanded(
          child: ShadInput(
            controller: _idController,
            placeholder: Text('ID'),
          ),
        ),
        Expanded(
          child: ShadInput(
            controller: _textController,
            placeholder: Text('文本内容'),
          ),
        ),
        Expanded(
          child: Row(spacing: 8, children: [
            ShadButton(
              onPressed: () {
                widget.vm.idFilter.value = _idController.text;
                widget.vm.textFilter.value = _textController.text;
                widget.vm.page.value = 1;
                widget.vm.search();
              },
              size: ShadButtonSize.sm,
              child: Text('查询'),
            ),
            ShadButton.ghost(
              onPressed: () {
                _idController.clear();
                _textController.clear();
                widget.vm.reset();
              },
              size: ShadButtonSize.sm,
              child: Text('重置'),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _buildTable() {
    final theme = ShadTheme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.5;

    return Watch((_) {
      final items = widget.vm.items.value;
      final selectedId = widget.vm.selectedId.value;

      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth - 120;
            return FoxyShadTable(
              columnCount: 2,
              rowCount: items.length,
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
                if (dataRow < 0 || dataRow >= items.length) return null;
                if (items[dataRow].id == selectedId) {
                  return TableSpanDecoration(color: theme.colorScheme.accent);
                }
                return null;
              },
              onRowTap: (row) {
                if (row >= 0 && row < items.length) {
                  widget.vm.select(items[row].id);
                }
              },
              onRowDoubleTap: (row) {
                if (row >= 0 && row < items.length) {
                  Navigator.of(context).pop(items[row].id);
                }
              },
              builder: (context, vicinity) {
                if (vicinity.row < 0 || vicinity.row >= items.length) {
                  return ShadTableCell(child: SizedBox());
                }
                final item = items[vicinity.row];
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
    });
  }
}
