import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// [ShadInput] 只读态的交互角色。
///
/// `shadcn_ui` 的 `readOnly` 只禁止编辑，不会自动改外观或鼠标；
/// Foxy 通过本工具统一补齐。
enum FoxyReadonlyInputRole {
  /// 纯展示（如主键 ID）：muted 外观 + 禁用光标。
  display,

  /// 文本不可手改，但整框可点开（若业务仍要用 muted 外观 + 手型）。
  ///
  /// 标志位选择器 [FoxyFlagPicker] 不走此角色：它是正常编辑入口，
  /// 外观与可编辑输入一致，仅用 `readOnly` 禁止手改格式串。
  interactive,
}

/// Foxy 表单输入框的统一只读样式 / 鼠标策略。
///
/// 可编辑时所有 getter 返回 `null`，让 [ShadInput] 走主题默认值。
///
/// ## 为什么必须用 [wrap] 包一层 [MouseRegion]
///
/// `ShadInput` 在 `readOnly: true` 时会对内部 `EditableText` 使用
/// `AbsorbPointer(absorbing: true)`，指针事件到不了 `EditableText`，
/// 因此传给 `ShadInput.mouseCursor` 的光标**不会生效**。
/// 必须在 `ShadInput` **外侧**用 [MouseRegion] 设置光标。
class FoxyReadonlyInput {
  const FoxyReadonlyInput._({
    required this.readOnly,
    required this.role,
    required this.style,
    required this.decoration,
    required this.mouseCursor,
    required this.showCursor,
  });

  final bool readOnly;
  final FoxyReadonlyInputRole role;
  final TextStyle? style;
  final ShadDecoration? decoration;
  final MouseCursor? mouseCursor;
  final bool? showCursor;

  /// 根据 [readOnly] 与 [role] 解析样式。
  ///
  /// [readOnly] 为 false 时返回空配置（全部为 null）。
  factory FoxyReadonlyInput.resolve(
    BuildContext context, {
    required bool readOnly,
    FoxyReadonlyInputRole role = FoxyReadonlyInputRole.display,
  }) {
    if (!readOnly) {
      return const FoxyReadonlyInput._(
        readOnly: false,
        role: FoxyReadonlyInputRole.display,
        style: null,
        decoration: null,
        mouseCursor: null,
        showCursor: null,
      );
    }

    final theme = ShadTheme.of(context);
    return FoxyReadonlyInput._(
      readOnly: true,
      role: role,
      style: TextStyle(color: theme.colorScheme.mutedForeground),
      decoration: ShadDecoration(color: theme.colorScheme.muted),
      mouseCursor: role == FoxyReadonlyInputRole.interactive
          ? SystemMouseCursors.click
          : SystemMouseCursors.forbidden,
      // 只读不显示闪烁插入符；null 交给 Flutter 默认（可编辑时）
      showCursor: false,
    );
  }

  /// 将只读鼠标光标应用到 [child]（通常是 [ShadInput]）外侧。
  ///
  /// 可编辑时原样返回；只读时包一层 [MouseRegion]。
  Widget wrap(Widget child) {
    final cursor = mouseCursor;
    if (!readOnly || cursor == null) return child;
    return MouseRegion(cursor: cursor, child: child);
  }
}
