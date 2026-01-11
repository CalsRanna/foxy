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
  late final CreatureTemplateAddonViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.instance.get<CreatureTemplateAddonViewModel>();
    _viewModel.init(entryId: widget.entry);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    try {
      await _viewModel.save();
      if (mounted) {
        ShadToaster.of(
          context,
        ).show(ShadToast(title: Text('保存成功'), description: Text('模板补充数据已保存')));
      }
    } catch (e) {
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: Text('保存失败'),
            description: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      // 监听数据变化，当数据更新时自动更新控件
      final addonData = _viewModel.addon.value;
      _viewModel.initControllers(addonData);

      if (_viewModel.loading.value) {
        return Center(child: CircularProgressIndicator());
      }

      final entryInput = FormItem(
        controller: _viewModel.entry.value == 0
            ? TextEditingController(text: widget.entry.toString())
            : TextEditingController(text: _viewModel.entry.value.toString()),
        label: '编号',
        placeholder: 'entry',
        readOnly: true,
      );
      final pathIdInput = FormItem(
        controller: _viewModel.pathIdController,
        label: '路径ID',
        placeholder: 'path_id',
      );
      final mountInput = FormItem(
        controller: _viewModel.mountController,
        label: '坐骑编号',
        placeholder: 'mount',
      );
      final emoteInput = FormItem(
        controller: _viewModel.emoteController,
        label: '表情',
        placeholder: 'emote',
      );
      final bytes1Input = FormItem(
        controller: _viewModel.bytes1Controller,
        label: '覆盖标识1',
        placeholder: 'bytes1',
      );
      final bytes2Input = FormItem(
        controller: _viewModel.bytes2Controller,
        label: '覆盖标识2',
        placeholder: 'bytes2',
      );
      final aurasInput = FormItem(
        controller: _viewModel.aurasController,
        label: '光环列表',
        placeholder: 'auras',
      );
      final isLargeInput = FormItem(
        controller: _viewModel.isLargeController,
        label: '更大可视范围',
        placeholder: 'isLarge (0或1)',
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
                      Expanded(child: aurasInput),
                      Expanded(child: isLargeInput),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              spacing: 8,
              children: [
                ShadButton(
                  onPressed: _viewModel.saving.value ? null : _save,
                  child: _viewModel.saving.value
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text('保存'),
                ),
                ShadButton.ghost(
                  onPressed: () => Navigator.of(context).pop(),
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
