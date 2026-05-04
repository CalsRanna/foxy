import 'package:flutter/material.dart';
import 'package:foxy/entity/game_object_template_locale_entity.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/widget/locale_crud_dialog.dart';
import 'package:foxy/widget/locale_crud_view_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class GameObjectTemplateLocaleNameSelector extends StatefulWidget {
  final int? entry;
  final TextEditingController? controller;
  final String? placeholder;
  final bool readOnly;
  final String title;
  final bool isCaption;

  const GameObjectTemplateLocaleNameSelector({
    super.key,
    this.entry,
    this.controller,
    this.placeholder,
    this.readOnly = false,
    required this.title,
    this.isCaption = false,
  });

  @override
  State<GameObjectTemplateLocaleNameSelector> createState() =>
      _GameObjectTemplateLocaleNameSelectorState();
}

class _GameObjectTemplateLocaleNameSelectorState
    extends State<GameObjectTemplateLocaleNameSelector> {
  final repository = GameObjectTemplateRepository();

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
      fields: ['locale', 'name'],
      fieldLabels: ['语言', widget.isCaption ? '使用说明' : '名称'],
      onLoad: (entry) async {
        final locales = await repository.getGameObjectTemplateLocales(entry);
        return locales
            .map((e) => {'locale': e.locale, 'name': e.name})
            .toList();
      },
      onSave: (entry, data) async {
        final locales = data
            .map((d) => GameObjectTemplateLocaleEntity(
                  entry: entry,
                  locale: d['locale'] ?? '',
                  name: d['name'] ?? '',
                ))
            .toList();
        await repository.saveGameObjectTemplateLocales(entry, locales);
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
