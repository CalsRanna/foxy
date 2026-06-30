import 'package:flutter/material.dart';
import 'package:foxy/page/currency_type/currency_type_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CurrencyTypeView extends StatefulWidget {
  final int? entry;
  const CurrencyTypeView({super.key, this.entry});

  @override
  State<CurrencyTypeView> createState() => _CurrencyTypeViewState();
}

class _CurrencyTypeViewState extends State<CurrencyTypeView> {
  final viewModel = GetIt.instance.get<CurrencyTypeDetailViewModel>();

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
    final idInput = FormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
        readOnly: true,
      ),
    );
    final itemIdInput = FormItem(
      label: '物品编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemID',
        controller: viewModel.itemIdController,
      ),
    );
    final categoryIdInput = FormItem(
      label: '分类编号',
      child: FoxyNumberInput<int>(
        placeholder: 'CategoryID',
        controller: viewModel.categoryIdController,
      ),
    );
    final bitIndexInput = FormItem(
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
          FormSection(
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
