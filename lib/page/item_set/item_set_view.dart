import 'package:flutter/material.dart';
import 'package:foxy/page/item_set/item_set_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
                  label: '编号',
                  placeholder: 'ID',
                  child: FoxyNumberInput<int>(
                    value: viewModel.id.value,
                    onChanged: (v) => viewModel.id.value = v,
                    readOnly: true,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '需求技能',
                  placeholder: 'RequiredSkill',
                  child: FoxyNumberInput<int>(
                    value: viewModel.requiredSkill.value,
                    onChanged: (v) => viewModel.requiredSkill.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '需求技能等级',
                  placeholder: 'RequiredSkillRank',
                  child: FoxyNumberInput<int>(
                    value: viewModel.requiredSkillRank.value,
                    onChanged: (v) => viewModel.requiredSkillRank.value = v,
                  ),
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
                  label: '物品0',
                  placeholder: 'ItemID0',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId0.value,
                    onChanged: (v) => viewModel.itemId0.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品1',
                  placeholder: 'ItemID1',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId1.value,
                    onChanged: (v) => viewModel.itemId1.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品2',
                  placeholder: 'ItemID2',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId2.value,
                    onChanged: (v) => viewModel.itemId2.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品3',
                  placeholder: 'ItemID3',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId3.value,
                    onChanged: (v) => viewModel.itemId3.value = v,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  label: '物品4',
                  placeholder: 'ItemID4',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId4.value,
                    onChanged: (v) => viewModel.itemId4.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品5',
                  placeholder: 'ItemID5',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId5.value,
                    onChanged: (v) => viewModel.itemId5.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品6',
                  placeholder: 'ItemID6',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId6.value,
                    onChanged: (v) => viewModel.itemId6.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品7',
                  placeholder: 'ItemID7',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId7.value,
                    onChanged: (v) => viewModel.itemId7.value = v,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  label: '物品8',
                  placeholder: 'ItemID8',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId8.value,
                    onChanged: (v) => viewModel.itemId8.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品9',
                  placeholder: 'ItemID9',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId9.value,
                    onChanged: (v) => viewModel.itemId9.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品10',
                  placeholder: 'ItemID10',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId10.value,
                    onChanged: (v) => viewModel.itemId10.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品11',
                  placeholder: 'ItemID11',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId11.value,
                    onChanged: (v) => viewModel.itemId11.value = v,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  label: '物品12',
                  placeholder: 'ItemID12',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId12.value,
                    onChanged: (v) => viewModel.itemId12.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品13',
                  placeholder: 'ItemID13',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId13.value,
                    onChanged: (v) => viewModel.itemId13.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品14',
                  placeholder: 'ItemID14',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId14.value,
                    onChanged: (v) => viewModel.itemId14.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品15',
                  placeholder: 'ItemID15',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId15.value,
                    onChanged: (v) => viewModel.itemId15.value = v,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  label: '物品16',
                  placeholder: 'ItemID16',
                  child: FoxyNumberInput<int>(
                    value: viewModel.itemId16.value,
                    onChanged: (v) => viewModel.itemId16.value = v,
                  ),
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
                  label: '法术0',
                  placeholder: 'SetSpellID0',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setSpellId0.value,
                    onChanged: (v) => viewModel.setSpellId0.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术1',
                  placeholder: 'SetSpellID1',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setSpellId1.value,
                    onChanged: (v) => viewModel.setSpellId1.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术2',
                  placeholder: 'SetSpellID2',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setSpellId2.value,
                    onChanged: (v) => viewModel.setSpellId2.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术3',
                  placeholder: 'SetSpellID3',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setSpellId3.value,
                    onChanged: (v) => viewModel.setSpellId3.value = v,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  label: '法术4',
                  placeholder: 'SetSpellID4',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setSpellId4.value,
                    onChanged: (v) => viewModel.setSpellId4.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术5',
                  placeholder: 'SetSpellID5',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setSpellId5.value,
                    onChanged: (v) => viewModel.setSpellId5.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术6',
                  placeholder: 'SetSpellID6',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setSpellId6.value,
                    onChanged: (v) => viewModel.setSpellId6.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术7',
                  placeholder: 'SetSpellID7',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setSpellId7.value,
                    onChanged: (v) => viewModel.setSpellId7.value = v,
                  ),
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
                  label: '门槛0',
                  placeholder: 'SetThreshold0',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setThreshold0.value,
                    onChanged: (v) => viewModel.setThreshold0.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛1',
                  placeholder: 'SetThreshold1',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setThreshold1.value,
                    onChanged: (v) => viewModel.setThreshold1.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛2',
                  placeholder: 'SetThreshold2',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setThreshold2.value,
                    onChanged: (v) => viewModel.setThreshold2.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛3',
                  placeholder: 'SetThreshold3',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setThreshold3.value,
                    onChanged: (v) => viewModel.setThreshold3.value = v,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FormItem(
                  label: '门槛4',
                  placeholder: 'SetThreshold4',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setThreshold4.value,
                    onChanged: (v) => viewModel.setThreshold4.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛5',
                  placeholder: 'SetThreshold5',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setThreshold5.value,
                    onChanged: (v) => viewModel.setThreshold5.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛6',
                  placeholder: 'SetThreshold6',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setThreshold6.value,
                    onChanged: (v) => viewModel.setThreshold6.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛7',
                  placeholder: 'SetThreshold7',
                  child: FoxyNumberInput<int>(
                    value: viewModel.setThreshold7.value,
                    onChanged: (v) => viewModel.setThreshold7.value = v,
                  ),
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
