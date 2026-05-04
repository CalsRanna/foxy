import 'package:flutter/material.dart';
import 'package:foxy/entity/creature_template_locale_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/widget/locale_crud_dialog.dart';
import 'package:foxy/widget/locale_crud_view_model.dart';
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
    final vm = LocaleCrudViewModel(
      entry: widget.entry!,
      fields: ['locale', 'name', 'title'],
      fieldLabels: ['语言', '名称', '称号'],
      onLoad: (entry) async {
        final locales = await repository.getCreatureTemplateLocales(entry);
        return locales
            .map((e) => {'locale': e.locale, 'name': e.name, 'title': e.title})
            .toList();
      },
      onSave: (entry, data) async {
        final locales = data
            .map((d) => CreatureTemplateLocaleEntity()
              ..entry = entry
              ..locale = d['locale'] ?? ''
              ..name = d['name'] ?? ''
              ..title = d['title'] ?? '')
            .toList();
        await repository.saveCreatureTemplateLocales(entry, locales);
      },
    );
    await LocaleCrudDialog(
      title: widget.title,
      entry: widget.entry!,
      vm: vm,
    ).show(context);
    vm.dispose();
  }
}
