import 'package:flutter/material.dart';
import 'package:foxy/page/page_text/page_text_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PageTextView extends StatefulWidget {
  final int? id;
  const PageTextView({super.key, this.id});

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
    final idInput = FormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
        readOnly: widget.id != null,
      ),
    );
    final textInput = FormItem(
      controller: viewModel.textController,
      label: '文本',
      placeholder: 'Text',
    );
    final nextPageIdInput = FormItem(
      label: '下一页编号',
      child: FoxyNumberInput<int>(
        placeholder: 'NextPageID',
        controller: viewModel.nextPageIdController,
      ),
    );
    final verifiedBuildInput = FormItem(
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
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              children: [
                Row(spacing: 8, children: [
                  Expanded(child: idInput),
                  Expanded(child: nextPageIdInput),
                  Expanded(child: verifiedBuildInput),
                  Expanded(child: SizedBox()),
                ]),
                Row(spacing: 8, children: [
                  Expanded(flex: 4, child: textInput),
                ]),
              ],
            ),
          ),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              SizedBox(width: 8),
              ShadButton.ghost(onPressed: () => viewModel.pop(), child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }
}
