import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_locale_crud_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 每个多语言实体提供的加载/保存配置。纯数据 + 闭包，不持有可变状态，
/// 因此同一实例可被多个 [FoxyLocalePicker] 共享（同一 entity 的多个字段
/// 复用同一 delegate，仅 [FoxyLocalePicker.title] 不同）。
///
/// 对齐 [EntityPickerDelegate] 范式：数据契约集中在 delegate，调用点只
/// 提供 controller/title/placeholder 等展示参数。
class FoxyLocalePickerDelegate {
  /// 多语言表的字段名（对应 entity 列），首项约定为 'locale'。
  final List<String> fields;

  /// 字段在弹窗表头中的显示文案，长度与 [fields] 一致。
  final List<String> fieldLabels;

  /// 加载指定 entry 的多语言数据，返回 List<Map>（键为 [fields]）。
  final Future<List<Map<String, String>>> Function(int entry) onLoad;

  /// 保存指定 entry 的多语言数据（data 键为 [fields]）。
  final Future<void> Function(int entry, List<Map<String, String>> data) onSave;

  const FoxyLocalePickerDelegate({
    required this.fields,
    required this.fieldLabels,
    required this.onLoad,
    required this.onSave,
  }) : assert(
         fields.length == fieldLabels.length,
         'fields 与 fieldLabels 长度必须一致',
       );
}

/// 多语言字段选择器：ShadInput + 地球按钮，点击打开 [FoxyLocaleCrudDialog]
/// 编辑该 entry 的多语言数据。状态完全由弹窗内部 setState 管理，无 signals。
///
/// 与 [FoxyEntityPicker] 对齐：通过 [delegate] 注入数据/持久化逻辑，
/// 调用点只提供展示参数。收敛各模块散落的 `<Module>LocaleXxxSelector`。
class FoxyLocalePicker extends StatefulWidget {
  /// 所属记录的主键（如 creature entry、quest id）。为 null 时禁用按钮。
  final int? entry;

  /// 主输入框的 controller（通常由 ViewModel 持有，回填主语言值）。
  final TextEditingController? controller;

  /// 多语言编辑弹窗的标题。
  final String title;

  /// 主输入框的 placeholder。
  final String? placeholder;

  /// 主输入框是否只读。
  final bool readOnly;

  /// 数据/持久化配置。
  final FoxyLocalePickerDelegate delegate;

  const FoxyLocalePicker({
    super.key,
    required this.entry,
    required this.controller,
    required this.title,
    required this.delegate,
    this.placeholder,
    this.readOnly = false,
  });

  @override
  State<FoxyLocalePicker> createState() => _FoxyLocalePickerState();
}

class _FoxyLocalePickerState extends State<FoxyLocalePicker> {
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
    final entry = widget.entry;
    if (entry == null) return;
    await FoxyLocaleCrudDialog.show(
      context,
      title: widget.title,
      entry: entry,
      fields: widget.delegate.fields,
      fieldLabels: widget.delegate.fieldLabels,
      onLoad: () => widget.delegate.onLoad(entry),
      onSave: (data) => widget.delegate.onSave(entry, data),
    );
  }
}
