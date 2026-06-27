import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_selector_view_model.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class CreatureTemplateSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;

  const CreatureTemplateSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<CreatureTemplateSelector> createState() =>
      _CreatureTemplateSelectorState();
}

class _CreatureTemplateSelectorState extends State<CreatureTemplateSelector> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: widget.controller,
      placeholder: Text(widget.placeholder ?? ''),
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
    final vm = CreatureTemplateSelectorViewModel();
    final currentId = int.tryParse(widget.controller.text) ?? 0;
    if (currentId != 0) {
      vm.entryFilter.value = currentId.toString();
      vm.selectedId.value = currentId;
      await vm.search();
    }
    if (!mounted) return;

    final result = await showShadDialog<int>(
      context: context,
      builder: (context) => _Dialog(vm: vm),
    );
    vm.dispose();
    if (result != null) {
      widget.controller.text = result.toString();
    }
  }
}

class _Dialog extends StatefulWidget {
  final CreatureTemplateSelectorViewModel vm;

  const _Dialog({required this.vm});

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final _entryController = TextEditingController();
  final _nameController = TextEditingController();


  @override
  void dispose() {
    _entryController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text('生物模板'),
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
            controller: _entryController,
            placeholder: Text('编号'),
          ),
        ),
        Expanded(
          child: ShadInput(
            controller: _nameController,
            placeholder: Text('名称'),
          ),
        ),
        Expanded(
          child: Row(spacing: 8, children: [
            ShadButton(
              onPressed: () {
                widget.vm.entryFilter.value = _entryController.text;
                widget.vm.nameFilter.value = _nameController.text;
                widget.vm.page.value = 1;
                widget.vm.search();
              },
              size: ShadButtonSize.sm,
              child: Text('查询'),
            ),
            ShadButton.ghost(
              onPressed: () {
                _entryController.clear();
                _nameController.clear();
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
    final tableMaxHeight = screenHeight * 0.5;

    return Watch((_) {
      final items = widget.vm.items.value;
      final selectedId = widget.vm.selectedId.value;

      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: tableMaxHeight),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            var nameWidth = maxWidth - 240;
            return FoxyShadTable(
              columnCount: 3,
              rowCount: items.length,
              pinnedRowCount: 1,
              header: (context, column) {
                return switch (column) {
                  0 => ShadTableCell.header(child: Text('编号')),
                  1 => ShadTableCell.header(child: Text('名称')),
                  2 => ShadTableCell.header(child: Text('等级')),
                  _ => ShadTableCell.header(child: SizedBox()),
                };
              },
              columnSpanExtent: (column) {
                return switch (column) {
                  0 => FixedTableSpanExtent(120),
                  1 => FixedTableSpanExtent(nameWidth),
                  2 => FixedTableSpanExtent(120),
                  _ => null,
                };
              },
              rowSpanBackgroundDecoration: (row) {
                final dataRow = row - 1;
                if (dataRow < 0 || dataRow >= items.length) return null;
                if (items[dataRow].entry == selectedId) {
                  return TableSpanDecoration(color: theme.colorScheme.accent);
                }
                return null;
              },
              onRowTap: (row) {
                if (row >= 0 && row < items.length) {
                  widget.vm.select(items[row].entry);
                }
              },
              onRowDoubleTap: (row) {
                if (row >= 0 && row < items.length) {
                  Navigator.of(context).pop(items[row].entry);
                }
              },
              builder: (context, vicinity) {
                if (vicinity.row < 0 || vicinity.row >= items.length) {
                  return ShadTableCell(child: SizedBox());
                }
                final item = items[vicinity.row];
                return switch (vicinity.column) {
                  0 => ShadTableCell(child: Text(item.entry.toString())),
                  1 => ShadTableCell(
                    child: Text(
                      item.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  2 => ShadTableCell(
                    child: Text('${item.minLevel} / ${item.maxLevel}'),
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
