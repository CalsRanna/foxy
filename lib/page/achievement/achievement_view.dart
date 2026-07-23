import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/constant/achievement_constants.dart';
import 'package:foxy/page/achievement/achievement_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class AchievementView extends StatelessWidget {
  final AchievementDetailViewModel viewModel;

  const AchievementView({super.key, required this.viewModel});

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
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildBasicInfoCard() {
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
      ),
    );
    final factionInput = FoxyFormItem(
      label: '阵营',
      child: FoxyShadSelect<int>(
        controller: viewModel.factionController,
        options: kAchievementFactionOptions,
        placeholder: const Text('Faction'),
      ),
    );
    final instanceIdInput = FoxyFormItem(
      label: '限制地图',
      child: FoxyEntityPicker(
        placeholder: 'Instance_ID',
        controller: viewModel.instanceIdController,
        delegate: FoxyEntityPickerDelegates.map,
      ),
    );
    final supercedesInput = FoxyFormItem(
      label: '前置成就',
      child: FoxyEntityPicker(
        placeholder: 'Supercedes',
        controller: viewModel.supercedesController,
        delegate: FoxyEntityPickerDelegates.achievement,
      ),
    );

    return FoxyFormSection(
      title: '基础信息',
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
    );
  }

  Widget _buildTitleCard() {
    return FoxyFormSection(
      title: '标题文本',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '标题',
                child: Watch((_) {
                  final id = viewModel.persistedKey.value;
                  return FoxyLocalePicker(
                    entry: id,
                    controller: viewModel.titleLangZhCNController,
                    title: '标题本地化',
                    placeholder: 'Title_lang_zhCN',
                    delegate: FoxyLocalePickerDelegates.dbcAchievementTitle,
                    onSaved: viewModel.applyTitleLocales,
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

  Widget _buildDescriptionCard() {
    return FoxyFormSection(
      title: '描述文本',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '描述',
                child: Watch((_) {
                  final id = viewModel.persistedKey.value;
                  return FoxyLocalePicker(
                    entry: id,
                    controller: viewModel.descriptionLangZhCNController,
                    title: '描述本地化',
                    placeholder: 'Description_lang_zhCN',
                    delegate:
                        FoxyLocalePickerDelegates.dbcAchievementDescription,
                    onSaved: viewModel.applyDescriptionLocales,
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

  Widget _buildRewardCard() {
    return FoxyFormSection(
      title: '奖励文本',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '奖励',
                child: Watch((_) {
                  final id = viewModel.persistedKey.value;
                  return FoxyLocalePicker(
                    entry: id,
                    controller: viewModel.rewardLangZhCNController,
                    title: '奖励文本本地化',
                    placeholder: 'Reward_lang_zhCN',
                    delegate: FoxyLocalePickerDelegates.dbcAchievementReward,
                    onSaved: viewModel.applyRewardLocales,
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

  Widget _buildOtherCard() {
    final categoryInput = FoxyFormItem(
      label: '成就分类',
      child: FoxyEntityPicker(
        placeholder: 'Category',
        controller: viewModel.categoryController,
        delegate: FoxyEntityPickerDelegates.achievementCategory,
      ),
    );
    final pointsInput = FoxyFormItem(
      label: '点数',
      child: FoxyNumberInput<int>(
        placeholder: 'Points',
        controller: viewModel.pointsController,
      ),
    );
    final uiOrderInput = FoxyFormItem(
      label: '排序',
      child: FoxyNumberInput<int>(
        placeholder: 'Ui_order',
        controller: viewModel.uiOrderController,
      ),
    );
    final flagsInput = FoxyFormItem(
      label: '成就标志',
      child: FoxyFlagPicker(
        placeholder: 'Flags',
        controller: viewModel.flagsController,
        flags: kAchievementFlagOptions,
        title: '成就标志',
      ),
    );
    final iconIdInput = FoxyFormItem(
      label: '成就图标',
      child: FoxyEntityPicker(
        placeholder: 'IconID',
        controller: viewModel.iconIdController,
        delegate: FoxyEntityPickerDelegates.spellIcon,
      ),
    );
    final minimumCriteriaInput = FoxyFormItem(
      label: '最少完成条件数',
      child: FoxyNumberInput<int>(
        placeholder: 'Minimum_criteria',
        controller: viewModel.minimumCriteriaController,
      ),
    );
    final sharesCriteriaInput = FoxyFormItem(
      label: '共享条件成就',
      child: FoxyEntityPicker(
        placeholder: 'Shares_criteria',
        controller: viewModel.sharesCriteriaController,
        delegate: FoxyEntityPickerDelegates.achievement,
      ),
    );

    return FoxyFormSection(
      title: '其他',
      children: [
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
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Watch(
          (_) => ShadButton(
            enabled: !viewModel.submitting.value,
            onPressed: () => _persist(context),
            child: Text('保存'),
          ),
        ),
        const SizedBox(width: 8),
        ShadButton.ghost(onPressed: _goBack, child: Text('取消')),
      ],
    );
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      GetIt.instance.get<RouterFacade>().updateCurrentLabel(
        '成就 ${viewModel.persistedKey.value}',
      );
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('成就数据已保存')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }
}
