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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 0,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('基本信息'),
        ),
        ShadCard(
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
                      child: FoxyNumberInput<int>(
                        placeholder: 'ID',
                        value: viewModel.id.value,
                        onChanged: (v) => viewModel.id.value = v,
                        readOnly: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FormItem(
                      label: '需求技能',
                      child: FoxyNumberInput<int>(
                        placeholder: 'RequiredSkill',
                        value: viewModel.requiredSkill.value,
                        onChanged: (v) => viewModel.requiredSkill.value = v,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FormItem(
                      label: '需求技能等级',
                      child: FoxyNumberInput<int>(
                        placeholder: 'RequiredSkillRank',
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
        ),
      ],
    );
  }

  Widget _buildNameText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 0,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('名称文本'),
        ),
        ShadCard(
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
        ),
      ],
    );
  }

  Widget _buildItemIds() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 0,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('套装物品'),
        ),
        ShadCard(
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
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID0',
                    value: viewModel.itemId0.value,
                    onChanged: (v) => viewModel.itemId0.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品1',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID1',
                    value: viewModel.itemId1.value,
                    onChanged: (v) => viewModel.itemId1.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品2',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID2',
                    value: viewModel.itemId2.value,
                    onChanged: (v) => viewModel.itemId2.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品3',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID3',
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
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID4',
                    value: viewModel.itemId4.value,
                    onChanged: (v) => viewModel.itemId4.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品5',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID5',
                    value: viewModel.itemId5.value,
                    onChanged: (v) => viewModel.itemId5.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品6',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID6',
                    value: viewModel.itemId6.value,
                    onChanged: (v) => viewModel.itemId6.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品7',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID7',
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
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID8',
                    value: viewModel.itemId8.value,
                    onChanged: (v) => viewModel.itemId8.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品9',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID9',
                    value: viewModel.itemId9.value,
                    onChanged: (v) => viewModel.itemId9.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品10',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID10',
                    value: viewModel.itemId10.value,
                    onChanged: (v) => viewModel.itemId10.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品11',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID11',
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
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID12',
                    value: viewModel.itemId12.value,
                    onChanged: (v) => viewModel.itemId12.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品13',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID13',
                    value: viewModel.itemId13.value,
                    onChanged: (v) => viewModel.itemId13.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品14',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID14',
                    value: viewModel.itemId14.value,
                    onChanged: (v) => viewModel.itemId14.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '物品15',
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID15',
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
                  child: FoxyNumberInput<int>(
                    placeholder: 'ItemID16',
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
    ),
  ],
);
  }

  Widget _buildSetSpellIds() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 0,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('套装法术'),
        ),
        ShadCard(
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
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetSpellID0',
                    value: viewModel.setSpellId0.value,
                    onChanged: (v) => viewModel.setSpellId0.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术1',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetSpellID1',
                    value: viewModel.setSpellId1.value,
                    onChanged: (v) => viewModel.setSpellId1.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术2',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetSpellID2',
                    value: viewModel.setSpellId2.value,
                    onChanged: (v) => viewModel.setSpellId2.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术3',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetSpellID3',
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
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetSpellID4',
                    value: viewModel.setSpellId4.value,
                    onChanged: (v) => viewModel.setSpellId4.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术5',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetSpellID5',
                    value: viewModel.setSpellId5.value,
                    onChanged: (v) => viewModel.setSpellId5.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术6',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetSpellID6',
                    value: viewModel.setSpellId6.value,
                    onChanged: (v) => viewModel.setSpellId6.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '法术7',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetSpellID7',
                    value: viewModel.setSpellId7.value,
                    onChanged: (v) => viewModel.setSpellId7.value = v,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);
  }

  Widget _buildSetThresholds() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 0,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('触发阈值'),
        ),
        ShadCard(
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
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetThreshold0',
                    value: viewModel.setThreshold0.value,
                    onChanged: (v) => viewModel.setThreshold0.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛1',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetThreshold1',
                    value: viewModel.setThreshold1.value,
                    onChanged: (v) => viewModel.setThreshold1.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛2',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetThreshold2',
                    value: viewModel.setThreshold2.value,
                    onChanged: (v) => viewModel.setThreshold2.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛3',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetThreshold3',
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
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetThreshold4',
                    value: viewModel.setThreshold4.value,
                    onChanged: (v) => viewModel.setThreshold4.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛5',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetThreshold5',
                    value: viewModel.setThreshold5.value,
                    onChanged: (v) => viewModel.setThreshold5.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛6',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetThreshold6',
                    value: viewModel.setThreshold6.value,
                    onChanged: (v) => viewModel.setThreshold6.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '门槛7',
                  child: FoxyNumberInput<int>(
                    placeholder: 'SetThreshold7',
                    value: viewModel.setThreshold7.value,
                    onChanged: (v) => viewModel.setThreshold7.value = v,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ],
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
