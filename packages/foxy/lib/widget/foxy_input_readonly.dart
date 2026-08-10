import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Unified read-only styling / mouse strategy for Foxy form inputs.
///
/// When editable, all getters return `null` so [ShadInput] falls back to
/// theme defaults.
///
/// ## Why [wrap] must add a [MouseRegion]
///
/// With `readOnly: true`, `ShadInput` wraps its inner `EditableText` in
/// `AbsorbPointer(absorbing: true)`, so pointer events never reach
/// `EditableText` and the cursor passed to `ShadInput.mouseCursor` does
/// **not** take effect. The cursor must be set with a [MouseRegion]
/// **outside** the `ShadInput`.
class FoxyReadonlyInput {
  final bool readOnly;

  final FoxyReadonlyInputRole role;
  final TextStyle? style;
  final ShadDecoration? decoration;
  final MouseCursor? mouseCursor;
  final bool? showCursor;

  /// Resolves the style from [readOnly] and [role].
  ///
  /// Returns an empty config (all null) when [readOnly] is false.
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
      // Read-only hides the blinking caret; null defers to Flutter's
      // default (when editable)
      showCursor: false,
    );
  }

  const FoxyReadonlyInput._({
    required this.readOnly,
    required this.role,
    required this.style,
    required this.decoration,
    required this.mouseCursor,
    required this.showCursor,
  });

  /// Applies the read-only mouse cursor outside [child] (usually a
  /// [ShadInput]).
  ///
  /// Returns [child] unchanged when editable; wraps it in a [MouseRegion]
  /// when read-only.
  Widget wrap(Widget child) {
    final cursor = mouseCursor;
    if (!readOnly || cursor == null) return child;
    return MouseRegion(cursor: cursor, child: child);
  }
}

/// Interaction roles for the [ShadInput] read-only state.
///
/// `shadcn_ui`'s `readOnly` only blocks editing; it does not change the
/// look or cursor. Foxy fills the gap uniformly through this utility.
enum FoxyReadonlyInputRole {
  /// Pure display (e.g. primary-key ID): muted look + disabled cursor.
  display,

  /// Text is not hand-editable, but the whole box opens on click (when the
  /// business still wants muted look + hand cursor).
  ///
  /// The flag picker [FoxyFlagPicker] does not use this role: it is a
  /// normal edit entry whose look matches editable inputs; `readOnly` only
  /// prevents hand-editing the format string.
  interactive,
}
