import 'package:flutter/material.dart';
import 'package:foxy/page/page_text/page_text_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PageTextView extends StatefulWidget {
  final int? id;
  final ValueChanged<int>? onSaved;

  const PageTextView({super.key, this.id, this.onSaved});

  @override
  State<PageTextView> createState() => _PageTextViewState();
}

class _PageTextViewState extends State<PageTextView> {
  final viewModel = GetIt.instance.get<PageTextDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(id: widget.id);
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
    final textInput = FoxyFormItem(
      label: '文本',
      child: FoxyStringInput(
        controller: viewModel.textController,
        placeholder: 'Text',
      ),
    );
    final nextPageIdInput = FoxyFormItem(
      label: '下一页页面文本',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.pageText,
        placeholder: 'NextPageID',
        controller: viewModel.nextPageIdController,
      ),
    );
    final verifiedBuildInput = FoxyFormItem(
      label: 'VerifiedBuild',
      child: FoxyNumberInput<int>(
        placeholder: 'VerifiedBuild',
        controller: viewModel.verifiedBuildController,
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '基本信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: idInput),
                  Expanded(child: textInput),
                  Expanded(child: nextPageIdInput),
                  Expanded(child: verifiedBuildInput),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ShadButton(
                onPressed: () async {
                  final id = await viewModel.save(context);
                  if (id != null && mounted) widget.onSaved?.call(id);
                },
                child: Text('保存'),
              ),
              SizedBox(width: 8),
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
