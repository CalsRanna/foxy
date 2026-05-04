import 'package:flutter/material.dart';
import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/repository/quest_offer_reward_locale_repository.dart';
import 'package:foxy/widget/locale_crud_dialog.dart';
import 'package:foxy/widget/locale_crud_view_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestOfferRewardLocaleSelector extends StatefulWidget {
  final int? questId;
  final TextEditingController? controller;
  final String? placeholder;
  final bool readOnly;
  final String title;

  const QuestOfferRewardLocaleSelector({
    super.key,
    this.questId,
    this.controller,
    this.placeholder,
    this.readOnly = false,
    required this.title,
  });

  @override
  State<QuestOfferRewardLocaleSelector> createState() =>
      _QuestOfferRewardLocaleSelectorState();
}

class _QuestOfferRewardLocaleSelectorState
    extends State<QuestOfferRewardLocaleSelector> {
  final repository = QuestOfferRewardLocaleRepository();

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: widget.controller,
      placeholder: Text(widget.placeholder ?? ''),
      readOnly: widget.readOnly,
      trailing: ShadButton.ghost(
        height: 20,
        width: 20,
        padding: EdgeInsets.zero,
        onPressed: _openLocaleDialog,
        child: Icon(LucideIcons.globe, size: 12),
      ),
    );
  }

  Future<void> _openLocaleDialog() async {
    if (widget.questId == null) return;
    final vm = LocaleCrudViewModel(
      entry: widget.questId!,
      fields: ['locale', 'rewardText'],
      fieldLabels: ['语言', '奖励文本'],
      onLoad: (questId) async {
        final locales = await repository.getQuestOfferRewardLocales(questId);
        return locales
            .map((e) => {'locale': e.locale, 'rewardText': e.rewardText})
            .toList();
      },
      onSave: (questId, data) async {
        final locales = data
            .map((d) => QuestOfferRewardLocaleEntity(
                  id: questId,
                  locale: d['locale'] ?? '',
                  rewardText: d['rewardText'] ?? '',
                ))
            .toList();
        await repository.replaceAll(questId, locales);
      },
    );
    await LocaleCrudDialog(
      title: widget.title,
      entry: widget.questId!,
      vm: vm,
    ).show(context);
    vm.dispose();
  }
}
