import 'package:flutter/material.dart';
import 'package:foxy/page/emote_text/emote_text_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
      controller: viewModel.idController,
      label: '编号',
      placeholder: 'ID',
      readOnly: true,
    );
    final nameInput = FormItem(
      controller: viewModel.nameController,
      label: '名称',
      placeholder: 'Name',
    );
    final emoteIdInput = FormItem(
      controller: viewModel.emoteIdController,
      label: '表情编号',
      placeholder: 'EmoteID',
    );

    /// EmoteText
    final emoteTextInputs = List.generate(16, (i) {
      return FormItem(
        controller: _getEmoteTextController(i),
        label: '表情文本$i',
        placeholder: 'EmoteText$i',
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
          // 基本信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('基本信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: basicRows),
          ),
          // 表情文本
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('EmoteText 字段'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: emoteTextRows),
          ),
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

  TextEditingController _getEmoteTextController(int index) {
    return switch (index) {
      0 => viewModel.emoteText0Controller,
      1 => viewModel.emoteText1Controller,
      2 => viewModel.emoteText2Controller,
      3 => viewModel.emoteText3Controller,
      4 => viewModel.emoteText4Controller,
      5 => viewModel.emoteText5Controller,
      6 => viewModel.emoteText6Controller,
      7 => viewModel.emoteText7Controller,
      8 => viewModel.emoteText8Controller,
      9 => viewModel.emoteText9Controller,
      10 => viewModel.emoteText10Controller,
      11 => viewModel.emoteText11Controller,
      12 => viewModel.emoteText12Controller,
      13 => viewModel.emoteText13Controller,
      14 => viewModel.emoteText14Controller,
      15 => viewModel.emoteText15Controller,
      _ => throw ArgumentError('Invalid emoteText index: $index'),
    };
  }
}
