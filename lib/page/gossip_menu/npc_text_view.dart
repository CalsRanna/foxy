import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/page/gossip_menu/npc_text_view_model.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Tab 2：npc_text 主表 + npc_text_locale (zhCN)
class NpcTextView extends StatefulWidget {
  final int textId;

  const NpcTextView({super.key, required this.textId});

  @override
  State<NpcTextView> createState() => _NpcTextViewState();
}

class _NpcTextViewState extends State<NpcTextView> {
  final viewModel = GetIt.instance.get<NpcTextViewModel>();

  /// 本地 UI 状态：哪些 locale 输入框展开
  final _expandedLocales = <String>{};

  @override
  void initState() {
    super.initState();
    viewModel.load(widget.textId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final sections = <Widget>[_buildMetaSection()];
      for (var n = 0; n < 8; n++) {
        sections.add(_buildEntrySection(n));
      }
      sections.add(_buildActions());
      return SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: sections,
        ),
      );
    });
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
                  fieldController: viewModel.intOf('ID'),
                  placeholder: 'ID',
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: 'VerifiedBuild',
                child: FoxyNumberInput<int>(
                  fieldController: viewModel.intOf('VerifiedBuild'),
                  placeholder: 'VerifiedBuild',
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildEntrySection(int n) {
    return FoxyFormSection(
      title: '组 $n',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '语言',
                child: FoxyStringInput(
                  controller: viewModel.stringOf('lang$n'),
                  placeholder: 'lang$n',
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '几率',
                child: FoxyNumberInput<double>(
                  fieldController: viewModel.doubleOf('Probability$n'),
                  placeholder: 'Probability$n',
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Expanded(child: SizedBox()),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            Expanded(child: _fieldWithLocale('文本', 'text${n}_0', 'Text${n}_0')),
            Expanded(child: _fieldWithLocale('文本', 'text${n}_1', 'Text${n}_1')),
            Expanded(
              child: FoxyFormItem(
                label: '广播文本',
                child: FoxyEntityPicker(
                  delegate: FoxyEntityPickerDelegates.broadcastText,
                  fieldController: viewModel.broadcastOf(n),
                  placeholder: 'BroadcastTextID$n',
                ),
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            for (var i = 0; i < 6; i++)
              Expanded(
                child: FoxyFormItem(
                  label: '表演',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.emote,
                    fieldController: viewModel.emoteOf('em${n}_$i'),
                    placeholder: 'em${n}_$i',
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _fieldWithLocale(String label, String mainKey, String localeKey) {
    final expanded = _expandedLocales.contains(mainKey);
    final toggleBtn = ShadButton.ghost(
      height: 20,
      width: 20,
      padding: EdgeInsets.zero,
      onPressed: () {
        setState(() {
          if (expanded) {
            _expandedLocales.remove(mainKey);
          } else {
            _expandedLocales.add(mainKey);
          }
        });
      },
      child: Icon(LucideIcons.languages, size: 12),
    );
    final mainInput = Row(
      spacing: 4,
      children: [
        Expanded(
          child: FoxyStringInput(
            controller: viewModel.stringOf(mainKey),
            placeholder: mainKey,
          ),
        ),
        toggleBtn,
      ],
    );
    final children = <Widget>[mainInput];
    if (expanded) {
      children.add(
        FoxyStringInput(
          controller: viewModel.stringOf('locale.$localeKey'),
          placeholder: 'zhCN: $localeKey',
        ),
      );
    }
    return FoxyFormItem(
      label: label,
      child: Column(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
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
