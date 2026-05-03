import 'package:flutter/material.dart';
import 'package:foxy/page/item_extended_cost/item_extended_cost_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
    final idInput = FormItem(
      label: '编号',
      placeholder: 'ID',
      child: FoxyNumberInput<int>(
        value: viewModel.id.value,
        onChanged: (v) => viewModel.id.value = v,
        readOnly: true,
      ),
    );
    final honorPointsInput = FormItem(
      label: '荣誉点数',
      placeholder: 'HonorPoints',
      child: FoxyNumberInput<int>(
        value: viewModel.honorPoints.value,
        onChanged: (v) => viewModel.honorPoints.value = v,
      ),
    );
    final arenaPointsInput = FormItem(
      label: '竞技场点数',
      placeholder: 'ArenaPoints',
      child: FoxyNumberInput<int>(
        value: viewModel.arenaPoints.value,
        onChanged: (v) => viewModel.arenaPoints.value = v,
      ),
    );
    final arenaBracketInput = FormItem(
      label: '竞技场等级',
      placeholder: 'ArenaBracket',
      child: FoxyNumberInput<int>(
        value: viewModel.arenaBracket.value,
        onChanged: (v) => viewModel.arenaBracket.value = v,
      ),
    );

    /// Other
    final requiredArenaRatingInput = FormItem(
      label: '所需评级',
      placeholder: 'RequiredArenaRating',
      child: FoxyNumberInput<int>(
        value: viewModel.requiredArenaRating.value,
        onChanged: (v) => viewModel.requiredArenaRating.value = v,
      ),
    );
    final itemPurchaseGroupInput = FormItem(
      label: '购买组',
      placeholder: 'ItemPurchaseGroup',
      child: FoxyNumberInput<int>(
        value: viewModel.itemPurchaseGroup.value,
        onChanged: (v) => viewModel.itemPurchaseGroup.value = v,
      ),
    );

    /// ItemID + ItemCount
    final itemID0Input = FormItem(
      label: '物品 ID 0',
      placeholder: 'ItemID0',
      child: FoxyNumberInput<int>(
        value: viewModel.itemID0.value,
        onChanged: (v) => viewModel.itemID0.value = v,
      ),
    );
    final itemCount0Input = FormItem(
      label: '物品计数 0',
      placeholder: 'ItemCount0',
      child: FoxyNumberInput<int>(
        value: viewModel.itemCount0.value,
        onChanged: (v) => viewModel.itemCount0.value = v,
      ),
    );
    final itemID1Input = FormItem(
      label: '物品 ID 1',
      placeholder: 'ItemID1',
      child: FoxyNumberInput<int>(
        value: viewModel.itemID1.value,
        onChanged: (v) => viewModel.itemID1.value = v,
      ),
    );
    final itemCount1Input = FormItem(
      label: '物品计数 1',
      placeholder: 'ItemCount1',
      child: FoxyNumberInput<int>(
        value: viewModel.itemCount1.value,
        onChanged: (v) => viewModel.itemCount1.value = v,
      ),
    );
    final itemID2Input = FormItem(
      label: '物品 ID 2',
      placeholder: 'ItemID2',
      child: FoxyNumberInput<int>(
        value: viewModel.itemID2.value,
        onChanged: (v) => viewModel.itemID2.value = v,
      ),
    );
    final itemCount2Input = FormItem(
      label: '物品计数 2',
      placeholder: 'ItemCount2',
      child: FoxyNumberInput<int>(
        value: viewModel.itemCount2.value,
        onChanged: (v) => viewModel.itemCount2.value = v,
      ),
    );
    final itemID3Input = FormItem(
      label: '物品 ID 3',
      placeholder: 'ItemID3',
      child: FoxyNumberInput<int>(
        value: viewModel.itemID3.value,
        onChanged: (v) => viewModel.itemID3.value = v,
      ),
    );
    final itemCount3Input = FormItem(
      label: '物品计数 3',
      placeholder: 'ItemCount3',
      child: FoxyNumberInput<int>(
        value: viewModel.itemCount3.value,
        onChanged: (v) => viewModel.itemCount3.value = v,
      ),
    );
    final itemID4Input = FormItem(
      label: '物品 ID 4',
      placeholder: 'ItemID4',
      child: FoxyNumberInput<int>(
        value: viewModel.itemID4.value,
        onChanged: (v) => viewModel.itemID4.value = v,
      ),
    );
    final itemCount4Input = FormItem(
      label: '物品计数 4',
      placeholder: 'ItemCount4',
      child: FoxyNumberInput<int>(
        value: viewModel.itemCount4.value,
        onChanged: (v) => viewModel.itemCount4.value = v,
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
          // 基本信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('基本信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: basicRows),
          ),
          // 物品与计数
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('物品与计数'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: itemRows),
          ),
          // 其他
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('其他'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: otherRows),
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
