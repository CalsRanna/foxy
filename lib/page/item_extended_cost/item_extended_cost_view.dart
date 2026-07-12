import 'package:flutter/material.dart';
import 'package:foxy/page/item_extended_cost/item_extended_cost_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ItemExtendedCostView extends StatefulWidget {
  final int? entry;
  const ItemExtendedCostView({super.key, this.entry});

  @override
  State<ItemExtendedCostView> createState() => _ItemExtendedCostViewState();
}

class _ItemExtendedCostViewState extends State<ItemExtendedCostView> {
  final viewModel = GetIt.instance.get<ItemExtendedCostDetailViewModel>();

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
    /// Basic
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        fieldController: viewModel.idController,
        readOnly: true,
      ),
    );
    final honorPointsInput = FoxyFormItem(
      label: '荣誉点数',
      child: FoxyNumberInput<int>(
        placeholder: 'HonorPoints',
        fieldController: viewModel.honorPointsController,
      ),
    );
    final arenaPointsInput = FoxyFormItem(
      label: '竞技场点数',
      child: FoxyNumberInput<int>(
        placeholder: 'ArenaPoints',
        fieldController: viewModel.arenaPointsController,
      ),
    );
    final arenaBracketInput = FoxyFormItem(
      label: '竞技场等级',
      child: FoxyNumberInput<int>(
        placeholder: 'ArenaBracket',
        fieldController: viewModel.arenaBracketController,
      ),
    );

    /// Other
    final requiredArenaRatingInput = FoxyFormItem(
      label: '所需评级',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredArenaRating',
        fieldController: viewModel.requiredArenaRatingController,
      ),
    );
    final itemPurchaseGroupInput = FoxyFormItem(
      label: '购买组',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemPurchaseGroup',
        fieldController: viewModel.itemPurchaseGroupController,
      ),
    );

    /// ItemID + ItemCount
    final itemID0Input = FoxyFormItem(
      label: '物品 ID 0',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemID0',
        fieldController: viewModel.itemID0Controller,
      ),
    );
    final itemCount0Input = FoxyFormItem(
      label: '物品计数 0',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemCount0',
        fieldController: viewModel.itemCount0Controller,
      ),
    );
    final itemID1Input = FoxyFormItem(
      label: '物品 ID 1',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemID1',
        fieldController: viewModel.itemID1Controller,
      ),
    );
    final itemCount1Input = FoxyFormItem(
      label: '物品计数 1',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemCount1',
        fieldController: viewModel.itemCount1Controller,
      ),
    );
    final itemID2Input = FoxyFormItem(
      label: '物品 ID 2',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemID2',
        fieldController: viewModel.itemID2Controller,
      ),
    );
    final itemCount2Input = FoxyFormItem(
      label: '物品计数 2',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemCount2',
        fieldController: viewModel.itemCount2Controller,
      ),
    );
    final itemID3Input = FoxyFormItem(
      label: '物品 ID 3',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemID3',
        fieldController: viewModel.itemID3Controller,
      ),
    );
    final itemCount3Input = FoxyFormItem(
      label: '物品计数 3',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemCount3',
        fieldController: viewModel.itemCount3Controller,
      ),
    );
    final itemID4Input = FoxyFormItem(
      label: '物品 ID 4',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemID4',
        fieldController: viewModel.itemID4Controller,
      ),
    );
    final itemCount4Input = FoxyFormItem(
      label: '物品计数 4',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemCount4',
        fieldController: viewModel.itemCount4Controller,
      ),
    );

    /// 1. 基本信息
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: idInput),
          Expanded(child: honorPointsInput),
          Expanded(child: arenaPointsInput),
          Expanded(child: arenaBracketInput),
        ],
      ),
    ];

    /// 2. 物品与计数
    final itemRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: itemID0Input),
          Expanded(child: itemCount0Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: itemID1Input),
          Expanded(child: itemCount1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: itemID2Input),
          Expanded(child: itemCount2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: itemID3Input),
          Expanded(child: itemCount3Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: itemID4Input),
          Expanded(child: itemCount4Input),
        ],
      ),
    ];

    /// 3. 其他
    final otherRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: requiredArenaRatingInput),
          Expanded(child: itemPurchaseGroupInput),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(title: '基本信息', children: basicRows),
          FoxyFormSection(title: '物品与计数', children: itemRows),
          FoxyFormSection(title: '其他', children: otherRows),
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
