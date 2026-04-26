import 'package:flutter/material.dart';
import 'package:foxy/model/quest_offer_reward.dart';
import 'package:foxy/repository/quest_offer_reward_locale_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestOfferRewardLocaleSelector extends StatefulWidget {
  final int? questId;
  final TextEditingController? controller;
  final String? placeholder;
  final bool readOnly;
  final String title;

  const QuestOfferRewardLocaleSelector({
    super.key,
    this.questId,
    this.controller,
    this.placeholder,
    this.readOnly = false,
    required this.title,
  });

  @override
  State<QuestOfferRewardLocaleSelector> createState() =>
      _QuestOfferRewardLocaleSelectorState();
}

class _QuestOfferRewardLocaleSelectorState
    extends State<QuestOfferRewardLocaleSelector> {
  final repository = QuestOfferRewardLocaleRepository();

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
    final locales = await repository.search(widget.questId!);
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
  final List<QuestOfferRewardLocale> locales;
  final Future<void> Function(List<QuestOfferRewardLocale>) onSave;
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
          Expanded(child: Text('奖励文本', style: theme.textTheme.muted)),
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
                  controller: row.rewardTextController,
                  placeholder: Text('RewardText'),
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
        return QuestOfferRewardLocale()
          ..id = widget.questId
          ..locale = row.localeController.text
          ..rewardText = row.rewardTextController.text;
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
  final TextEditingController rewardTextController;

  _LocaleRow()
    : localeController = TextEditingController(),
      rewardTextController = TextEditingController();

  _LocaleRow.fromLocale(QuestOfferRewardLocale locale)
    : localeController = TextEditingController(text: locale.locale),
      rewardTextController = TextEditingController(text: locale.rewardText);

  void dispose() {
    localeController.dispose();
    rewardTextController.dispose();
  }
}