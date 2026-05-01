import 'package:flutter/material.dart';
import 'package:foxy/page/currency_type/currency_type_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
      controller: viewModel.idController,
      label: '编号',
      placeholder: 'ID',
      readOnly: true,
    );
    final itemIdInput = FormItem(
      controller: viewModel.itemIdController,
      label: '物品编号',
      placeholder: 'ItemID',
    );
    final categoryIdInput = FormItem(
      controller: viewModel.categoryIdController,
      label: '分类编号',
      placeholder: 'CategoryID',
    );
    final bitIndexInput = FormItem(
      controller: viewModel.bitIndexController,
      label: '位索引',
      placeholder: 'BitIndex',
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
