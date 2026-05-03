import 'package:flutter/material.dart';
import 'package:foxy/page/talent/talent_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
    final idInput = FormItem(
      label: '编号',
      placeholder: 'ID',
      child: FoxyNumberInput<int>(
        value: viewModel.id.value,
        onChanged: (v) => viewModel.id.value = v,
        readOnly: true,
      ),
    );
    final tabIdInput = FormItem(
      label: '标签页',
      placeholder: 'TabID',
      child: FoxyNumberInput<int>(
        value: viewModel.tabId.value,
        onChanged: (v) => viewModel.tabId.value = v,
      ),
    );
    final tierIdInput = FormItem(
      label: '层',
      placeholder: 'TierID',
      child: FoxyNumberInput<int>(
        value: viewModel.tierId.value,
        onChanged: (v) => viewModel.tierId.value = v,
      ),
    );
    final columnIndexInput = FormItem(
      label: '列',
      placeholder: 'ColumnIndex',
      child: FoxyNumberInput<int>(
        value: viewModel.columnIndex.value,
        onChanged: (v) => viewModel.columnIndex.value = v,
      ),
    );
    final flagsInput = FormItem(
      label: '标志',
      placeholder: 'Flags',
      child: FoxyNumberInput<int>(
        value: viewModel.flags.value,
        onChanged: (v) => viewModel.flags.value = v,
      ),
    );
    final requiredSpellIdInput = FormItem(
      label: '必需法术',
      placeholder: 'RequiredSpellID',
      child: FoxyNumberInput<int>(
        value: viewModel.requiredSpellId.value,
        onChanged: (v) => viewModel.requiredSpellId.value = v,
      ),
    );

    final spellRank0Input = FormItem(
      label: '法术等级0',
      placeholder: 'SpellRank0',
      child: FoxyNumberInput<int>(
        value: viewModel.spellRank0.value,
        onChanged: (v) => viewModel.spellRank0.value = v,
      ),
    );
    final spellRank1Input = FormItem(
      label: '法术等级1',
      placeholder: 'SpellRank1',
      child: FoxyNumberInput<int>(
        value: viewModel.spellRank1.value,
        onChanged: (v) => viewModel.spellRank1.value = v,
      ),
    );
    final spellRank2Input = FormItem(
      label: '法术等级2',
      placeholder: 'SpellRank2',
      child: FoxyNumberInput<int>(
        value: viewModel.spellRank2.value,
        onChanged: (v) => viewModel.spellRank2.value = v,
      ),
    );
    final spellRank3Input = FormItem(
      label: '法术等级3',
      placeholder: 'SpellRank3',
      child: FoxyNumberInput<int>(
        value: viewModel.spellRank3.value,
        onChanged: (v) => viewModel.spellRank3.value = v,
      ),
    );
    final spellRank4Input = FormItem(
      label: '法术等级4',
      placeholder: 'SpellRank4',
      child: FoxyNumberInput<int>(
        value: viewModel.spellRank4.value,
        onChanged: (v) => viewModel.spellRank4.value = v,
      ),
    );
    final spellRank5Input = FormItem(
      label: '法术等级5',
      placeholder: 'SpellRank5',
      child: FoxyNumberInput<int>(
        value: viewModel.spellRank5.value,
        onChanged: (v) => viewModel.spellRank5.value = v,
      ),
    );
    final spellRank6Input = FormItem(
      label: '法术等级6',
      placeholder: 'SpellRank6',
      child: FoxyNumberInput<int>(
        value: viewModel.spellRank6.value,
        onChanged: (v) => viewModel.spellRank6.value = v,
      ),
    );
    final spellRank7Input = FormItem(
      label: '法术等级7',
      placeholder: 'SpellRank7',
      child: FoxyNumberInput<int>(
        value: viewModel.spellRank7.value,
        onChanged: (v) => viewModel.spellRank7.value = v,
      ),
    );
    final spellRank8Input = FormItem(
      label: '法术等级8',
      placeholder: 'SpellRank8',
      child: FoxyNumberInput<int>(
        value: viewModel.spellRank8.value,
        onChanged: (v) => viewModel.spellRank8.value = v,
      ),
    );

    final prereqTalent0Input = FormItem(
      label: '前置天赋0',
      placeholder: 'PrereqTalent0',
      child: FoxyNumberInput<int>(
        value: viewModel.prereqTalent0.value,
        onChanged: (v) => viewModel.prereqTalent0.value = v,
      ),
    );
    final prereqTalent1Input = FormItem(
      label: '前置天赋1',
      placeholder: 'PrereqTalent1',
      child: FoxyNumberInput<int>(
        value: viewModel.prereqTalent1.value,
        onChanged: (v) => viewModel.prereqTalent1.value = v,
      ),
    );
    final prereqTalent2Input = FormItem(
      label: '前置天赋2',
      placeholder: 'PrereqTalent2',
      child: FoxyNumberInput<int>(
        value: viewModel.prereqTalent2.value,
        onChanged: (v) => viewModel.prereqTalent2.value = v,
      ),
    );

    final prereqRank0Input = FormItem(
      label: '前置等级0',
      placeholder: 'PrereqRank0',
      child: FoxyNumberInput<int>(
        value: viewModel.prereqRank0.value,
        onChanged: (v) => viewModel.prereqRank0.value = v,
      ),
    );
    final prereqRank1Input = FormItem(
      label: '前置等级1',
      placeholder: 'PrereqRank1',
      child: FoxyNumberInput<int>(
        value: viewModel.prereqRank1.value,
        onChanged: (v) => viewModel.prereqRank1.value = v,
      ),
    );
    final prereqRank2Input = FormItem(
      label: '前置等级2',
      placeholder: 'PrereqRank2',
      child: FoxyNumberInput<int>(
        value: viewModel.prereqRank2.value,
        onChanged: (v) => viewModel.prereqRank2.value = v,
      ),
    );

    final categoryMask0Input = FormItem(
      label: '掩码0',
      placeholder: 'CategoryMask0',
      child: FoxyNumberInput<int>(
        value: viewModel.categoryMask0.value,
        onChanged: (v) => viewModel.categoryMask0.value = v,
      ),
    );
    final categoryMask1Input = FormItem(
      label: '掩码1',
      placeholder: 'CategoryMask1',
      child: FoxyNumberInput<int>(
        value: viewModel.categoryMask1.value,
        onChanged: (v) => viewModel.categoryMask1.value = v,
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          // 分组1: 基础信息
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
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
          ),
          // 分组2: 法术等级
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
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
          ),
          // 分组3: 前置天赋
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Row(
              spacing: 8,
              children: [
                Expanded(child: prereqTalent0Input),
                Expanded(child: prereqTalent1Input),
                Expanded(child: prereqTalent2Input),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          // 分组4: 前置等级
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Row(
              spacing: 8,
              children: [
                Expanded(child: prereqRank0Input),
                Expanded(child: prereqRank1Input),
                Expanded(child: prereqRank2Input),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          // 分组5: 掩码
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Row(
              spacing: 8,
              children: [
                Expanded(child: categoryMask0Input),
                Expanded(child: categoryMask1Input),
                Expanded(child: SizedBox()),
                Expanded(child: SizedBox()),
              ],
            ),
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
