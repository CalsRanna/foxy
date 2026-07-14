import 'package:flutter/material.dart';
import 'package:foxy/page/emote_text/emote_text_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class EmoteTextView extends StatefulWidget {
  final int? entry;
  const EmoteTextView({super.key, this.entry});

  @override
  State<EmoteTextView> createState() => _EmoteTextViewState();
}

class _EmoteTextViewState extends State<EmoteTextView> {
  final viewModel = GetIt.instance.get<EmoteTextDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(id: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
        readOnly: true,
      ),
    );
    final nameInput = FoxyFormItem(
      label: '名称',
      child: FoxyStringInput(
        controller: viewModel.nameController,
        placeholder: 'Name',
      ),
    );
    final emoteIdInput = FoxyFormItem(
      label: '动作表情',
      child: FoxyEntityPicker(
        placeholder: 'EmoteID',
        controller: viewModel.emoteIdController,
        delegate: FoxyEntityPickerDelegates.dbcEmote,
      ),
    );
    final emoteText0Input = FoxyFormItem(
      label: '表情文本 1',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText0',
        controller: viewModel.emoteText0Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText1Input = FoxyFormItem(
      label: '表情文本 2',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText1',
        controller: viewModel.emoteText1Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText2Input = FoxyFormItem(
      label: '表情文本 3',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText2',
        controller: viewModel.emoteText2Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText3Input = FoxyFormItem(
      label: '表情文本 4',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText3',
        controller: viewModel.emoteText3Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText4Input = FoxyFormItem(
      label: '表情文本 5',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText4',
        controller: viewModel.emoteText4Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText5Input = FoxyFormItem(
      label: '表情文本 6',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText5',
        controller: viewModel.emoteText5Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText6Input = FoxyFormItem(
      label: '表情文本 7',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText6',
        controller: viewModel.emoteText6Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText7Input = FoxyFormItem(
      label: '表情文本 8',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText7',
        controller: viewModel.emoteText7Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText8Input = FoxyFormItem(
      label: '表情文本 9',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText8',
        controller: viewModel.emoteText8Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText9Input = FoxyFormItem(
      label: '表情文本 10',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText9',
        controller: viewModel.emoteText9Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText10Input = FoxyFormItem(
      label: '表情文本 11',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText10',
        controller: viewModel.emoteText10Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText11Input = FoxyFormItem(
      label: '表情文本 12',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText11',
        controller: viewModel.emoteText11Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText12Input = FoxyFormItem(
      label: '表情文本 13',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText12',
        controller: viewModel.emoteText12Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText13Input = FoxyFormItem(
      label: '表情文本 14',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText13',
        controller: viewModel.emoteText13Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText14Input = FoxyFormItem(
      label: '表情文本 15',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText14',
        controller: viewModel.emoteText14Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );
    final emoteText15Input = FoxyFormItem(
      label: '表情文本 16',
      child: FoxyEntityPicker(
        placeholder: 'EmoteText15',
        controller: viewModel.emoteText15Controller,
        delegate: FoxyEntityPickerDelegates.emoteTextData,
      ),
    );

    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: idInput),
          Expanded(child: nameInput),
          Expanded(child: emoteIdInput),
          const Expanded(child: SizedBox()),
        ],
      ),
    ];
    final emoteTextRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: emoteText0Input),
          Expanded(child: emoteText1Input),
          Expanded(child: emoteText2Input),
          Expanded(child: emoteText3Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: emoteText4Input),
          Expanded(child: emoteText5Input),
          Expanded(child: emoteText6Input),
          Expanded(child: emoteText7Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: emoteText8Input),
          Expanded(child: emoteText9Input),
          Expanded(child: emoteText10Input),
          Expanded(child: emoteText11Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: emoteText12Input),
          Expanded(child: emoteText13Input),
          Expanded(child: emoteText14Input),
          Expanded(child: emoteText15Input),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(title: '基本信息', children: basicRows),
          FoxyFormSection(title: '表情文本', children: emoteTextRows),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: const Text('保存'),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(
                onPressed: viewModel.pop,
                child: const Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
