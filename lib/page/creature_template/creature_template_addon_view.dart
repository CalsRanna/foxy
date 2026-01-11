import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_addon_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 生物模板附加数据Tab
class CreatureTemplateAddonView extends StatefulWidget {
  final int entry;

  const CreatureTemplateAddonView({super.key, required this.entry});

  @override
  State<CreatureTemplateAddonView> createState() =>
      _CreatureTemplateAddonViewState();
}

class _CreatureTemplateAddonViewState extends State<CreatureTemplateAddonView> {
  final viewModel = GetIt.instance.get<CreatureTemplateAddonViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(entryId: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      // 监听数据变化，当数据更新时自动更新控件
      final addonData = viewModel.addon.value;
      viewModel.initControllers(addonData);

      if (viewModel.loading.value) {
        return Center(child: CircularProgressIndicator());
      }

      final entryInput = FormItem(
        controller: viewModel.entry.value == 0
            ? TextEditingController(text: widget.entry.toString())
            : TextEditingController(text: viewModel.entry.value.toString()),
        label: '编号',
        placeholder: 'entry',
        readOnly: true,
      );
      final pathIdInput = FormItem(
        controller: viewModel.pathIdController,
        label: '路径ID',
        placeholder: 'path_id',
      );
      final mountInput = FormItem(
        controller: viewModel.mountController,
        label: '坐骑编号',
        placeholder: 'mount',
      );
      final emoteInput = FormItem(
        controller: viewModel.emoteController,
        label: '表情',
        placeholder: 'emote',
      );
      final bytes1Input = FormItem(
        controller: viewModel.bytes1Controller,
        label: '覆盖标识1',
        placeholder: 'bytes1',
      );
      final bytes2Input = FormItem(
        controller: viewModel.bytes2Controller,
        label: '覆盖标识2',
        placeholder: 'bytes2',
      );
      final aurasInput = FormItem(
        controller: viewModel.aurasController,
        label: '光环列表',
        placeholder: 'auras',
      );
      final visibilityDistanceTypeInput = FormItem(
        controller: viewModel.visibilityDistanceTypeController,
        label: '可见距离类型',
        placeholder: 'visibilityDistanceType',
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
                      Expanded(child: pathIdInput),
                      Expanded(child: mountInput),
                      Expanded(child: emoteInput),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(child: bytes1Input),
                      Expanded(child: bytes2Input),
                      Expanded(child: visibilityDistanceTypeInput),
                      Expanded(child: aurasInput),
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
