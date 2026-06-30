import 'package:flutter/material.dart';
import 'package:foxy/widget/entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/form_section.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class GossipMenuView extends StatefulWidget {
  const GossipMenuView({super.key});

  @override
  State<GossipMenuView> createState() => _GossipMenuViewState();
}

class _GossipMenuViewState extends State<GossipMenuView> {
  final viewModel = GetIt.instance.get<GossipMenuDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    final menuIdInput = FormItem(
      label: '编号',
      child: ShadInput(
        controller: viewModel.menuIdController,
        placeholder: const Text('MenuID'),
      ),
    );
    final textIdInput = FormItem(
      label: '文本编号',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.npcText,
        controller: viewModel.textIdController,
        placeholder: 'TextID',
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FormSection(
            title: '基本信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: menuIdInput),
                  Expanded(child: textIdInput),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(onPressed: viewModel.pop, child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }
}
