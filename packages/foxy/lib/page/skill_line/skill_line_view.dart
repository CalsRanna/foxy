import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/skill_line_detail_view_model.dart';
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

class SkillLineView extends StatelessWidget {
  final SkillLineDetailViewModel viewModel;

  const SkillLineView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
      ),
    );
    final categoryIdInput = FoxyFormItem(
      label: '分类',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.skillLineCategory,
        controller: viewModel.categoryIdController,
        placeholder: 'CategoryID',
      ),
    );
    final skillCostsIdInput = FoxyFormItem(
      label: '成本',
      child: FoxyNumberInput<int>(
        placeholder: 'SkillCostsID',
        controller: viewModel.skillCostsIdController,
      ),
    );
    final spellIconIdInput = FoxyFormItem(
      label: '图标',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.spellIcon,
        controller: viewModel.spellIconIdController,
        placeholder: 'SpellIconID',
      ),
    );
    final canLinkInput = FoxyFormItem(
      label: '可链接',
      child: FoxyNumberInput<int>(
        placeholder: 'CanLink',
        controller: viewModel.canLinkController,
      ),
    );

    // === Localized text (main form shows zhCN; globe button edits 16
    // languages) ===
    final displayNameInput = FoxyFormItem(
      label: '名称',
      child: Watch((_) {
        final entry = viewModel.persistedKey.value;
        return FoxyLocalePicker(
          entry: entry,
          controller: viewModel.displayNameLangZhCNController,
          title: '专业技能名称本地化',
          placeholder: 'DisplayName_lang_zhCN',
          delegate: FoxyLocalePickerDelegates.dbcSkillLineDisplayName,
          onSaved: viewModel.applyDisplayNameLocales,
        );
      }),
    );
    final descriptionInput = FoxyFormItem(
      label: '描述',
      child: Watch((_) {
        final entry = viewModel.persistedKey.value;
        return FoxyLocalePicker(
          entry: entry,
          controller: viewModel.descriptionLangZhCNController,
          title: '专业技能描述本地化',
          placeholder: 'Description_lang_zhCN',
          delegate: FoxyLocalePickerDelegates.dbcSkillLineDescription,
          onSaved: viewModel.applyDescriptionLocales,
        );
      }),
    );
    final alternateVerbInput = FoxyFormItem(
      label: '备选动词',
      child: Watch((_) {
        final entry = viewModel.persistedKey.value;
        return FoxyLocalePicker(
          entry: entry,
          controller: viewModel.alternateVerbLangZhCNController,
          title: '备选动词本地化',
          placeholder: 'AlternateVerb_lang_zhCN',
          delegate: FoxyLocalePickerDelegates.dbcSkillLineAlternateVerb,
          onSaved: viewModel.applyAlternateVerbLocales,
        );
      }),
    );
    final displayNameLangFlagsInput = FoxyFormItem(
      label: '名称语言标志',
      child: FoxyNumberInput<int>(
        placeholder: 'DisplayName_lang_Flags',
        controller: viewModel.displayNameLangFlagsController,
      ),
    );
    final descriptionLangFlagsInput = FoxyFormItem(
      label: '描述语言标志',
      child: FoxyNumberInput<int>(
        placeholder: 'Description_lang_Flags',
        controller: viewModel.descriptionLangFlagsController,
      ),
    );
    final alternateVerbLangFlagsInput = FoxyFormItem(
      label: '动词语言标志',
      child: FoxyNumberInput<int>(
        placeholder: 'AlternateVerb_lang_Flags',
        controller: viewModel.alternateVerbLangFlagsController,
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '基本信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: idInput),
                  Expanded(child: categoryIdInput),
                  Expanded(child: skillCostsIdInput),
                  Expanded(child: spellIconIdInput),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(child: canLinkInput),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '名称本地化',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: displayNameInput),
                  Expanded(child: displayNameLangFlagsInput),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '描述本地化',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: descriptionInput),
                  Expanded(child: descriptionLangFlagsInput),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '备选动词本地化',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: alternateVerbInput),
                  Expanded(child: alternateVerbLangFlagsInput),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          Row(
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
          ),
        ],
      ),
    );
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('专业技能数据已保存')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(FoxyExceptions.message(error))));
    }
  }
}
