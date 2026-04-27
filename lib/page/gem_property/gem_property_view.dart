import 'package:flutter/material.dart';
import 'package:foxy/page/gem_property/gem_property_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class GemPropertyView extends StatefulWidget {
  final int? entry;
  const GemPropertyView({super.key, this.entry});

  @override
  State<GemPropertyView> createState() => _GemPropertyViewState();
}

class _GemPropertyViewState extends State<GemPropertyView> {
  final viewModel = GetIt.instance.get<GemPropertyDetailViewModel>();

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
    final enchantIdInput = FormItem(
      controller: viewModel.enchantIdController,
      label: '附魔编号',
      placeholder: 'Enchant_ID',
    );
    final maxcountInvInput = FormItem(
      controller: viewModel.maxcountInvController,
      label: '最大库存',
      placeholder: 'Maxcount_inv',
    );
    final maxcountItemInput = FormItem(
      controller: viewModel.maxcountItemController,
      label: '最大物品',
      placeholder: 'Maxcount_item',
    );
    final typeInput = FormItem(
      controller: viewModel.typeController,
      label: '类型',
      placeholder: 'Type',
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
                Row(
                  spacing: 8,
                  children: [
                    Expanded(child: idInput),
                    Expanded(child: enchantIdInput),
                    Expanded(child: maxcountInvInput),
                    Expanded(child: maxcountItemInput),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(child: typeInput),
                    Expanded(child: SizedBox()),
                    Expanded(child: SizedBox()),
                    Expanded(child: SizedBox()),
                  ],
                ),
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
