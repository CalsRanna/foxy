import 'package:flutter/material.dart';
import 'package:foxy/page/talent/talent_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TalentView extends StatefulWidget {
  final int? entry;
  const TalentView({super.key, this.entry});

  @override
  State<TalentView> createState() => _TalentViewState();
}

class _TalentViewState extends State<TalentView> {
  final viewModel = GetIt.instance.get<TalentDetailViewModel>();

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
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
        readOnly: true,
      ),
    );
    final tabIdInput = FoxyFormItem(
      label: '标签页',
      child: FoxyNumberInput<int>(
        placeholder: 'TabID',
        controller: viewModel.tabIdController,
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
      label: '标志',
      child: FoxyNumberInput<int>(
        placeholder: 'Flags',
        controller: viewModel.flagsController,
      ),
    );
    final requiredSpellIdInput = FoxyFormItem(
      label: '必需法术',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredSpellID',
        controller: viewModel.requiredSpellIdController,
      ),
    );

    final spellRank0Input = FoxyFormItem(
      label: '法术等级0',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellRank0',
        controller: viewModel.spellRank0Controller,
      ),
    );
    final spellRank1Input = FoxyFormItem(
      label: '法术等级1',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellRank1',
        controller: viewModel.spellRank1Controller,
      ),
    );
    final spellRank2Input = FoxyFormItem(
      label: '法术等级2',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellRank2',
        controller: viewModel.spellRank2Controller,
      ),
    );
    final spellRank3Input = FoxyFormItem(
      label: '法术等级3',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellRank3',
        controller: viewModel.spellRank3Controller,
      ),
    );
    final spellRank4Input = FoxyFormItem(
      label: '法术等级4',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellRank4',
        controller: viewModel.spellRank4Controller,
      ),
    );
    final spellRank5Input = FoxyFormItem(
      label: '法术等级5',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellRank5',
        controller: viewModel.spellRank5Controller,
      ),
    );
    final spellRank6Input = FoxyFormItem(
      label: '法术等级6',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellRank6',
        controller: viewModel.spellRank6Controller,
      ),
    );
    final spellRank7Input = FoxyFormItem(
      label: '法术等级7',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellRank7',
        controller: viewModel.spellRank7Controller,
      ),
    );
    final spellRank8Input = FoxyFormItem(
      label: '法术等级8',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellRank8',
        controller: viewModel.spellRank8Controller,
      ),
    );

    final prereqTalent0Input = FoxyFormItem(
      label: '前置天赋0',
      child: FoxyNumberInput<int>(
        placeholder: 'PrereqTalent0',
        controller: viewModel.prereqTalent0Controller,
      ),
    );
    final prereqTalent1Input = FoxyFormItem(
      label: '前置天赋1',
      child: FoxyNumberInput<int>(
        placeholder: 'PrereqTalent1',
        controller: viewModel.prereqTalent1Controller,
      ),
    );
    final prereqTalent2Input = FoxyFormItem(
      label: '前置天赋2',
      child: FoxyNumberInput<int>(
        placeholder: 'PrereqTalent2',
        controller: viewModel.prereqTalent2Controller,
      ),
    );

    final prereqRank0Input = FoxyFormItem(
      label: '前置等级0',
      child: FoxyNumberInput<int>(
        placeholder: 'PrereqRank0',
        controller: viewModel.prereqRank0Controller,
      ),
    );
    final prereqRank1Input = FoxyFormItem(
      label: '前置等级1',
      child: FoxyNumberInput<int>(
        placeholder: 'PrereqRank1',
        controller: viewModel.prereqRank1Controller,
      ),
    );
    final prereqRank2Input = FoxyFormItem(
      label: '前置等级2',
      child: FoxyNumberInput<int>(
        placeholder: 'PrereqRank2',
        controller: viewModel.prereqRank2Controller,
      ),
    );

    final categoryMask0Input = FoxyFormItem(
      label: '掩码0',
      child: FoxyNumberInput<int>(
        placeholder: 'CategoryMask0',
        controller: viewModel.categoryMask0Controller,
      ),
    );
    final categoryMask1Input = FoxyFormItem(
      label: '掩码1',
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
