import 'package:flutter/material.dart';
import 'package:foxy/widget/form/field_controller.dart';
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
    // Rebuild the cached option widgets only when the source map changes.
    if (!identical(widget.options, oldWidget.options)) {
      _shadOptions = _buildOptions(widget.options);
    }
  }

  List<ShadOption<T>> _buildOptions(Map<T, String> options) => options.entries
      .map((e) => ShadOption(value: e.key, child: Text(e.value)))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ShadSelect<T>(
      controller: widget.controller.controller,
      options: _shadOptions,
      selectedOptionBuilder: (context, value) => Text(
        widget.options[value] ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      placeholder: widget.placeholder,
      enabled: widget.enabled,
      minWidth: widget.minWidth,
      maxHeight: widget.maxHeight,
    );
  }
}
