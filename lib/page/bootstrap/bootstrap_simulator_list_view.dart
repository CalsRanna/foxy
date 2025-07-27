import 'package:flutter/material.dart';
import 'package:foxy/page/bootstrap/bootstrap_simulator_list_tile.dart';
import 'package:hugeicons/hugeicons.dart';

class BootstrapSimulatorListView extends StatelessWidget {
  final void Function(bool)? onAdd;
  const BootstrapSimulatorListView({super.key, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BootstrapSimulatorListTile(child: Text('Azeroth')),
          BootstrapSimulatorListTile(child: Text('Trinity')),
          BootstrapSimulatorListTile(child: Text('Mangos')),
          IconButton(
            onPressed: () => onAdd?.call(true),
            icon: Icon(HugeIcons.strokeRoundedAdd01),
          ),
        ],
      ),
    );
  }
}
