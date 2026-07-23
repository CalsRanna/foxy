import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/page/page_text/page_text_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class PageTextView extends StatefulWidget {
  final PageTextDetailViewModel viewModel;

  const PageTextView({super.key, required this.viewModel});

  @override
  State<PageTextView> createState() => _PageTextViewState();
}

class _PageTextViewState extends State<PageTextView> {
  PageTextDetailViewModel get viewModel => widget.viewModel;

  @override
  Widget build(BuildContext context) {
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
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
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () => _persist(context),
                  child: Text('保存'),
                ),
              ),
              SizedBox(width: 8),
              ShadButton.ghost(onPressed: _goBack, child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      GetIt.instance.get<RouterFacade>().updateCurrentLabel(
        '页面文本 ${viewModel.persistedKey.value}',
      );
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }
}
