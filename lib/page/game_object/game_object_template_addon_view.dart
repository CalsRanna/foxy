import 'package:flutter/material.dart';
import 'package:foxy/page/game_object/game_object_template_addon_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class GameObjectTemplateAddonView extends StatefulWidget {
  final int gameObjectId;

  const GameObjectTemplateAddonView({super.key, required this.gameObjectId});

  @override
  State<GameObjectTemplateAddonView> createState() =>
      _GameObjectTemplateAddonViewState();
}

class _GameObjectTemplateAddonViewState
    extends State<GameObjectTemplateAddonView> {
  final viewModel = GetIt.instance.get<GameObjectTemplateAddonViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(gameObjectId: widget.gameObjectId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entryInput = FormItem(
      label: '编号',
      placeholder: 'entry',
      child: FoxyNumberInput<int>(
        value: widget.gameObjectId,
        onChanged: (_) {},
        readOnly: true,
      ),
    );
    return Watch((_) {
      final factionInput = FormItem(
        label: '阵营',
        placeholder: 'faction',
        child: FoxyNumberInput<int>(
          value: viewModel.faction.value,
          onChanged: (v) => viewModel.faction.value = v,
        ),
      );
      final flagsInput = FormItem(
        label: '标志位',
        placeholder: 'flags',
        child: FoxyNumberInput<int>(
          value: viewModel.flags.value,
          onChanged: (v) => viewModel.flags.value = v,
        ),
      );
      final minGoldInput = FormItem(
        label: '最小金钱',
        placeholder: 'mingold',
        child: FoxyNumberInput<int>(
          value: viewModel.minGold.value,
          onChanged: (v) => viewModel.minGold.value = v,
        ),
      );
      final maxGoldInput = FormItem(
        label: '最大金钱',
        placeholder: 'maxgold',
        child: FoxyNumberInput<int>(
          value: viewModel.maxGold.value,
          onChanged: (v) => viewModel.maxGold.value = v,
        ),
      );

      return SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            ShadCard(
              padding: EdgeInsets.all(20),
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(child: entryInput),
                      Expanded(child: factionInput),
                      Expanded(child: flagsInput),
                      Expanded(child: minGoldInput),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(child: maxGoldInput),
                      Expanded(child: SizedBox()),
                      Expanded(child: SizedBox()),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              spacing: 8,
              children: [
                ShadButton(
                  onPressed: () => viewModel.save(context),
                  child: Text('保存'),
                ),
                ShadButton.ghost(
                  onPressed: () => viewModel.pop(),
                  child: Text('取消'),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
