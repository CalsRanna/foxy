import 'package:flutter/material.dart';
import 'package:foxy/model/creature_template_locale.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreatureTemplateLocaleNameSelector extends StatefulWidget {
  final int? entry;
  final TextEditingController? controller;
  final String? placeholder;
  final bool readOnly;
  final String title;

  const CreatureTemplateLocaleNameSelector({
    super.key,
    this.entry,
    this.controller,
    this.placeholder,
    this.readOnly = false,
    required this.title,
  });

  @override
  State<CreatureTemplateLocaleNameSelector> createState() =>
      _CreatureTemplateLocaleNameSelectorState();
}

class _CreatureTemplateLocaleNameSelectorState
    extends State<CreatureTemplateLocaleNameSelector> {
  final repository = CreatureTemplateRepository();

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: widget.controller,
      placeholder: Text(widget.placeholder ?? ''),
      readOnly: widget.readOnly,
      trailing: ShadButton.ghost(
        height: 20,
        width: 20,
        padding: EdgeInsets.zero,
        onPressed: _openLocaleDialog,
        child: Icon(LucideIcons.globe, size: 12),
      ),
    );
  }

  Future<void> _openLocaleDialog() async {
    if (widget.entry == null) return;
    final locales = await repository.getCreatureTemplateLocales(widget.entry!);
    if (!mounted) return;
    await showShadDialog(
      context: context,
      builder: (context) {
        return _LocaleDialog(
          entry: widget.entry!,
          locales: locales,
          onSave: (locales) async {
            await repository.saveCreatureTemplateLocales(
              widget.entry!,
              locales,
            );
          },
          title: widget.title,
        );
      },
    );
  }
}

class _LocaleDialog extends StatefulWidget {
  final int entry;
  final List<CreatureTemplateLocale> locales;
  final Future<void> Function(List<CreatureTemplateLocale>) onSave;
  final String title;

  const _LocaleDialog({
    required this.entry,
    required this.locales,
    required this.onSave,
    required this.title,
  });

  @override
  State<_LocaleDialog> createState() => _LocaleDialogState();
}

class _LocaleDialogState extends State<_LocaleDialog> {
  late List<_LocaleRow> _rows;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _rows = widget.locales.map((e) => _LocaleRow.fromLocale(e)).toList();
  }

  @override
  void dispose() {
    for (var row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadDialog(
      title: Text(widget.title),
      // description: Text('编号: ${widget.entry}'),
      constraints: BoxConstraints(maxWidth: 720),
      actions: [
        ShadButton.outline(onPressed: _addRow, child: Text('添加')),
        const Spacer(),
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
        ShadButton(
          onPressed: _saving ? null : _save,
          child: _saving ? Text('保存中...') : Text('保存'),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(theme),
          Flexible(child: _buildTable()),
        ],
      ),
    );
  }

  Widget _buildHeader(ShadThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colorScheme.border)),
      ),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text('语言', style: theme.textTheme.muted)),
          SizedBox(width: 16),
          Expanded(child: Text('名称', style: theme.textTheme.muted)),
          SizedBox(width: 16),
          Expanded(child: Text('称号', style: theme.textTheme.muted)),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildTable() {
    if (_rows.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(32),
        child: Text('暂无多语言数据，点击添加按钮新增'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _rows.length,
      itemBuilder: (context, index) {
        final row = _rows[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            spacing: 16,
            children: [
              SizedBox(
                width: 100,
                child: ShadInput(
                  controller: row.localeController,
                  placeholder: Text('zhCN'),
                ),
              ),
              Expanded(
                child: ShadInput(
                  controller: row.nameController,
                  placeholder: Text('名称'),
                ),
              ),
              Expanded(
                child: ShadInput(
                  controller: row.titleController,
                  placeholder: Text('称号'),
                ),
              ),
              SizedBox(
                width: 40,
                child: ShadButton.ghost(
                  padding: EdgeInsets.zero,
                  onPressed: () => _removeRow(index),
                  child: Icon(LucideIcons.trash, size: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addRow() {
    setState(() {
      _rows.add(_LocaleRow());
    });
  }

  void _removeRow(int index) {
    setState(() {
      _rows[index].dispose();
      _rows.removeAt(index);
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final locales = _rows.map((row) {
        return CreatureTemplateLocale()
          ..entry = widget.entry
          ..locale = row.localeController.text
          ..name = row.nameController.text
          ..title = row.titleController.text;
      }).toList();
      await widget.onSave(locales);
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _LocaleRow {
  final TextEditingController localeController;
  final TextEditingController nameController;
  final TextEditingController titleController;

  _LocaleRow()
    : localeController = TextEditingController(),
      nameController = TextEditingController(),
      titleController = TextEditingController();

  _LocaleRow.fromLocale(CreatureTemplateLocale locale)
    : localeController = TextEditingController(text: locale.locale),
      nameController = TextEditingController(text: locale.name),
      titleController = TextEditingController(text: locale.title);

  void dispose() {
    localeController.dispose();
    nameController.dispose();
    titleController.dispose();
  }
}
