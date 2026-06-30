import 'package:flutter/material.dart';
import 'package:foxy/page/item_set/item_set_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/form_section.dart';
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
    return FormSection(
      title: '基本信息',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FormItem(
                label: '编号',
                child: FoxyNumberInput<int>(
                  placeholder: 'ID',
                  controller: viewModel.idController,
                  readOnly: true,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '需求技能',
                child: FoxyNumberInput<int>(
                  placeholder: 'RequiredSkill',
                  controller: viewModel.requiredSkillController,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '需求技能等级',
                child: FoxyNumberInput<int>(
                  placeholder: 'RequiredSkillRank',
                  controller: viewModel.requiredSkillRankController,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildNameText() {
    return FormSection(
      title: '名称文本',
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
    );
  }

  Widget _buildItemIds() {
    return FormSection(
      title: '套装物品',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FormItem(
                label: '物品0',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID0',
                  controller: viewModel.itemId0Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品1',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID1',
                  controller: viewModel.itemId1Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品2',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID2',
                  controller: viewModel.itemId2Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品3',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID3',
                  controller: viewModel.itemId3Controller,
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
                  controller: viewModel.itemId4Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品5',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID5',
                  controller: viewModel.itemId5Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品6',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID6',
                  controller: viewModel.itemId6Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品7',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID7',
                  controller: viewModel.itemId7Controller,
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
                  controller: viewModel.itemId8Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品9',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID9',
                  controller: viewModel.itemId9Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品10',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID10',
                  controller: viewModel.itemId10Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品11',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID11',
                  controller: viewModel.itemId11Controller,
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
                  controller: viewModel.itemId12Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品13',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID13',
                  controller: viewModel.itemId13Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品14',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID14',
                  controller: viewModel.itemId14Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '物品15',
                child: FoxyNumberInput<int>(
                  placeholder: 'ItemID15',
                  controller: viewModel.itemId15Controller,
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
                  controller: viewModel.itemId16Controller,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Expanded(child: SizedBox()),
            Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildSetSpellIds() {
    return FormSection(
      title: '套装法术',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FormItem(
                label: '法术0',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetSpellID0',
                  controller: viewModel.setSpellId0Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '法术1',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetSpellID1',
                  controller: viewModel.setSpellId1Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '法术2',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetSpellID2',
                  controller: viewModel.setSpellId2Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '法术3',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetSpellID3',
                  controller: viewModel.setSpellId3Controller,
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
                  controller: viewModel.setSpellId4Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '法术5',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetSpellID5',
                  controller: viewModel.setSpellId5Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '法术6',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetSpellID6',
                  controller: viewModel.setSpellId6Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '法术7',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetSpellID7',
                  controller: viewModel.setSpellId7Controller,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSetThresholds() {
    return FormSection(
      title: '触发阈值',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FormItem(
                label: '门槛0',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold0',
                  controller: viewModel.setThreshold0Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '门槛1',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold1',
                  controller: viewModel.setThreshold1Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '门槛2',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold2',
                  controller: viewModel.setThreshold2Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '门槛3',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold3',
                  controller: viewModel.setThreshold3Controller,
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
                  controller: viewModel.setThreshold4Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '门槛5',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold5',
                  controller: viewModel.setThreshold5Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '门槛6',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold6',
                  controller: viewModel.setThreshold6Controller,
                ),
              ),
            ),
            Expanded(
              child: FormItem(
                label: '门槛7',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold7',
                  controller: viewModel.setThreshold7Controller,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        ShadButton(onPressed: () => viewModel.save(context), child: Text('保存')),
        const SizedBox(width: 8),
        ShadButton.ghost(onPressed: () => viewModel.pop(), child: Text('取消')),
      ],
    );
  }
}
