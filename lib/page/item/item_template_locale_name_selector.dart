import 'package:flutter/material.dart';
import 'package:foxy/entity/item_template_locale_entity.dart';
import 'package:foxy/repository/item_template_locale_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ItemTemplateLocaleNameSelector extends StatefulWidget {
  final int? entry;
  final TextEditingController? controller;
  final String? placeholder;
  final bool readOnly;
  final String title;

  const ItemTemplateLocaleNameSelector({
    super.key,
    this.entry,
    this.controller,
    this.placeholder,
    this.readOnly = false,
    required this.title,
  });

  @override
  State<ItemTemplateLocaleNameSelector> createState() =>
      _ItemTemplateLocaleNameSelectorState();
}

class _ItemTemplateLocaleNameSelectorState
    extends State<ItemTemplateLocaleNameSelector> {
  final repository = ItemTemplateLocaleRepository();

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
    try {
      if (widget.entry == null) return;
      final locales = await repository.getItemTemplateLocales(widget.entry!);
      if (!mounted) return;
      await showShadDialog(
        context: context,
        builder: (context) {
          return _LocaleDialog(
            entry: widget.entry!,
            locales: locales,
            onSave: (locales) async {
              await repository.replaceAll(widget.entry!, locales);
            },
            title: widget.title,
          );
        },
      );
    } catch (e) {
      LoggerUtil.instance.e('加载本地化文本失败: $e');
      DialogUtil.instance.error('加载本地化文本失败: $e');
    }
  }
}

class _LocaleDialog extends StatefulWidget {
  final int entry;
  final List<ItemTemplateLocaleEntity> locales;
  final Future<void> Function(List<ItemTemplateLocaleEntity>) onSave;
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
              SizedBox(
                width: 40,
                child: ShadButton.ghost(
                  padding: EdgeInsets.zero,
                  onPressed: () => _removeRow(index),
                  size: ShadButtonSize.sm,
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
        return ItemTemplateLocaleEntity(
          id: widget.entry,
          locale: row.localeController.text,
          name: row.nameController.text,
        );
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

  _LocaleRow()
    : localeController = TextEditingController(),
      nameController = TextEditingController();

  _LocaleRow.fromLocale(ItemTemplateLocaleEntity locale)
    : localeController = TextEditingController(text: locale.locale),
      nameController = TextEditingController(text: locale.name);

  void dispose() {
    localeController.dispose();
    nameController.dispose();
  }
}
