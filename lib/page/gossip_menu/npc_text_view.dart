import 'package:flutter/material.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_detail_view_model.dart';
import 'package:foxy/page/gossip_menu/npc_text_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Tab 2：npc_text 主表 + npc_text_locale (zhCN)
class NpcTextView extends StatefulWidget {
  final GossipMenuDetailViewModel parentViewModel;

  const NpcTextView({super.key, required this.parentViewModel});

  @override
  State<NpcTextView> createState() => _NpcTextViewState();
}

class _NpcTextViewState extends State<NpcTextView> {
  final viewModel = GetIt.instance.get<NpcTextViewModel>();

  /// 本地 UI 状态：哪些 locale 输入框展开
  final _expandedLocales = <String>{};

  late final VoidCallback _disposer;

  @override
  void initState() {
    super.initState();
    viewModel.load(widget.parentViewModel.textId.value);
    _disposer = effect(() {
      final newTextId = widget.parentViewModel.textId.value;
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
      if (viewModel.loading.value) {
        return const Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator()),
        );
      }
      final cards = <Widget>[_buildMetaCard()];
      for (var n = 0; n < 8; n++) {
        cards.add(_buildEntryCard(n));
      }
      cards.add(_buildActions());
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(spacing: 16, children: cards),
      );
    });
  }

  Widget _buildMetaCard() {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(child: _field('ID', 'ID', viewModel.controllerOf('ID'))),
          Expanded(
            child: _field(
              'VerifiedBuild',
              'VerifiedBuild',
              viewModel.controllerOf('VerifiedBuild'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryCard(int n) {
    final children = <Widget>[];
    children.add(
      Row(
        spacing: 16,
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
        ],
      ),
    );
    children.add(
      Row(
        spacing: 16,
        children: [
          Expanded(child: _fieldWithLocale('文本', 'text${n}_0', 'Text${n}_0')),
          Expanded(child: _fieldWithLocale('文本', 'text${n}_1', 'Text${n}_1')),
          Expanded(
            child: _field(
              '广播文本',
              'BroadcastTextID$n',
              viewModel.controllerOf('BroadcastTextID$n'),
            ),
          ),
        ],
      ),
    );
    final emotes = <Widget>[];
    for (var i = 0; i < 6; i++) {
      emotes.add(
        Expanded(
          child: _field(
            '表演',
            'em${n}_$i',
            viewModel.controllerOf('em${n}_$i'),
          ),
        ),
      );
    }
    children.add(Row(spacing: 16, children: emotes));

    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('组 $n'), ...children],
      ),
    );
  }

  Widget _field(String label, String placeholder, TextEditingController c) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        ShadInput(controller: c, placeholder: Text(placeholder)),
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
    final mainInput = ShadInput(
      controller: viewModel.controllerOf(mainKey),
      placeholder: Text(mainKey),
      trailing: toggleBtn,
    );
    final children = <Widget>[Text(label), mainInput];
    if (expanded) {
      children.add(
        ShadInput(
          controller: viewModel.controllerOf('locale.$localeKey'),
          placeholder: Text('zhCN: $localeKey'),
        ),
      );
    }
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildActions() {
    final saveBtn = Watch((_) {
      return ShadButton(
        enabled: !viewModel.saving.value,
        onPressed: viewModel.onSave,
        child: Text(viewModel.saving.value ? '保存中...' : '保存'),
      );
    });
    final backBtn = ShadButton.outline(
      onPressed: widget.parentViewModel.pop,
      child: Text('返回'),
    );
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 8, children: [saveBtn, backBtn]),
    );
  }
}
