import 'package:flutter/material.dart';
import 'package:foxy/constant/talent_constants.dart';
import 'package:foxy/page/talent/talent_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TalentView extends StatelessWidget {
  final TalentDetailViewModel viewModel;

  const TalentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
      ),
    );
    final tabIdInput = FoxyFormItem(
      label: '天赋页',
      child: FoxyEntityPicker(
        placeholder: 'TabID',
        controller: viewModel.tabIdController,
        delegate: FoxyEntityPickerDelegates.talentTab,
      ),
    );
    final tierIdInput = FoxyFormItem(
      label: '层',
      child: FoxyNumberInput<int>(
        placeholder: 'TierID',
        controller: viewModel.tierIdController,
      ),
    );
    final columnIndexInput = FoxyFormItem(
      label: '列',
      child: FoxyNumberInput<int>(
        placeholder: 'ColumnIndex',
        controller: viewModel.columnIndexController,
      ),
    );
    final flagsInput = FoxyFormItem(
      label: '加入法术书',
      child: FoxyIntShadSelect(
        controller: viewModel.flagsController,
        options: kTalentAddToSpellBookOptions,
        placeholder: const Text('Flags'),
      ),
    );
    final requiredSpellIdInput = FoxyFormItem(
      label: '必需法术',
      child: FoxyEntityPicker(
        placeholder: 'RequiredSpellID',
        controller: viewModel.requiredSpellIdController,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );

    final spellRank0Input = FoxyFormItem(
      label: '第 1 级法术',
      child: FoxyEntityPicker(
        placeholder: 'SpellRank0',
        controller: viewModel.spellRank0Controller,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );
    final spellRank1Input = FoxyFormItem(
      label: '第 2 级法术',
      child: FoxyEntityPicker(
        placeholder: 'SpellRank1',
        controller: viewModel.spellRank1Controller,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );
    final spellRank2Input = FoxyFormItem(
      label: '第 3 级法术',
      child: FoxyEntityPicker(
        placeholder: 'SpellRank2',
        controller: viewModel.spellRank2Controller,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );
    final spellRank3Input = FoxyFormItem(
      label: '第 4 级法术',
      child: FoxyEntityPicker(
        placeholder: 'SpellRank3',
        controller: viewModel.spellRank3Controller,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );
    final spellRank4Input = FoxyFormItem(
      label: '第 5 级法术',
      child: FoxyEntityPicker(
        placeholder: 'SpellRank4',
        controller: viewModel.spellRank4Controller,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );
    final spellRank5Input = FoxyFormItem(
      label: '第 6 级法术',
      child: FoxyEntityPicker(
        placeholder: 'SpellRank5',
        controller: viewModel.spellRank5Controller,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );
    final spellRank6Input = FoxyFormItem(
      label: '第 7 级法术',
      child: FoxyEntityPicker(
        placeholder: 'SpellRank6',
        controller: viewModel.spellRank6Controller,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );
    final spellRank7Input = FoxyFormItem(
      label: '第 8 级法术',
      child: FoxyEntityPicker(
        placeholder: 'SpellRank7',
        controller: viewModel.spellRank7Controller,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );
    final spellRank8Input = FoxyFormItem(
      label: '第 9 级法术',
      child: FoxyEntityPicker(
        placeholder: 'SpellRank8',
        controller: viewModel.spellRank8Controller,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );

    final prereqTalent0Input = FoxyFormItem(
      label: '前置天赋 1',
      child: FoxyEntityPicker(
        placeholder: 'PrereqTalent0',
        controller: viewModel.prereqTalent0Controller,
        delegate: FoxyEntityPickerDelegates.talent,
      ),
    );
    final prereqTalent1Input = FoxyFormItem(
      label: '前置天赋 2',
      child: FoxyEntityPicker(
        placeholder: 'PrereqTalent1',
        controller: viewModel.prereqTalent1Controller,
        delegate: FoxyEntityPickerDelegates.talent,
      ),
    );
    final prereqTalent2Input = FoxyFormItem(
      label: '前置天赋 3',
      child: FoxyEntityPicker(
        placeholder: 'PrereqTalent2',
        controller: viewModel.prereqTalent2Controller,
        delegate: FoxyEntityPickerDelegates.talent,
      ),
    );

    final prereqRank0Input = FoxyFormItem(
      label: '前置等级索引 1',
      child: FoxyNumberInput<int>(
        placeholder: 'PrereqRank0',
        controller: viewModel.prereqRank0Controller,
      ),
    );
    final prereqRank1Input = FoxyFormItem(
      label: '前置等级索引 2',
      child: FoxyNumberInput<int>(
        placeholder: 'PrereqRank1',
        controller: viewModel.prereqRank1Controller,
      ),
    );
    final prereqRank2Input = FoxyFormItem(
      label: '前置等级索引 3',
      child: FoxyNumberInput<int>(
        placeholder: 'PrereqRank2',
        controller: viewModel.prereqRank2Controller,
      ),
    );

    final categoryMask0Input = FoxyFormItem(
      label: '分类掩码低 32 位',
      child: FoxyNumberInput<int>(
        placeholder: 'CategoryMask0',
        controller: viewModel.categoryMask0Controller,
      ),
    );
    final categoryMask1Input = FoxyFormItem(
      label: '分类掩码高 32 位',
      child: FoxyNumberInput<int>(
        placeholder: 'CategoryMask1',
        controller: viewModel.categoryMask1Controller,
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '基础信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: idInput),
                  Expanded(child: tabIdInput),
                  Expanded(child: tierIdInput),
                  Expanded(child: columnIndexInput),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(child: flagsInput),
                  Expanded(child: requiredSpellIdInput),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '法术等级',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: spellRank0Input),
                  Expanded(child: spellRank1Input),
                  Expanded(child: spellRank2Input),
                  Expanded(child: spellRank3Input),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(child: spellRank4Input),
                  Expanded(child: spellRank5Input),
                  Expanded(child: spellRank6Input),
                  Expanded(child: spellRank7Input),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(child: spellRank8Input),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '前置天赋',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: prereqTalent0Input),
                  Expanded(child: prereqTalent1Input),
                  Expanded(child: prereqTalent2Input),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '前置等级',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: prereqRank0Input),
                  Expanded(child: prereqRank1Input),
                  Expanded(child: prereqRank2Input),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '分类掩码',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: categoryMask0Input),
                  Expanded(child: categoryMask1Input),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          // 保存 + 取消按钮
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
