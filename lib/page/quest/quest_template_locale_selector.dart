import 'package:flutter/material.dart';
import 'package:foxy/entity/quest_template_locale_entity.dart';
import 'package:foxy/repository/quest_template_locale_repository.dart';
import 'package:foxy/widget/locale_crud_dialog.dart';
import 'package:foxy/widget/locale_crud_view_model.dart';
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
    final vm = LocaleCrudViewModel(
      entry: widget.questId!,
      fields: [
        'locale',
        'title',
        'details',
        'objectives',
        'endText',
        'completedText',
        'objectiveText1',
        'objectiveText2',
        'objectiveText3',
        'objectiveText4',
      ],
      fieldLabels: [
        '语言',
        '标题',
        '详情',
        '目标',
        '结束文本',
        '完成文本',
        '目标文本1',
        '目标文本2',
        '目标文本3',
        '目标文本4',
      ],
      onLoad: (questId) async {
        final locales = await repository.getQuestTemplateLocales(questId);
        return locales
            .map((e) => {
                  'locale': e.locale,
                  'title': e.title,
                  'details': e.details,
                  'objectives': e.objectives,
                  'endText': e.endText,
                  'completedText': e.completedText,
                  'objectiveText1': e.objectiveText1,
                  'objectiveText2': e.objectiveText2,
                  'objectiveText3': e.objectiveText3,
                  'objectiveText4': e.objectiveText4,
                })
            .toList();
      },
      onSave: (questId, data) async {
        final locales = data
            .map((d) => QuestTemplateLocaleEntity(
                  id: questId,
                  locale: d['locale'] ?? '',
                  title: d['title'] ?? '',
                  details: d['details'] ?? '',
                  objectives: d['objectives'] ?? '',
                  endText: d['endText'] ?? '',
                  completedText: d['completedText'] ?? '',
                  objectiveText1: d['objectiveText1'] ?? '',
                  objectiveText2: d['objectiveText2'] ?? '',
                  objectiveText3: d['objectiveText3'] ?? '',
                  objectiveText4: d['objectiveText4'] ?? '',
                ))
            .toList();
        await repository.replaceAll(questId, locales);
      },
    );
    await LocaleCrudDialog(
      title: widget.title,
      entry: widget.questId!,
      vm: vm,
    ).show(context);
    vm.dispose();
  }
}
