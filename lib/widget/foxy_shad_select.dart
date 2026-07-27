import 'package:flutter/material.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// A wrapper around [ShadSelect] that provides consistent styling and behavior.
///
/// This widget automatically:
/// - Converts a Map to ShadOptions
/// - Applies maxLines and overflow to selected options
/// - Provides a consistent look across the application
///
/// The [ShadOption] list is built once and cached; it is only rebuilt when the
/// [options] map identity changes. Call sites pass compile-time `const` maps
/// (e.g. `kItemStatTypeOptions`), so without this cache every rebuild would
/// re-allocate the entire option widget list — wasteful on detail forms that
/// hold dozens of selects.
class FoxyShadSelect<T> extends StatefulWidget {
  final SelectFieldController<T> controller;

  /// The options map where key is the value and value is the display text
  final Map<T, String> options;

  /// The placeholder widget to show when no option is selected
  final Widget placeholder;

  /// Whether the select is enabled (default: true)
  final bool enabled;

  /// Optional minimum width for the select dropdown
  final double? minWidth;

  /// Optional maximum height for the select dropdown
  final double? maxHeight;

  const FoxyShadSelect({
    super.key,
    required this.controller,
    required this.options,
    required this.placeholder,
    this.enabled = true,
    this.minWidth,
    this.maxHeight,
  });

  @override
  State<FoxyShadSelect<T>> createState() => _FoxyShadSelectState<T>();
}

class _FoxyShadSelectState<T> extends State<FoxyShadSelect<T>> {
  late List<ShadOption<T>> _shadOptions;

  @override
  void initState() {
    super.initState();
    _shadOptions = _buildOptions(widget.options);
  }

  @override
  void didUpdateWidget(FoxyShadSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(widget.options, oldWidget.options)) {
      _shadOptions = _buildOptions(widget.options);
    }
  }

  List<ShadOption<T>> _buildOptions(Map<T, String> options) => options.entries
      .map((entry) => ShadOption(value: entry.key, child: Text(entry.value)))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ShadSelect<T>(
      controller: widget.controller.controller,
      options: _shadOptions,
      selectedOptionBuilder: (context, value) => Text(
        widget.options[value] ?? value.toString(),
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
      placeholder: widget.placeholder,
      enabled: widget.enabled,
      minWidth: widget.minWidth,
      maxHeight: widget.maxHeight,
    );
  }
}

/// 可手工输入任意整数，也可从已核验枚举中选值。
///
/// 用于同时接受普通枚举和负数引用 ID 的数据库列；枚举表不伪造当前数据中
/// 尚未出现的引用编号。
class FoxyIntEnumInput extends StatelessWidget {
  final IntFieldController controller;
  final Map<int, String> options;
  final String placeholder;
  final String title;
  final bool readOnly;

  const FoxyIntEnumInput({
    super.key,
    required this.controller,
    required this.options,
    required this.placeholder,
    required this.title,
    this.readOnly = false,
  });

  Future<void> _openDialog(BuildContext context) async {
    if (readOnly) return;
    final result = await showFoxyDialog<int>(
      context: context,
      builder: (context) => _IntEnumDialog(
        title: title,
        options: options,
        currentValue: controller.collect(),
      ),
    );
    if (result != null) controller.init(result);
  }

  @override
  Widget build(BuildContext context) {
    final readonly = FoxyReadonlyInput.resolve(context, readOnly: readOnly);
    return readonly.wrap(
      ShadInput(
        controller: controller.controller,
        placeholder: Text(placeholder),
        readOnly: readOnly,
        style: readonly.style,
        decoration: readonly.decoration,
        mouseCursor: readonly.mouseCursor,
        showCursor: readonly.showCursor,
        trailing: readOnly
            ? null
            : ShadButton.ghost(
                height: 20,
                width: 20,
                padding: EdgeInsets.zero,
                onPressed: () => _openDialog(context),
                child: const Icon(LucideIcons.list, size: 12),
              ),
      ),
    );
  }
}

class _IntEnumDialog extends StatelessWidget {
  final String title;
  final Map<int, String> options;
  final int currentValue;

  const _IntEnumDialog({
    required this.title,
    required this.options,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text(title),
      constraints: const BoxConstraints(maxWidth: 520),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
      ],
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 440),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: options.length,
          separatorBuilder: (_, _) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            final entry = options.entries.elementAt(index);
            final selected = entry.key == currentValue;
            return ShadButton.raw(
              variant: selected
                  ? ShadButtonVariant.secondary
                  : ShadButtonVariant.ghost,
              onPressed: () => Navigator.of(context).pop(entry.key),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('${entry.key}  ${entry.value}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
