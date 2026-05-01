import 'package:flutter/material.dart';
import 'package:foxy/page/item_set/item_set_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ItemSetView extends StatefulWidget {
  final int? entry;
  const ItemSetView({super.key, this.entry});

  @override
  State<ItemSetView> createState() => _ItemSetViewState();
}

class _ItemSetViewState extends State<ItemSetView> {
  final viewModel = GetIt.instance.get<ItemSetDetailViewModel>();

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
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          _buildBasicInfo(),
          _buildNameText(),
          _buildItemIds(),
          _buildSetSpellIds(),
          _buildSetThresholds(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return ShadCard(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.idController,
                  label: '编号',
                  placeholder: 'ID',
                  readOnly: true,
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.requiredSkillController,
                  label: '需求技能',
                  placeholder: 'RequiredSkill',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.requiredSkillRankController,
                  label: '需求技能等级',
                  placeholder: 'RequiredSkillRank',
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNameText() {
    return ShadCard(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.nameLangEnUSController,
                  label: '英文名称',
                  placeholder: 'enUS',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.nameLangZhCNController,
                  label: '简体中文名称',
                  placeholder: 'zhCN',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.nameLangZhTWController,
                  label: '繁体中文名称',
                  placeholder: 'zhTW',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.nameLangKoKRController,
                  label: '韩文名称',
                  placeholder: 'koKR',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemIds() {
    return ShadCard(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId0Controller,
                  label: '物品0',
                  placeholder: 'ItemID0',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId1Controller,
                  label: '物品1',
                  placeholder: 'ItemID1',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId2Controller,
                  label: '物品2',
                  placeholder: 'ItemID2',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId3Controller,
                  label: '物品3',
                  placeholder: 'ItemID3',
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId4Controller,
                  label: '物品4',
                  placeholder: 'ItemID4',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId5Controller,
                  label: '物品5',
                  placeholder: 'ItemID5',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId6Controller,
                  label: '物品6',
                  placeholder: 'ItemID6',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId7Controller,
                  label: '物品7',
                  placeholder: 'ItemID7',
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId8Controller,
                  label: '物品8',
                  placeholder: 'ItemID8',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId9Controller,
                  label: '物品9',
                  placeholder: 'ItemID9',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId10Controller,
                  label: '物品10',
                  placeholder: 'ItemID10',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId11Controller,
                  label: '物品11',
                  placeholder: 'ItemID11',
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId12Controller,
                  label: '物品12',
                  placeholder: 'ItemID12',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId13Controller,
                  label: '物品13',
                  placeholder: 'ItemID13',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId14Controller,
                  label: '物品14',
                  placeholder: 'ItemID14',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId15Controller,
                  label: '物品15',
                  placeholder: 'ItemID15',
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.itemId16Controller,
                  label: '物品16',
                  placeholder: 'ItemID16',
                ),
              ),
              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSetSpellIds() {
    return ShadCard(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.setSpellId0Controller,
                  label: '法术0',
                  placeholder: 'SetSpellID0',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setSpellId1Controller,
                  label: '法术1',
                  placeholder: 'SetSpellID1',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setSpellId2Controller,
                  label: '法术2',
                  placeholder: 'SetSpellID2',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setSpellId3Controller,
                  label: '法术3',
                  placeholder: 'SetSpellID3',
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.setSpellId4Controller,
                  label: '法术4',
                  placeholder: 'SetSpellID4',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setSpellId5Controller,
                  label: '法术5',
                  placeholder: 'SetSpellID5',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setSpellId6Controller,
                  label: '法术6',
                  placeholder: 'SetSpellID6',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setSpellId7Controller,
                  label: '法术7',
                  placeholder: 'SetSpellID7',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSetThresholds() {
    return ShadCard(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.setThreshold0Controller,
                  label: '门槛0',
                  placeholder: 'SetThreshold0',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setThreshold1Controller,
                  label: '门槛1',
                  placeholder: 'SetThreshold1',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setThreshold2Controller,
                  label: '门槛2',
                  placeholder: 'SetThreshold2',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setThreshold3Controller,
                  label: '门槛3',
                  placeholder: 'SetThreshold3',
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.setThreshold4Controller,
                  label: '门槛4',
                  placeholder: 'SetThreshold4',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setThreshold5Controller,
                  label: '门槛5',
                  placeholder: 'SetThreshold5',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setThreshold6Controller,
                  label: '门槛6',
                  placeholder: 'SetThreshold6',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.setThreshold7Controller,
                  label: '门槛7',
                  placeholder: 'SetThreshold7',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
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
    );
  }
}
