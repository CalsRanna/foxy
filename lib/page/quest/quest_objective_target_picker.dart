import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestObjectiveTargetPicker extends StatefulWidget {
  final IntFieldController controller;
  final String? placeholder;

  const QuestObjectiveTargetPicker({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<QuestObjectiveTargetPicker> createState() =>
      _QuestObjectiveTargetPickerState();
}

class _QuestObjectiveTargetPickerState
    extends State<QuestObjectiveTargetPicker> {
  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: widget.controller.controller,
      placeholder: Text(widget.placeholder ?? ''),
      trailing: ShadButton.ghost(
        height: 20,
        width: 20,
        padding: EdgeInsets.zero,
        onPressed: _openDialog,
        child: const Icon(LucideIcons.search, size: 12),
      ),
    );
  }

  Future<void> _openDialog() async {
    final result = await showFoxyDialog<int>(
      context: context,
      builder: (context) =>
          _TargetDialog(initialValue: widget.controller.collect()),
    );
    if (result != null) widget.controller.init(result);
  }
}

class _TargetDialog extends StatefulWidget {
  final int initialValue;

  const _TargetDialog({required this.initialValue});

  @override
  State<_TargetDialog> createState() => _TargetDialogState();
}

class _TargetDialogState extends State<_TargetDialog>
    with FieldControllerMixin {
  late final targetController = registerController(IntFieldController());
  late bool isGameObject;

  @override
  void initState() {
    super.initState();
    isGameObject = widget.initialValue < 0;
    targetController.init(widget.initialValue.abs());
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: const Text('任务目标'),
      constraints: const BoxConstraints(maxWidth: 560),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ShadButton(
          onPressed: () {
            final id = targetController.collect();
            Navigator.of(context).pop(isGameObject ? -id : id);
          },
          child: const Text('确定'),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Row(
            spacing: 8,
            children: [
              ShadButton(
                size: ShadButtonSize.sm,
                onPressed: isGameObject ? _selectCreature : null,
                child: const Text('生物'),
              ),
              ShadButton(
                size: ShadButtonSize.sm,
                onPressed: isGameObject ? null : _selectGameObject,
                child: const Text('游戏对象'),
              ),
            ],
          ),
          FoxyEntityPicker(
            controller: targetController,
            delegate: isGameObject
                ? FoxyEntityPickerDelegates.gameObjectTemplate
                : FoxyEntityPickerDelegates.creatureTemplate,
            placeholder: isGameObject ? 'GameObject ID' : 'Creature ID',
          ),
        ],
      ),
    );
  }

  void _selectCreature() {
    setState(() {
      isGameObject = false;
      targetController.init(0);
    });
  }

  void _selectGameObject() {
    setState(() {
      isGameObject = true;
      targetController.init(0);
    });
  }
}
