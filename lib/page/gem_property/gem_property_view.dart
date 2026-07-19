import 'package:flutter/material.dart';
import 'package:foxy/constant/gem_property_constants.dart';
import 'package:foxy/page/gem_property/gem_property_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class GemPropertyView extends StatelessWidget {
  final GemPropertyDetailViewModel viewModel;

  const GemPropertyView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
      ),
    );
    final enchantIdInput = FoxyFormItem(
      label: '法术物品附魔',
      child: FoxyEntityPicker(
        placeholder: 'Enchant_ID',
        controller: viewModel.enchantIdController,
        delegate: FoxyEntityPickerDelegates.spellItemEnchantment,
      ),
    );
    final maxcountInvInput = FoxyFormItem(
      label: '客户端库存计数',
      child: FoxyNumberInput<int>(
        placeholder: 'Maxcount_inv',
        controller: viewModel.maxCountInvController,
      ),
    );
    final maxcountItemInput = FoxyFormItem(
      label: '客户端物品计数',
      child: FoxyNumberInput<int>(
        placeholder: 'Maxcount_item',
        controller: viewModel.maxCountItemController,
      ),
    );
    final typeInput = FoxyFormItem(
      label: '宝石颜色',
      child: FoxyIntShadSelect(
        controller: viewModel.typeController,
        options: kGemPropertyColorOptions,
        placeholder: const Text('Type'),
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
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
                  const Expanded(child: SizedBox()),
                  const Expanded(child: SizedBox()),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: const Text('保存'),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(
                onPressed: viewModel.pop,
                child: const Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
