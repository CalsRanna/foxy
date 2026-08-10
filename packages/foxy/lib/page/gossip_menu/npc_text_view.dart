import 'package:flutter/material.dart';
import 'package:foxy/constant/gossip_menu_option_constants.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/npc_text_linked_detail_view_model.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class NpcTextView extends StatefulWidget {
  final int textId;

  const NpcTextView({super.key, required this.textId});

  @override
  State<NpcTextView> createState() => _NpcTextViewState();
}

class _NpcTextViewState extends State<NpcTextView> {
  final viewModel = GetIt.instance.get<NpcTextLinkedDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch(
      (_) => SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            if (viewModel.errorMessage.value != null)
              FoxyInlineError(message: viewModel.errorMessage.value),
            _buildMetaSection(),
            _buildEntrySection(
              index: 0,
              entry: viewModel.editingKey.value,
              text0Controller: viewModel.text00Controller,
              text1Controller: viewModel.text01Controller,
              text0Delegate: FoxyLocalePickerDelegates.npcTextText00,
              text1Delegate: FoxyLocalePickerDelegates.npcTextText01,
              broadcastController: viewModel.broadcastTextId0Controller,
              languageController: viewModel.lang0Controller,
              probabilityController: viewModel.probability0Controller,
              delay0Controller: viewModel.em00Controller,
              emote0Controller: viewModel.em01Controller,
              delay1Controller: viewModel.em02Controller,
              emote1Controller: viewModel.em03Controller,
              delay2Controller: viewModel.em04Controller,
              emote2Controller: viewModel.em05Controller,
            ),
            _buildEntrySection(
              index: 1,
              entry: viewModel.editingKey.value,
              text0Controller: viewModel.text10Controller,
              text1Controller: viewModel.text11Controller,
              text0Delegate: FoxyLocalePickerDelegates.npcTextText10,
              text1Delegate: FoxyLocalePickerDelegates.npcTextText11,
              broadcastController: viewModel.broadcastTextId1Controller,
              languageController: viewModel.lang1Controller,
              probabilityController: viewModel.probability1Controller,
              delay0Controller: viewModel.em10Controller,
              emote0Controller: viewModel.em11Controller,
              delay1Controller: viewModel.em12Controller,
              emote1Controller: viewModel.em13Controller,
              delay2Controller: viewModel.em14Controller,
              emote2Controller: viewModel.em15Controller,
            ),
            _buildEntrySection(
              index: 2,
              entry: viewModel.editingKey.value,
              text0Controller: viewModel.text20Controller,
              text1Controller: viewModel.text21Controller,
              text0Delegate: FoxyLocalePickerDelegates.npcTextText20,
              text1Delegate: FoxyLocalePickerDelegates.npcTextText21,
              broadcastController: viewModel.broadcastTextId2Controller,
              languageController: viewModel.lang2Controller,
              probabilityController: viewModel.probability2Controller,
              delay0Controller: viewModel.em20Controller,
              emote0Controller: viewModel.em21Controller,
              delay1Controller: viewModel.em22Controller,
              emote1Controller: viewModel.em23Controller,
              delay2Controller: viewModel.em24Controller,
              emote2Controller: viewModel.em25Controller,
            ),
            _buildEntrySection(
              index: 3,
              entry: viewModel.editingKey.value,
              text0Controller: viewModel.text30Controller,
              text1Controller: viewModel.text31Controller,
              text0Delegate: FoxyLocalePickerDelegates.npcTextText30,
              text1Delegate: FoxyLocalePickerDelegates.npcTextText31,
              broadcastController: viewModel.broadcastTextId3Controller,
              languageController: viewModel.lang3Controller,
              probabilityController: viewModel.probability3Controller,
              delay0Controller: viewModel.em30Controller,
              emote0Controller: viewModel.em31Controller,
              delay1Controller: viewModel.em32Controller,
              emote1Controller: viewModel.em33Controller,
              delay2Controller: viewModel.em34Controller,
              emote2Controller: viewModel.em35Controller,
            ),
            _buildEntrySection(
              index: 4,
              entry: viewModel.editingKey.value,
              text0Controller: viewModel.text40Controller,
              text1Controller: viewModel.text41Controller,
              text0Delegate: FoxyLocalePickerDelegates.npcTextText40,
              text1Delegate: FoxyLocalePickerDelegates.npcTextText41,
              broadcastController: viewModel.broadcastTextId4Controller,
              languageController: viewModel.lang4Controller,
              probabilityController: viewModel.probability4Controller,
              delay0Controller: viewModel.em40Controller,
              emote0Controller: viewModel.em41Controller,
              delay1Controller: viewModel.em42Controller,
              emote1Controller: viewModel.em43Controller,
              delay2Controller: viewModel.em44Controller,
              emote2Controller: viewModel.em45Controller,
            ),
            _buildEntrySection(
              index: 5,
              entry: viewModel.editingKey.value,
              text0Controller: viewModel.text50Controller,
              text1Controller: viewModel.text51Controller,
              text0Delegate: FoxyLocalePickerDelegates.npcTextText50,
              text1Delegate: FoxyLocalePickerDelegates.npcTextText51,
              broadcastController: viewModel.broadcastTextId5Controller,
              languageController: viewModel.lang5Controller,
              probabilityController: viewModel.probability5Controller,
              delay0Controller: viewModel.em50Controller,
              emote0Controller: viewModel.em51Controller,
              delay1Controller: viewModel.em52Controller,
              emote1Controller: viewModel.em53Controller,
              delay2Controller: viewModel.em54Controller,
              emote2Controller: viewModel.em55Controller,
            ),
            _buildEntrySection(
              index: 6,
              entry: viewModel.editingKey.value,
              text0Controller: viewModel.text60Controller,
              text1Controller: viewModel.text61Controller,
              text0Delegate: FoxyLocalePickerDelegates.npcTextText60,
              text1Delegate: FoxyLocalePickerDelegates.npcTextText61,
              broadcastController: viewModel.broadcastTextId6Controller,
              languageController: viewModel.lang6Controller,
              probabilityController: viewModel.probability6Controller,
              delay0Controller: viewModel.em60Controller,
              emote0Controller: viewModel.em61Controller,
              delay1Controller: viewModel.em62Controller,
              emote1Controller: viewModel.em63Controller,
              delay2Controller: viewModel.em64Controller,
              emote2Controller: viewModel.em65Controller,
            ),
            _buildEntrySection(
              index: 7,
              entry: viewModel.editingKey.value,
              text0Controller: viewModel.text70Controller,
              text1Controller: viewModel.text71Controller,
              text0Delegate: FoxyLocalePickerDelegates.npcTextText70,
              text1Delegate: FoxyLocalePickerDelegates.npcTextText71,
              broadcastController: viewModel.broadcastTextId7Controller,
              languageController: viewModel.lang7Controller,
              probabilityController: viewModel.probability7Controller,
              delay0Controller: viewModel.em70Controller,
              emote0Controller: viewModel.em71Controller,
              delay1Controller: viewModel.em72Controller,
              emote1Controller: viewModel.em73Controller,
              delay2Controller: viewModel.em74Controller,
              emote2Controller: viewModel.em75Controller,
            ),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant NpcTextView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.textId != widget.textId) {
      _initialize();
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Widget _buildActions() {
    return Row(
      children: [
        Watch(
          (_) => ShadButton(
            enabled: !viewModel.submitting.value,
            onPressed: _persist,
            child: const Text('保存'),
          ),
        ),
        const SizedBox(width: 8),
        ShadButton.ghost(onPressed: _goBack, child: const Text('取消')),
      ],
    );
  }

  Widget _buildEntrySection({
    required int index,
    required int? entry,
    required StringFieldController text0Controller,
    required StringFieldController text1Controller,
    required DatabaseLocaleEditorDelegate text0Delegate,
    required DatabaseLocaleEditorDelegate text1Delegate,
    required IntFieldController broadcastController,
    required SelectFieldController<int> languageController,
    required DoubleFieldController probabilityController,
    required IntFieldController delay0Controller,
    required IntFieldController emote0Controller,
    required IntFieldController delay1Controller,
    required IntFieldController emote1Controller,
    required IntFieldController delay2Controller,
    required IntFieldController emote2Controller,
  }) {
    return FoxyFormSection(
      title: '组 $index',
      children: [
        Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '语言',
                child: FoxyShadSelect<int>(
                  controller: languageController,
                  options: GossipMenuOptionConstants.npcTextLanguages,
                  placeholder: Text('lang$index'),
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '几率',
                child: FoxyNumberInput<double>(
                  controller: probabilityController,
                  placeholder: 'Probability$index',
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '广播文本',
                child: FoxyEntityPicker(
                  delegate: FoxyEntityPickerDelegates.broadcastText,
                  controller: broadcastController,
                  placeholder: 'BroadcastTextID$index',
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '文本 0',
                child: FoxyLocalePicker(
                  entry: entry,
                  controller: text0Controller,
                  delegate: text0Delegate,
                  placeholder: 'text${index}_0',
                  title: '文本 $index-0',
                ),
              ),
            ),
          ],
        ),
        Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '文本 1',
                child: FoxyLocalePicker(
                  entry: entry,
                  controller: text1Controller,
                  delegate: text1Delegate,
                  placeholder: 'text${index}_1',
                  title: '文本 $index-1',
                ),
              ),
            ),
            Expanded(
              child: _delayField('延迟 1', 'em${index}_0', delay0Controller),
            ),
            Expanded(
              child: _emoteField('表情 1', 'em${index}_1', emote0Controller),
            ),
            Expanded(
              child: _delayField('延迟 2', 'em${index}_2', delay1Controller),
            ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: _emoteField('表情 2', 'em${index}_3', emote1Controller),
            ),
            Expanded(
              child: _delayField('延迟 3', 'em${index}_4', delay2Controller),
            ),
            Expanded(
              child: _emoteField('表情 3', 'em${index}_5', emote2Controller),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildMetaSection() {
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
                  controller: viewModel.idController,
                  placeholder: 'ID',
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '验证版本',
                child: FoxyNumberInput<int>(
                  controller: viewModel.verifiedBuildController,
                  placeholder: 'VerifiedBuild',
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _delayField(
    String label,
    String placeholder,
    IntFieldController controller,
  ) {
    return FoxyFormItem(
      label: label,
      child: FoxyNumberInput<int>(
        controller: controller,
        placeholder: placeholder,
      ),
    );
  }

  Widget _emoteField(
    String label,
    String placeholder,
    IntFieldController controller,
  ) {
    return FoxyFormItem(
      label: label,
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.dbcEmote,
        controller: controller,
        placeholder: placeholder,
      ),
    );
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(linkKey: widget.textId);
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(FoxyError.message(error))));
    }
  }

  Future<void> _persist() async {
    try {
      await viewModel.persist();
      if (!mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(FoxyError.message(error))));
    }
  }
}
