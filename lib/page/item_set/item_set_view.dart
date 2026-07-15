import 'package:flutter/material.dart';
import 'package:foxy/page/item_set/item_set_detail_view_model.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

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
          _buildSetEffects(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return FoxyFormSection(
      title: '基本信息',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '编号',
                child: FoxyNumberInput<int>(
                  placeholder: 'ID',
                  controller: viewModel.idController,
                  readOnly: true,
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '需求技能',
                child: FoxyEntityPicker(
                  delegate: FoxyEntityPickerDelegates.skillLine,
                  placeholder: 'RequiredSkill',
                  controller: viewModel.requiredSkillController,
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '需求技能等级',
                child: FoxyNumberInput<int>(
                  placeholder: 'RequiredSkillRank',
                  controller: viewModel.requiredSkillRankController,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildNameText() {
    return FoxyFormSection(
      title: '名称文本',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '名称',
                child: Watch((_) {
                  final id = viewModel.itemSet.value.id;
                  return FoxyLocalePicker(
                    entry: id == 0 ? null : id,
                    controller: viewModel.nameLangZhCNController,
                    title: '套装名称本地化',
                    placeholder: 'Name_lang_zhCN',
                    delegate: FoxyLocalePickerDelegates.dbcItemSetName,
                    onSaved: viewModel.applyNameLocales,
                  );
                }),
              ),
            ),
            const Expanded(child: SizedBox()),
            const Expanded(child: SizedBox()),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildItemIds() {
    return FoxyFormSection(
      title: '套装物品',
      children: [
        Row(
          spacing: 8,
          children: [
            _itemField('物品0', 'ItemID0', viewModel.itemId0Controller),
            _itemField('物品1', 'ItemID1', viewModel.itemId1Controller),
            _itemField('物品2', 'ItemID2', viewModel.itemId2Controller),
            _itemField('物品3', 'ItemID3', viewModel.itemId3Controller),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            _itemField('物品4', 'ItemID4', viewModel.itemId4Controller),
            _itemField('物品5', 'ItemID5', viewModel.itemId5Controller),
            _itemField('物品6', 'ItemID6', viewModel.itemId6Controller),
            _itemField('物品7', 'ItemID7', viewModel.itemId7Controller),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            _itemField('物品8', 'ItemID8', viewModel.itemId8Controller),
            _itemField('物品9', 'ItemID9', viewModel.itemId9Controller),
            _itemField('物品10', 'ItemID10', viewModel.itemId10Controller),
            _itemField('物品11', 'ItemID11', viewModel.itemId11Controller),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            _itemField('物品12', 'ItemID12', viewModel.itemId12Controller),
            _itemField('物品13', 'ItemID13', viewModel.itemId13Controller),
            _itemField('物品14', 'ItemID14', viewModel.itemId14Controller),
            _itemField('物品15', 'ItemID15', viewModel.itemId15Controller),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            _itemField('物品16', 'ItemID16', viewModel.itemId16Controller),
            const Expanded(child: SizedBox()),
            const Expanded(child: SizedBox()),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildSetEffects() {
    return FoxyFormSection(
      title: '套装效果',
      children: [
        Row(
          spacing: 8,
          children: [
            _spellField('法术0', 'SetSpellID0', viewModel.setSpellId0Controller),
            _thresholdField(
              '触发件数0',
              'SetThreshold0',
              viewModel.setThreshold0Controller,
            ),
            _spellField('法术1', 'SetSpellID1', viewModel.setSpellId1Controller),
            _thresholdField(
              '触发件数1',
              'SetThreshold1',
              viewModel.setThreshold1Controller,
            ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            _spellField('法术2', 'SetSpellID2', viewModel.setSpellId2Controller),
            _thresholdField(
              '触发件数2',
              'SetThreshold2',
              viewModel.setThreshold2Controller,
            ),
            _spellField('法术3', 'SetSpellID3', viewModel.setSpellId3Controller),
            _thresholdField(
              '触发件数3',
              'SetThreshold3',
              viewModel.setThreshold3Controller,
            ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            _spellField('法术4', 'SetSpellID4', viewModel.setSpellId4Controller),
            _thresholdField(
              '触发件数4',
              'SetThreshold4',
              viewModel.setThreshold4Controller,
            ),
            _spellField('法术5', 'SetSpellID5', viewModel.setSpellId5Controller),
            _thresholdField(
              '触发件数5',
              'SetThreshold5',
              viewModel.setThreshold5Controller,
            ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            _spellField('法术6', 'SetSpellID6', viewModel.setSpellId6Controller),
            _thresholdField(
              '触发件数6',
              'SetThreshold6',
              viewModel.setThreshold6Controller,
            ),
            _spellField('法术7', 'SetSpellID7', viewModel.setSpellId7Controller),
            _thresholdField(
              '触发件数7',
              'SetThreshold7',
              viewModel.setThreshold7Controller,
            ),
          ],
        ),
      ],
    );
  }

  Widget _itemField(
    String label,
    String placeholder,
    IntFieldController controller,
  ) {
    return Expanded(
      child: FoxyFormItem(
        label: label,
        child: FoxyEntityPicker(
          delegate: FoxyEntityPickerDelegates.itemTemplate,
          controller: controller,
          placeholder: placeholder,
        ),
      ),
    );
  }

  Widget _spellField(
    String label,
    String placeholder,
    IntFieldController controller,
  ) {
    return Expanded(
      child: FoxyFormItem(
        label: label,
        child: FoxyEntityPicker(
          delegate: FoxyEntityPickerDelegates.spell,
          controller: controller,
          placeholder: placeholder,
        ),
      ),
    );
  }

  Widget _thresholdField(
    String label,
    String placeholder,
    IntFieldController controller,
  ) {
    return Expanded(
      child: FoxyFormItem(
        label: label,
        child: FoxyNumberInput<int>(
          placeholder: placeholder,
          controller: controller,
        ),
      ),
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
