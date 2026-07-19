import 'package:flutter/material.dart';
import 'package:foxy/page/currency_type/currency_type_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CurrencyTypeView extends StatelessWidget {
  final CurrencyTypeDetailViewModel viewModel;

  const CurrencyTypeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
      ),
    );
    final itemIdInput = FoxyFormItem(
      label: '货币物品',
      child: FoxyEntityPicker(
        placeholder: 'ItemID',
        controller: viewModel.itemIdController,
        delegate: FoxyEntityPickerDelegates.itemTemplate,
      ),
    );
    final categoryIdInput = FoxyFormItem(
      label: '货币分类',
      child: FoxyEntityPicker(
        placeholder: 'CategoryID',
        controller: viewModel.categoryIdController,
        delegate: FoxyEntityPickerDelegates.currencyCategory,
      ),
    );
    final bitIndexInput = FoxyFormItem(
      label: '位索引',
      child: FoxyNumberInput<int>(
        placeholder: 'BitIndex',
        controller: viewModel.bitIndexController,
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
                  Expanded(child: itemIdInput),
                  Expanded(child: categoryIdInput),
                  Expanded(child: bitIndexInput),
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
