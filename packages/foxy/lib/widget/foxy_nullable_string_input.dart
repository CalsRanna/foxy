import 'package:flutter/material.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Input that can explicitly switch between database `NULL` and plain
/// text (including empty strings).
class FoxyNullableStringInput extends StatelessWidget {
  final NullableStringFieldController controller;
  final String? placeholder;

  const FoxyNullableStringInput({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.isNull,
      builder: (context, isNull, _) => Row(
        spacing: 8,
        children: [
          Expanded(
            child: ShadInput(
              controller: controller.controller,
              placeholder: Text(placeholder ?? ''),
              readOnly: isNull,
            ),
          ),
          ShadCheckbox(value: isNull, onChanged: controller.setNull),
          const Text('NULL'),
        ],
      ),
    );
  }
}
