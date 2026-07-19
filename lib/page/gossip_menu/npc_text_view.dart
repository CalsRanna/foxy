import 'package:flutter/material.dart';
import 'package:foxy/constant/gossip_menu_option_constants.dart';
import 'package:foxy/page/gossip_menu/npc_text_view_model.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NpcTextView extends StatefulWidget {
  final int textId;

  const NpcTextView({super.key, required this.textId});

  @override
  State<NpcTextView> createState() => _NpcTextViewState();
}

class _NpcTextViewState extends State<NpcTextView> {
  final viewModel = GetIt.instance.get<NpcTextViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.load(widget.textId);
  }

  @override
  void didUpdateWidget(covariant NpcTextView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.textId != widget.textId) viewModel.load(widget.textId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          _buildMetaSection(),
          _buildEntrySection(
            index: 0,
            text0Controller: viewModel.text00Controller,
            text1Controller: viewModel.text01Controller,
            localeText0Controller: viewModel.localeText00Controller,
            localeText1Controller: viewModel.localeText01Controller,
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
            text0Controller: viewModel.text10Controller,
            text1Controller: viewModel.text11Controller,
            localeText0Controller: viewModel.localeText10Controller,
            localeText1Controller: viewModel.localeText11Controller,
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
            text0Controller: viewModel.text20Controller,
            text1Controller: viewModel.text21Controller,
            localeText0Controller: viewModel.localeText20Controller,
            localeText1Controller: viewModel.localeText21Controller,
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
            text0Controller: viewModel.text30Controller,
            text1Controller: viewModel.text31Controller,
            localeText0Controller: viewModel.localeText30Controller,
            localeText1Controller: viewModel.localeText31Controller,
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
            text0Controller: viewModel.text40Controller,
            text1Controller: viewModel.text41Controller,
            localeText0Controller: viewModel.localeText40Controller,
            localeText1Controller: viewModel.localeText41Controller,
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
            text0Controller: viewModel.text50Controller,
            text1Controller: viewModel.text51Controller,
            localeText0Controller: viewModel.localeText50Controller,
            localeText1Controller: viewModel.localeText51Controller,
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
            text0Controller: viewModel.text60Controller,
            text1Controller: viewModel.text61Controller,
            localeText0Controller: viewModel.localeText60Controller,
            localeText1Controller: viewModel.localeText61Controller,
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
            text0Controller: viewModel.text70Controller,
            text1Controller: viewModel.text71Controller,
            localeText0Controller: viewModel.localeText70Controller,
            localeText1Controller: viewModel.localeText71Controller,
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
                label: 'VerifiedBuild',
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

  Widget _buildEntrySection({
    required int index,
    required StringFieldController text0Controller,
    required StringFieldController text1Controller,
    required StringFieldController localeText0Controller,
    required StringFieldController localeText1Controller,
    required IntFieldController broadcastController,
    required IntFieldController languageController,
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
                child: FoxyIntShadSelect(
                  controller: languageController,
                  options: kNpcTextLanguages,
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
              child: _localizedTextField(
                label: '文本 0',
                mainController: text0Controller,
                localeController: localeText0Controller,
                mainPlaceholder: 'text${index}_0',
                localePlaceholder: 'zhCN Text${index}_0',
              ),
            ),
          ],
        ),
        Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _localizedTextField(
                label: '文本 1',
                mainController: text1Controller,
                localeController: localeText1Controller,
                mainPlaceholder: 'text${index}_1',
                localePlaceholder: 'zhCN Text${index}_1',
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

  Widget _localizedTextField({
    required String label,
    required StringFieldController mainController,
    required StringFieldController localeController,
    required String mainPlaceholder,
    required String localePlaceholder,
  }) {
    return FoxyFormItem(
      label: label,
      child: Column(
        spacing: 6,
        children: [
          FoxyStringInput(
            controller: mainController,
            placeholder: mainPlaceholder,
          ),
          FoxyStringInput(
            controller: localeController,
            placeholder: localePlaceholder,
          ),
        ],
      ),
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

  Widget _buildActions() {
    return Row(
      children: [
        ShadButton(onPressed: viewModel.save, child: const Text('保存')),
        const SizedBox(width: 8),
        ShadButton.ghost(
          onPressed: () => GetIt.instance.get<RouterFacade>().goBack(),
          child: const Text('取消'),
        ),
      ],
    );
  }
}
