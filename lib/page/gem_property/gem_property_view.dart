import 'package:flutter/material.dart';
import 'package:foxy/page/gem_property/gem_property_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
        readOnly: true,
      ),
    );
    final enchantIdInput = FoxyFormItem(
      label: '附魔编号',
      child: FoxyNumberInput<int>(
        placeholder: 'Enchant_ID',
        controller: viewModel.enchantIdController,
      ),
    );
    final maxcountInvInput = FoxyFormItem(
      label: '最大库存',
      child: FoxyNumberInput<int>(
        placeholder: 'Maxcount_inv',
        controller: viewModel.maxCountInvController,
      ),
    );
    final maxcountItemInput = FoxyFormItem(
      label: '最大物品',
      child: FoxyNumberInput<int>(
        placeholder: 'Maxcount_item',
        controller: viewModel.maxCountItemController,
      ),
    );
    final typeInput = FoxyFormItem(
      label: '类型',
      child: FoxyNumberInput<int>(
        placeholder: 'Type',
        controller: viewModel.typeController,
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
