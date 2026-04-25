import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/npc_text_selector.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_detail_view_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Tab 1：gossip_menu 主表（MenuID + TextID）
class GossipMenuView extends StatelessWidget {
  final GossipMenuDetailViewModel viewModel;

  const GossipMenuView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final menuIdLabel = Text('编号 (MenuID)');
    final menuIdInput = ShadInput(
      controller: viewModel.menuIdController,
      placeholder: Text('MenuID'),
    );
    final textIdLabel = Text('文本编号 (TextID)');
    final textIdInput = NpcTextSelector(
      controller: viewModel.textIdController,
      placeholder: 'TextID',
    );

    final form = ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: Column(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [menuIdLabel, menuIdInput],
            ),
          ),
          Expanded(
            child: Column(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [textIdLabel, textIdInput],
            ),
          ),
        ],
      ),
    );

    final saveBtn = Watch((_) {
      return ShadButton(
        enabled: !viewModel.saving.value,
        onPressed: viewModel.onSave,
        child: Text(viewModel.saving.value ? '保存中...' : '保存'),
      );
    });
    final backBtn = ShadButton.outline(
      onPressed: viewModel.pop,
      child: Text('返回'),
    );
    final actions = ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 8, children: [saveBtn, backBtn]),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(spacing: 16, children: [form, actions]),
    );
  }
}
