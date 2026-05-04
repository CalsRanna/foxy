import 'package:flutter/material.dart';
import 'package:foxy/entity/item_template_locale_entity.dart';
import 'package:foxy/repository/item_template_locale_repository.dart';
import 'package:foxy/widget/locale_crud_dialog.dart';
import 'package:foxy/widget/locale_crud_view_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ItemTemplateLocaleDescriptionSelector extends StatefulWidget {
  final int? entry;
  final TextEditingController? controller;
  final String? placeholder;
  final bool readOnly;
  final String title;

  const ItemTemplateLocaleDescriptionSelector({
    super.key,
    this.entry,
    this.controller,
    this.placeholder,
    this.readOnly = false,
    required this.title,
  });

  @override
  State<ItemTemplateLocaleDescriptionSelector> createState() =>
      _ItemTemplateLocaleDescriptionSelectorState();
}

class _ItemTemplateLocaleDescriptionSelectorState
    extends State<ItemTemplateLocaleDescriptionSelector> {
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
    if (widget.entry == null) return;
    final vm = LocaleCrudViewModel(
      entry: widget.entry!,
      fields: ['locale', 'description'],
      fieldLabels: ['语言', '描述'],
      onLoad: (entry) async {
        final locales = await repository.getItemTemplateLocales(entry);
        return locales
            .map((e) => {
                  'locale': e.locale,
                  'description': e.description,
                })
            .toList();
      },
      onSave: (entry, data) async {
        final locales = data
            .map((d) => ItemTemplateLocaleEntity(
                  id: entry,
                  locale: d['locale'] ?? '',
                  description: d['description'] ?? '',
                ))
            .toList();
        await repository.replaceAll(entry, locales);
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
