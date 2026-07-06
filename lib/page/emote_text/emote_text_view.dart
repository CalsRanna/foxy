import 'package:flutter/material.dart';
import 'package:foxy/page/emote_text/emote_text_detail_view_model.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/form_section.dart';
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
    /// Basic
    final idInput = FormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
        readOnly: true,
      ),
    );
    final nameInput = FormItem(
      controller: viewModel.nameController,
      label: '名称',
      placeholder: 'Name',
    );
    final emoteIdInput = FormItem(
      label: '表情编号',
      child: FoxyNumberInput<int>(
        placeholder: 'EmoteID',
        controller: viewModel.emoteIdController,
      ),
    );

    /// EmoteText
    final emoteTextInputs = List.generate(16, (i) {
      return FormItem(
        label: '表情文本$i',
        placeholder: 'EmoteText$i',
        child: FoxyNumberInput<int>(
          controller: viewModel.emoteTextControllers[i],
        ),
      );
    });

    /// 基本信息
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: idInput),
          Expanded(child: nameInput),
          Expanded(child: emoteIdInput),
        ],
      ),
    ];

    /// EmoteText 字段：4 行，每行 4 个
    final emoteTextRows = <Row>[];
    for (var row = 0; row < 4; row++) {
      final start = row * 4;
      emoteTextRows.add(
        Row(
          spacing: 8,
          children: List.generate(
            4,
            (col) => Expanded(child: emoteTextInputs[start + col]),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FormSection(title: '基本信息', children: basicRows),
          FormSection(title: 'EmoteText 字段', children: emoteTextRows),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(
                onPressed: () => viewModel.pop(),
                child: Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
