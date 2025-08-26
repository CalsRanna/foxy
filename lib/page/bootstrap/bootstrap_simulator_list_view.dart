import 'package:flutter/material.dart';

class BootstrapSimulatorWrapView extends StatelessWidget {
  final void Function(bool)? onAdd;
  const BootstrapSimulatorWrapView({super.key, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: [
        ChoiceChip(
          label: Text('Azeroth'),
          selected: true,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: Text('Trinity'),
          selected: false,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: Text('Mangos'),
          selected: false,
          onSelected: (value) {},
        ),
      ],
    );
  }
}
