import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_detail_view_model.dart';
import 'package:foxy/page/gossip_menu/npc_text_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Tab 2：npc_text 主表 + npc_text_locale (zhCN)
class NpcTextView extends StatefulWidget {
  const NpcTextView({super.key});

  @override
  State<NpcTextView> createState() => _NpcTextViewState();
}

class _NpcTextViewState extends State<NpcTextView> {
  final viewModel = GetIt.instance.get<NpcTextViewModel>();
  final parentViewModel = GetIt.instance.get<GossipMenuDetailViewModel>();

  /// 本地 UI 状态：哪些 locale 输入框展开
  final _expandedLocales = <String>{};

  late final VoidCallback _disposer;

  @override
  void initState() {
    super.initState();
    viewModel.load(int.tryParse(parentViewModel.textIdController.text) ?? 0);
    _disposer = effect(() {
      final newTextId =
          int.tryParse(parentViewModel.textIdController.text) ?? 0;
      viewModel.load(newTextId);
    });
  }

  @override
  void dispose() {
    _disposer();
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
            Expanded(child: _field('编号', 'ID', viewModel.controllerOf('ID'))),
            Expanded(
              child: _field(
                'VerifiedBuild',
                'VerifiedBuild',
                viewModel.controllerOf('VerifiedBuild'),
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
              child: _field('语言', 'lang$n', viewModel.controllerOf('lang$n')),
            ),
            Expanded(
              child: _field(
                '几率',
                'Probability$n',
                viewModel.controllerOf('Probability$n'),
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
                placeholder: 'BroadcastTextID$n',
                child: FoxyEntityPicker(
                  delegate: FoxyEntityPickerDelegates.broadcastText,
                  controller: viewModel.broadcastControllerOf(n),
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
                  placeholder: 'em${n}_$i',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.emote,
                    controller: viewModel.emoteControllerOf('em${n}_$i'),
                    placeholder: 'em${n}_$i',
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _field(String label, String placeholder, TextEditingController c) {
    return FoxyFormItem(
      label: label,
      child: ShadInput(controller: c, placeholder: Text(placeholder)),
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
    final mainInput = ShadInput(
      controller: viewModel.controllerOf(mainKey),
      placeholder: Text(mainKey),
      trailing: toggleBtn,
    );
    final children = <Widget>[mainInput];
    if (expanded) {
      children.add(
        ShadInput(
          controller: viewModel.controllerOf('locale.$localeKey'),
          placeholder: Text('zhCN: $localeKey'),
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
          onPressed: parentViewModel.pop,
          child: const Text('取消'),
        ),
      ],
    );
  }
}
