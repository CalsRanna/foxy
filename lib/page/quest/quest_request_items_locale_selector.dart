import 'package:flutter/material.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/repository/quest_request_items_locale_repository.dart';
import 'package:foxy/widget/locale_crud_dialog.dart';
import 'package:foxy/widget/locale_crud_view_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestRequestItemsLocaleSelector extends StatefulWidget {
  final int? questId;
  final TextEditingController? controller;
  final String? placeholder;
  final bool readOnly;
  final String title;

  const QuestRequestItemsLocaleSelector({
    super.key,
    this.questId,
    this.controller,
    this.placeholder,
    this.readOnly = false,
    required this.title,
  });

  @override
  State<QuestRequestItemsLocaleSelector> createState() =>
      _QuestRequestItemsLocaleSelectorState();
}

class _QuestRequestItemsLocaleSelectorState
    extends State<QuestRequestItemsLocaleSelector> {
  final repository = QuestRequestItemsLocaleRepository();

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
      fields: ['locale', 'completionText'],
      fieldLabels: ['语言', '完成文本'],
      onLoad: (questId) async {
        final locales = await repository.getQuestRequestItemsLocales(questId);
        return locales
            .map((e) => {
                  'locale': e.locale,
                  'completionText': e.completionText,
                })
            .toList();
      },
      onSave: (questId, data) async {
        final locales = data
            .map((d) => QuestRequestItemsLocaleEntity(
                  id: questId,
                  locale: d['locale'] ?? '',
                  completionText: d['completionText'] ?? '',
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
