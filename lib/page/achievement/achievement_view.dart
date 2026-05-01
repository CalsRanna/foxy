import 'package:flutter/material.dart';
import 'package:foxy/page/achievement/achievement_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
      controller: viewModel.idController,
      label: '编号',
      placeholder: 'ID',
      readOnly: true,
    );
    final factionInput = FormItem(
      controller: viewModel.factionController,
      label: '阵营',
      placeholder: 'Faction',
    );
    final instanceIdInput = FormItem(
      controller: viewModel.instanceIdController,
      label: '实例编号',
      placeholder: 'Instance_ID',
    );
    final supercedesInput = FormItem(
      controller: viewModel.supercedesController,
      label: '前置成就',
      placeholder: 'Supercedes',
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
      controller: viewModel.categoryController,
      label: '类别',
      placeholder: 'Category',
    );
    final pointsInput = FormItem(
      controller: viewModel.pointsController,
      label: '点数',
      placeholder: 'Points',
    );
    final uiOrderInput = FormItem(
      controller: viewModel.uiOrderController,
      label: '排序',
      placeholder: 'Ui_order',
    );
    final flagsInput = FormItem(
      controller: viewModel.flagsController,
      label: '标识',
      placeholder: 'Flags',
    );
    final iconIdInput = FormItem(
      controller: viewModel.iconIdController,
      label: '图标编号',
      placeholder: 'IconID',
    );
    final minimumCriteriaInput = FormItem(
      controller: viewModel.minimumCriteriaController,
      label: '最小完成条件',
      placeholder: 'Minimum_criteria',
    );
    final sharesCriteriaInput = FormItem(
      controller: viewModel.sharesCriteriaController,
      label: '共享条件',
      placeholder: 'Shares_criteria',
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
