import 'package:flutter/material.dart';
import 'package:foxy/model/quest_template_locale.dart';
import 'package:foxy/repository/quest_template_locale_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestTemplateLocaleSelector extends StatefulWidget {
  final int? questId;
  final TextEditingController? controller;
  final String? placeholder;
  final bool readOnly;
  final String title;

  const QuestTemplateLocaleSelector({
    super.key,
    this.questId,
    this.controller,
    this.placeholder,
    this.readOnly = false,
    required this.title,
  });

  @override
  State<QuestTemplateLocaleSelector> createState() =>
      _QuestTemplateLocaleSelectorState();
}

class _QuestTemplateLocaleSelectorState
    extends State<QuestTemplateLocaleSelector> {
  final repository = QuestTemplateLocaleRepository();

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
    if (widget.questId == null) return;
    final locales = await repository.getQuestTemplateLocales(widget.questId!);
    if (!mounted) return;
    await showShadDialog(
      context: context,
      builder: (context) {
        return _LocaleDialog(
          questId: widget.questId!,
          locales: locales,
          onSave: (locales) async {
            await repository.replaceAll(widget.questId!, locales);
          },
          title: widget.title,
        );
      },
    );
  }
}

class _LocaleDialog extends StatefulWidget {
  final int questId;
  final List<QuestTemplateLocale> locales;
  final Future<void> Function(List<QuestTemplateLocale>) onSave;
  final String title;

  const _LocaleDialog({
    required this.questId,
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
          Expanded(child: Text('标题', style: theme.textTheme.muted)),
          SizedBox(width: 16),
          Expanded(child: Text('详情', style: theme.textTheme.muted)),
          SizedBox(width: 16),
          Expanded(child: Text('目标', style: theme.textTheme.muted)),
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
                  controller: row.titleController,
                  placeholder: Text('标题'),
                ),
              ),
              Expanded(
                child: ShadInput(
                  controller: row.detailsController,
                  placeholder: Text('详情'),
                ),
              ),
              Expanded(
                child: ShadInput(
                  controller: row.objectivesController,
                  placeholder: Text('目标'),
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
        return QuestTemplateLocale(
          id: widget.questId,
          locale: row.localeController.text,
          title: row.titleController.text,
          details: row.detailsController.text,
          objectives: row.objectivesController.text,
          endText: row.endTextController.text,
          completedText: row.completedTextController.text,
          objectiveText1: row.objectiveText1Controller.text,
          objectiveText2: row.objectiveText2Controller.text,
          objectiveText3: row.objectiveText3Controller.text,
          objectiveText4: row.objectiveText4Controller.text,
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
  final TextEditingController titleController;
  final TextEditingController detailsController;
  final TextEditingController objectivesController;
  final TextEditingController endTextController;
  final TextEditingController completedTextController;
  final TextEditingController objectiveText1Controller;
  final TextEditingController objectiveText2Controller;
  final TextEditingController objectiveText3Controller;
  final TextEditingController objectiveText4Controller;

  _LocaleRow()
    : localeController = TextEditingController(),
      titleController = TextEditingController(),
      detailsController = TextEditingController(),
      objectivesController = TextEditingController(),
      endTextController = TextEditingController(),
      completedTextController = TextEditingController(),
      objectiveText1Controller = TextEditingController(),
      objectiveText2Controller = TextEditingController(),
      objectiveText3Controller = TextEditingController(),
      objectiveText4Controller = TextEditingController();

  _LocaleRow.fromLocale(QuestTemplateLocale locale)
    : localeController = TextEditingController(text: locale.locale),
      titleController = TextEditingController(text: locale.title),
      detailsController = TextEditingController(text: locale.details),
      objectivesController = TextEditingController(text: locale.objectives),
      endTextController = TextEditingController(text: locale.endText),
      completedTextController = TextEditingController(
        text: locale.completedText,
      ),
      objectiveText1Controller = TextEditingController(
        text: locale.objectiveText1,
      ),
      objectiveText2Controller = TextEditingController(
        text: locale.objectiveText2,
      ),
      objectiveText3Controller = TextEditingController(
        text: locale.objectiveText3,
      ),
      objectiveText4Controller = TextEditingController(
        text: locale.objectiveText4,
      );

  void dispose() {
    localeController.dispose();
    titleController.dispose();
    detailsController.dispose();
    objectivesController.dispose();
    endTextController.dispose();
    completedTextController.dispose();
    objectiveText1Controller.dispose();
    objectiveText2Controller.dispose();
    objectiveText3Controller.dispose();
    objectiveText4Controller.dispose();
  }
}
