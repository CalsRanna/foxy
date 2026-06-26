import 'package:flutter/material.dart';
import 'package:foxy/page/achievement/achievement_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AchievementView extends StatefulWidget {
  final int? entry;
  const AchievementView({super.key, this.entry});

  @override
  State<AchievementView> createState() => _AchievementViewState();
}

class _AchievementViewState extends State<AchievementView> {
  final viewModel = GetIt.instance.get<AchievementDetailViewModel>();

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
          _buildBasicInfoCard(),
          _buildTitleCard(),
          _buildDescriptionCard(),
          _buildRewardCard(),
          _buildOtherCard(),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildBasicInfoCard() {
    final idInput = FormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        value: viewModel.id.value,
        onChanged: (v) => viewModel.id.value = v,
        readOnly: true,
      ),
    );
    final factionInput = FormItem(
      label: '阵营',
      child: FoxyNumberInput<int>(
        placeholder: 'Faction',
        value: viewModel.faction.value,
        onChanged: (v) => viewModel.faction.value = v,
      ),
    );
    final instanceIdInput = FormItem(
      label: '实例编号',
      child: FoxyNumberInput<int>(
        placeholder: 'Instance_ID',
        value: viewModel.instanceId.value,
        onChanged: (v) => viewModel.instanceId.value = v,
      ),
    );
    final supercedesInput = FormItem(
      label: '前置成就',
      child: FoxyNumberInput<int>(
        placeholder: 'Supercedes',
        value: viewModel.supercedes.value,
        onChanged: (v) => viewModel.supercedes.value = v,
      ),
    );

    return ShadCard(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(child: idInput),
              Expanded(child: factionInput),
              Expanded(child: instanceIdInput),
              Expanded(child: supercedesInput),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleCard() {
    final enUsInput = FormItem(
      controller: viewModel.titleLangEnUSController,
      label: '标题(enUS)',
      placeholder: 'Title_lang_enUS',
    );
    final zhCnInput = FormItem(
      controller: viewModel.titleLangZhCNController,
      label: '标题(zhCN)',
      placeholder: 'Title_lang_zhCN',
    );
    final zhTwInput = FormItem(
      controller: viewModel.titleLangZhTWController,
      label: '标题(zhTW)',
      placeholder: 'Title_lang_zhTW',
    );
    final koKrInput = FormItem(
      controller: viewModel.titleLangKoKRController,
      label: '标题(koKR)',
      placeholder: 'Title_lang_koKR',
    );

    return ShadCard(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Text('标题文本', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            spacing: 8,
            children: [
              Expanded(child: enUsInput),
              Expanded(child: zhCnInput),
              Expanded(child: zhTwInput),
              Expanded(child: koKrInput),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard() {
    final enUsInput = FormItem(
      controller: viewModel.descriptionLangEnUSController,
      label: '描述(enUS)',
      placeholder: 'Description_lang_enUS',
    );
    final zhCnInput = FormItem(
      controller: viewModel.descriptionLangZhCNController,
      label: '描述(zhCN)',
      placeholder: 'Description_lang_zhCN',
    );
    final zhTwInput = FormItem(
      controller: viewModel.descriptionLangZhTWController,
      label: '描述(zhTW)',
      placeholder: 'Description_lang_zhTW',
    );
    final koKrInput = FormItem(
      controller: viewModel.descriptionLangKoKRController,
      label: '描述(koKR)',
      placeholder: 'Description_lang_koKR',
    );

    return ShadCard(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Text('描述文本', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            spacing: 8,
            children: [
              Expanded(child: enUsInput),
              Expanded(child: zhCnInput),
              Expanded(child: zhTwInput),
              Expanded(child: koKrInput),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard() {
    final enUsInput = FormItem(
      controller: viewModel.rewardLangEnUSController,
      label: '奖励(enUS)',
      placeholder: 'Reward_lang_enUS',
    );
    final zhCnInput = FormItem(
      controller: viewModel.rewardLangZhCNController,
      label: '奖励(zhCN)',
      placeholder: 'Reward_lang_zhCN',
    );
    final zhTwInput = FormItem(
      controller: viewModel.rewardLangZhTWController,
      label: '奖励(zhTW)',
      placeholder: 'Reward_lang_zhTW',
    );
    final koKrInput = FormItem(
      controller: viewModel.rewardLangKoKRController,
      label: '奖励(koKR)',
      placeholder: 'Reward_lang_koKR',
    );

    return ShadCard(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Text('奖励文本', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            spacing: 8,
            children: [
              Expanded(child: enUsInput),
              Expanded(child: zhCnInput),
              Expanded(child: zhTwInput),
              Expanded(child: koKrInput),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtherCard() {
    final categoryInput = FormItem(
      label: '类别',
      child: FoxyNumberInput<int>(
        placeholder: 'Category',
        value: viewModel.category.value,
        onChanged: (v) => viewModel.category.value = v,
      ),
    );
    final pointsInput = FormItem(
      label: '点数',
      child: FoxyNumberInput<int>(
        placeholder: 'Points',
        value: viewModel.points.value,
        onChanged: (v) => viewModel.points.value = v,
      ),
    );
    final uiOrderInput = FormItem(
      label: '排序',
      child: FoxyNumberInput<int>(
        placeholder: 'Ui_order',
        value: viewModel.uiOrder.value,
        onChanged: (v) => viewModel.uiOrder.value = v,
      ),
    );
    final flagsInput = FormItem(
      label: '标识',
      child: FoxyNumberInput<int>(
        placeholder: 'Flags',
        value: viewModel.flags.value,
        onChanged: (v) => viewModel.flags.value = v,
      ),
    );
    final iconIdInput = FormItem(
      label: '图标编号',
      child: FoxyNumberInput<int>(
        placeholder: 'IconID',
        value: viewModel.iconId.value,
        onChanged: (v) => viewModel.iconId.value = v,
      ),
    );
    final minimumCriteriaInput = FormItem(
      label: '最小完成条件',
      child: FoxyNumberInput<int>(
        placeholder: 'Minimum_criteria',
        value: viewModel.minimumCriteria.value,
        onChanged: (v) => viewModel.minimumCriteria.value = v,
      ),
    );
    final sharesCriteriaInput = FormItem(
      label: '共享条件',
      child: FoxyNumberInput<int>(
        placeholder: 'Shares_criteria',
        value: viewModel.sharesCriteria.value,
        onChanged: (v) => viewModel.sharesCriteria.value = v,
      ),
    );

    return ShadCard(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Text('其他', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            spacing: 8,
            children: [
              Expanded(child: categoryInput),
              Expanded(child: pointsInput),
              Expanded(child: uiOrderInput),
              Expanded(child: flagsInput),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(child: iconIdInput),
              Expanded(child: minimumCriteriaInput),
              Expanded(child: sharesCriteriaInput),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
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
