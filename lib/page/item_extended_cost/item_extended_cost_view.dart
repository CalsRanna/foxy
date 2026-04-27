import 'package:flutter/material.dart';
import 'package:foxy/page/item_extended_cost/item_extended_cost_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
      controller: viewModel.idController,
      label: '编号',
      placeholder: 'ID',
      readOnly: true,
    );
    final honorPointsInput = FormItem(
      controller: viewModel.honorPointsController,
      label: '荣誉点数',
      placeholder: 'HonorPoints',
    );
    final arenaPointsInput = FormItem(
      controller: viewModel.arenaPointsController,
      label: '竞技场点数',
      placeholder: 'ArenaPoints',
    );
    final arenaBracketInput = FormItem(
      controller: viewModel.arenaBracketController,
      label: '竞技场等级',
      placeholder: 'ArenaBracket',
    );

    /// Other
    final requiredArenaRatingInput = FormItem(
      controller: viewModel.requiredArenaRatingController,
      label: '所需评级',
      placeholder: 'RequiredArenaRating',
    );
    final itemPurchaseGroupInput = FormItem(
      controller: viewModel.itemPurchaseGroupController,
      label: '购买组',
      placeholder: 'ItemPurchaseGroup',
    );

    /// ItemID + ItemCount
    final itemID0Input = FormItem(
      controller: viewModel.itemID0Controller,
      label: '物品 ID 0',
      placeholder: 'ItemID0',
    );
    final itemCount0Input = FormItem(
      controller: viewModel.itemCount0Controller,
      label: '物品计数 0',
      placeholder: 'ItemCount0',
    );
    final itemID1Input = FormItem(
      controller: viewModel.itemID1Controller,
      label: '物品 ID 1',
      placeholder: 'ItemID1',
    );
    final itemCount1Input = FormItem(
      controller: viewModel.itemCount1Controller,
      label: '物品计数 1',
      placeholder: 'ItemCount1',
    );
    final itemID2Input = FormItem(
      controller: viewModel.itemID2Controller,
      label: '物品 ID 2',
      placeholder: 'ItemID2',
    );
    final itemCount2Input = FormItem(
      controller: viewModel.itemCount2Controller,
      label: '物品计数 2',
      placeholder: 'ItemCount2',
    );
    final itemID3Input = FormItem(
      controller: viewModel.itemID3Controller,
      label: '物品 ID 3',
      placeholder: 'ItemID3',
    );
    final itemCount3Input = FormItem(
      controller: viewModel.itemCount3Controller,
      label: '物品计数 3',
      placeholder: 'ItemCount3',
    );
    final itemID4Input = FormItem(
      controller: viewModel.itemID4Controller,
      label: '物品 ID 4',
      placeholder: 'ItemID4',
    );
    final itemCount4Input = FormItem(
      controller: viewModel.itemCount4Controller,
      label: '物品计数 4',
      placeholder: 'ItemCount4',
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
