import 'package:flutter/material.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/widget/database_locale_changes.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/dbc_locale_field_editor.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:foxy/widget/foxy_locale_crud_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 多语言编辑器入口的共同抽象。
///
/// 普通数据库 locale 分表与 DBC locstring 共用输入框 + 地球按钮入口，
/// 但使用独立的强类型 Delegate 与编辑器主体，不在同一主体内堆叠条件分支。
sealed class FoxyLocaleEditorDelegate {
  const FoxyLocaleEditorDelegate();
}

/// 普通数据库 `*_locale` 分表编辑契约：动态语言行，可添加/删除。
final class DatabaseLocaleEditorDelegate extends FoxyLocaleEditorDelegate {
  /// 多语言表的字段名（对应 entity 列），首项约定为 'locale'。
  final List<String> fields;

  /// 字段在弹窗表头中的显示文案，长度与 [fields] 一致。
  final List<String> fieldLabels;

  /// 加载指定 entry 的多语言数据。
  final Future<List<DatabaseLocaleRow>> Function(int entry) onLoad;

  /// 保存指定 entry 的多语言变更。
  final Future<void> Function(int entry, DatabaseLocaleChanges changes) onSave;

  const DatabaseLocaleEditorDelegate({
    required this.fields,
    required this.fieldLabels,
    required this.onLoad,
    required this.onSave,
  }) : assert(
         fields.length == fieldLabels.length,
         'fields 与 fieldLabels 长度必须一致',
       );
}

/// 兼容旧名称。
typedef FoxyLocalePickerDelegate = DatabaseLocaleEditorDelegate;

/// DBC 宽表单字段本地化编辑契约：固定 16 行，局部更新主记录。
final class DbcLocaleFieldEditorDelegate extends FoxyLocaleEditorDelegate {
  final DbcLocaleFieldDefinition field;
  final Future<List<DbcLocaleFieldValue>> Function(int entry) onLoad;
  final Future<void> Function(int entry, List<DbcLocaleFieldValue> values)
  onSave;

  const DbcLocaleFieldEditorDelegate({
    required this.field,
    required this.onLoad,
    required this.onSave,
  });
}

/// 多语言字段选择器：ShadInput + 地球按钮。
///
/// 根据 [delegate] 类型分派到 [DatabaseLocaleEditor] 或 [DbcLocaleFieldEditor]。
/// 新建记录 [entry] 为 null 时禁用地球按钮。
class FoxyLocalePicker extends StatefulWidget {
  /// 所属记录的主键。为 null 时禁用地球按钮。
  final int? entry;

  /// 主输入框的 controller（由 ViewModel 持有，回填主语言值）。
  final StringFieldController controller;

  /// 多语言编辑弹窗的标题。
  final String title;

  /// 主输入框的 placeholder。
  final String? placeholder;

  /// 主输入框是否只读。
  final bool readOnly;

  /// 数据/持久化配置。
  final FoxyLocaleEditorDelegate delegate;

  /// DBC 字段保存成功后回调，用于同步 ViewModel Entity 与主语言 Controller。
  ///
  /// 仅在 [DbcLocaleFieldEditorDelegate] 保存成功时调用。
  final void Function(List<DbcLocaleFieldValue> values)? onSaved;

  const FoxyLocalePicker({
    super.key,
    required this.entry,
    required this.controller,
    required this.title,
    required this.delegate,
    this.placeholder,
    this.readOnly = false,
    this.onSaved,
  });

  @override
  State<FoxyLocalePicker> createState() => _FoxyLocalePickerState();
}

class _FoxyLocalePickerState extends State<FoxyLocalePicker> {
  @override
  Widget build(BuildContext context) {
    final canOpen = widget.entry != null;
    // 主语言可编辑时走默认样式；只读时用 display 外观（地球按钮仍可打开多语言）。
    final readonly = FoxyReadonlyInput.resolve(
      context,
      readOnly: widget.readOnly,
    );
    return readonly.wrap(
      ShadInput(
        controller: widget.controller.controller,
        placeholder: Text(widget.placeholder ?? ''),
        readOnly: widget.readOnly,
        style: readonly.style,
        decoration: readonly.decoration,
        mouseCursor: readonly.mouseCursor,
        showCursor: readonly.showCursor,
        trailing: ShadButton.ghost(
          height: 20,
          width: 20,
          padding: EdgeInsets.zero,
          enabled: canOpen,
          onPressed: canOpen ? _openLocaleDialog : null,
          child: Icon(LucideIcons.globe, size: 12),
        ),
      ),
    );
  }

  Future<void> _openLocaleDialog() async {
    final entry = widget.entry;
    if (entry == null) return;

    switch (widget.delegate) {
      case DatabaseLocaleEditorDelegate(
        :final fields,
        :final fieldLabels,
        :final onLoad,
        :final onSave,
      ):
        await DatabaseLocaleEditor.show(
          context,
          title: widget.title,
          entry: entry,
          fields: fields,
          fieldLabels: fieldLabels,
          onLoad: () => onLoad(entry),
          onSave: (changes) => onSave(entry, changes),
        );
      case DbcLocaleFieldEditorDelegate(
        :final field,
        :final onLoad,
        :final onSave,
      ):
        final saved = await DbcLocaleFieldEditor.show(
          context,
          title: widget.title,
          entry: entry,
          field: field,
          // 合并主输入框草稿：避免「主框改了未保存 → 弹窗只改其它语言
          // → 把库里旧 zhCN 写回并冲掉主框」的丢失。
          onLoad: () async {
            final loaded = await onLoad(entry);
            return loaded.withPrimaryDraft(widget.controller.collect());
          },
          onSave: (values) => onSave(entry, values),
        );
        if (saved != null) {
          widget.onSaved?.call(saved);
        }
    }
  }
}
