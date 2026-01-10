import 'package:flutter/material.dart';
import 'package:foxy/model/creature_template_addon.dart';
import 'package:foxy/repository/creature_template_addon_repository.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 生物模板附加数据Tab
class CreatureTemplateAddonTab extends StatefulWidget {
  final int entry;

  const CreatureTemplateAddonTab({super.key, required this.entry});

  @override
  State<CreatureTemplateAddonTab> createState() =>
      _CreatureTemplateAddonTabState();
}

class _CreatureTemplateAddonTabState extends State<CreatureTemplateAddonTab> {
  final _pathIdController = TextEditingController();
  final _mountController = TextEditingController();
  final _emoteController = TextEditingController();
  final _visibilityDistanceTypeController = TextEditingController();
  final _aurasController = TextEditingController();

  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _pathIdController.dispose();
    _mountController.dispose();
    _emoteController.dispose();
    _visibilityDistanceTypeController.dispose();
    _aurasController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final repository = CreatureTemplateAddonRepository();
      final addon = await repository.find(widget.entry);
      if (addon != null && mounted) {
        _pathIdController.text = addon.pathId.toString();
        _mountController.text = addon.mount.toString();
        _emoteController.text = addon.emote.toString();
        _visibilityDistanceTypeController.text =
            addon.visibilityDistanceType.toString();
        _aurasController.text = addon.auras;
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final addon = CreatureTemplateAddon();
      addon.entry = widget.entry;
      addon.pathId = int.tryParse(_pathIdController.text) ?? 0;
      addon.mount = int.tryParse(_mountController.text) ?? 0;
      addon.emote = int.tryParse(_emoteController.text) ?? 0;
      addon.visibilityDistanceType =
          int.tryParse(_visibilityDistanceTypeController.text) ?? 0;
      addon.auras = _aurasController.text;

      final repository = CreatureTemplateAddonRepository();
      await repository.save(addon);

      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text('保存成功'),
            description: Text('模板补充数据已保存'),
          ),
        );
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
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }

    final pathIdInput = FormItem(
      controller: _pathIdController,
      label: '路径ID',
      placeholder: 'path_id',
    );
    final mountInput = FormItem(
      controller: _mountController,
      label: '坐骑',
      placeholder: 'mount',
    );
    final emoteInput = FormItem(
      controller: _emoteController,
      label: '表情',
      placeholder: 'emote',
    );
    final visibilityDistanceTypeInput = FormItem(
      controller: _visibilityDistanceTypeController,
      label: '可见距离类型',
      placeholder: 'visibilityDistanceType',
    );
    final aurasInput = FormItem(
      controller: _aurasController,
      label: '光环',
      placeholder: 'auras (多个用空格分隔)',
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Expanded(child: pathIdInput),
                    Expanded(child: mountInput),
                    Expanded(child: emoteInput),
                    Expanded(child: visibilityDistanceTypeInput),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(flex: 2, child: aurasInput),
                    Expanded(child: SizedBox()),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          ShadButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text('保存'),
          ),
        ],
      ),
    );
  }
}
