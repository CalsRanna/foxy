import 'package:flutter/material.dart';
import 'package:foxy/page/talent/talent_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
      controller: viewModel.idController,
      label: '编号',
      placeholder: 'ID',
      readOnly: true,
    );
    final tabIdInput = FormItem(
      controller: viewModel.tabIdController,
      label: '标签页',
      placeholder: 'TabID',
    );
    final tierIdInput = FormItem(
      controller: viewModel.tierIdController,
      label: '层',
      placeholder: 'TierID',
    );
    final columnIndexInput = FormItem(
      controller: viewModel.columnIndexController,
      label: '列',
      placeholder: 'ColumnIndex',
    );
    final flagsInput = FormItem(
      controller: viewModel.flagsController,
      label: '标志',
      placeholder: 'Flags',
    );
    final requiredSpellIdInput = FormItem(
      controller: viewModel.requiredSpellIdController,
      label: '必需法术',
      placeholder: 'RequiredSpellID',
    );

    final spellRank0Input = FormItem(
      controller: viewModel.spellRank0Controller,
      label: '法术等级0',
      placeholder: 'SpellRank0',
    );
    final spellRank1Input = FormItem(
      controller: viewModel.spellRank1Controller,
      label: '法术等级1',
      placeholder: 'SpellRank1',
    );
    final spellRank2Input = FormItem(
      controller: viewModel.spellRank2Controller,
      label: '法术等级2',
      placeholder: 'SpellRank2',
    );
    final spellRank3Input = FormItem(
      controller: viewModel.spellRank3Controller,
      label: '法术等级3',
      placeholder: 'SpellRank3',
    );
    final spellRank4Input = FormItem(
      controller: viewModel.spellRank4Controller,
      label: '法术等级4',
      placeholder: 'SpellRank4',
    );
    final spellRank5Input = FormItem(
      controller: viewModel.spellRank5Controller,
      label: '法术等级5',
      placeholder: 'SpellRank5',
    );
    final spellRank6Input = FormItem(
      controller: viewModel.spellRank6Controller,
      label: '法术等级6',
      placeholder: 'SpellRank6',
    );
    final spellRank7Input = FormItem(
      controller: viewModel.spellRank7Controller,
      label: '法术等级7',
      placeholder: 'SpellRank7',
    );
    final spellRank8Input = FormItem(
      controller: viewModel.spellRank8Controller,
      label: '法术等级8',
      placeholder: 'SpellRank8',
    );

    final prereqTalent0Input = FormItem(
      controller: viewModel.prereqTalent0Controller,
      label: '前置天赋0',
      placeholder: 'PrereqTalent0',
    );
    final prereqTalent1Input = FormItem(
      controller: viewModel.prereqTalent1Controller,
      label: '前置天赋1',
      placeholder: 'PrereqTalent1',
    );
    final prereqTalent2Input = FormItem(
      controller: viewModel.prereqTalent2Controller,
      label: '前置天赋2',
      placeholder: 'PrereqTalent2',
    );

    final prereqRank0Input = FormItem(
      controller: viewModel.prereqRank0Controller,
      label: '前置等级0',
      placeholder: 'PrereqRank0',
    );
    final prereqRank1Input = FormItem(
      controller: viewModel.prereqRank1Controller,
      label: '前置等级1',
      placeholder: 'PrereqRank1',
    );
    final prereqRank2Input = FormItem(
      controller: viewModel.prereqRank2Controller,
      label: '前置等级2',
      placeholder: 'PrereqRank2',
    );

    final categoryMask0Input = FormItem(
      controller: viewModel.categoryMask0Controller,
      label: '掩码0',
      placeholder: 'CategoryMask0',
    );
    final categoryMask1Input = FormItem(
      controller: viewModel.categoryMask1Controller,
      label: '掩码1',
      placeholder: 'CategoryMask1',
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
