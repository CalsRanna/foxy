import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/page_text_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
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
      child: Watch(
        (_) => FoxyLocalePicker(
          entry: viewModel.persistedKey.value,
          controller: viewModel.textController,
          delegate: FoxyLocalePickerDelegates.pageTextText,
          placeholder: 'Text',
          title: '文本',
        ),
      ),
    );
    final nextPageIdInput = FoxyFormItem(
      label: '下一页文本',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.pageText,
        placeholder: 'NextPageID',
        controller: viewModel.nextPageIdController,
      ),
    );
    final verifiedBuildInput = FoxyFormItem(
      label: '验证版本',
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

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('页面文本数据已保存')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(FoxyExceptions.message(error))));
    }
  }
}
