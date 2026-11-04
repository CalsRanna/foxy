import 'package:flutter/material.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/achievement_detail_view_model.dart';
import 'package:foxy/widget/picker/foxy_entity_picker.dart';
import 'package:foxy/widget/picker/delegate/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/picker/foxy_flag_picker.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:foxy/widget/picker/locale/foxy_locale_picker.dart';
import 'package:foxy/widget/picker/delegate/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/form/foxy_number_input.dart';
import 'package:foxy/widget/picker/foxy_enum_picker.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:get_it/get_it.dart';
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
          _buildLocaleTextCard(),
          _buildOtherCard(),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        SignalBuilder(
          builder: (_) => ShadButton(
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
      child: FoxyEnumPicker<int>(
        title: '阵营',
        controller: viewModel.factionController,
        options: AchievementConstants.achievementFactionOptions,
        placeholder: 'Faction',
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

  Widget _buildLocaleTextCard() {
    return FoxyFormSection(
      title: '本地化文本',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '标题',
                child: SignalBuilder(
                  builder: (_) {
                    final id = viewModel.persistedKey.value;
                    return FoxyLocalePicker(
                      entry: id,
                      controller: viewModel.titleLangZhCNController,
                      title: '标题本地化',
                      placeholder: 'Title_lang_zhCN',
                      delegate: FoxyLocalePickerDelegates.dbcAchievementTitle,
                      onSaved: viewModel.applyTitleLocales,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '描述',
                child: SignalBuilder(
                  builder: (_) {
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
                  },
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '奖励',
                child: SignalBuilder(
                  builder: (_) {
                    final id = viewModel.persistedKey.value;
                    return FoxyLocalePicker(
                      entry: id,
                      controller: viewModel.rewardLangZhCNController,
                      title: '奖励文本本地化',
                      placeholder: 'Reward_lang_zhCN',
                      delegate: FoxyLocalePickerDelegates.dbcAchievementReward,
                      onSaved: viewModel.applyRewardLocales,
                    );
                  },
                ),
              ),
            ),
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
        flags: AchievementConstants.achievementFlagOptions,
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
      label: '最少条件数',
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
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      DialogUtil.instance.success('成就数据已保存');
    } catch (error) {
      if (!context.mounted) return;
      DialogUtil.instance.error('保存失败：${FoxyExceptions.message(error)}');
    }
  }
}
