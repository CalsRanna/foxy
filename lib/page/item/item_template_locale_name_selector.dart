import 'package:flutter/material.dart';
import 'package:foxy/entity/item_template_locale_entity.dart';
import 'package:foxy/repository/item_template_locale_repository.dart';
import 'package:foxy/widget/locale_crud_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:get_it/get_it.dart';

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
  final _repository = GetIt.instance.get<ItemTemplateLocaleRepository>();

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
    await LocaleCrudDialog.show(
      context,
      title: widget.title,
      entry: widget.entry!,
      fields: ['locale', 'name'],
      fieldLabels: ['语言', '名称'],
      onLoad: () async {
        final locales =
            await _repository.getItemTemplateLocales(widget.entry!);
        return locales
            .map((e) => {'locale': e.locale, 'name': e.name})
            .toList();
      },
      onSave: (data) async {
        final locales = data
            .map(
              (d) => ItemTemplateLocaleEntity(
                id: widget.entry!,
                locale: d['locale'] ?? '',
                name: d['name'] ?? '',
              ),
            )
            .toList();
        await _repository.replaceAll(widget.entry!, locales);
      },
    );
  }
}
