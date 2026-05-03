import 'package:flutter/material.dart';
import 'package:foxy/page/currency_type/currency_type_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
      placeholder: 'ID',
      child: FoxyNumberInput<int>(
        value: viewModel.id.value,
        onChanged: (v) => viewModel.id.value = v,
        readOnly: true,
      ),
    );
    final itemIdInput = FormItem(
      label: '物品编号',
      placeholder: 'ItemID',
      child: FoxyNumberInput<int>(
        value: viewModel.itemId.value,
        onChanged: (v) => viewModel.itemId.value = v,
      ),
    );
    final categoryIdInput = FormItem(
      label: '分类编号',
      placeholder: 'CategoryID',
      child: FoxyNumberInput<int>(
        value: viewModel.categoryId.value,
        onChanged: (v) => viewModel.categoryId.value = v,
      ),
    );
    final bitIndexInput = FormItem(
      label: '位索引',
      placeholder: 'BitIndex',
      child: FoxyNumberInput<int>(
        value: viewModel.bitIndex.value,
        onChanged: (v) => viewModel.bitIndex.value = v,
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
            child: Row(
              spacing: 8,
              children: [
                Expanded(child: idInput),
                Expanded(child: itemIdInput),
                Expanded(child: categoryIdInput),
                Expanded(child: bitIndexInput),
              ],
            ),
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
