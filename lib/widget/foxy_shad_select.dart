import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// A wrapper around [ShadSelect] that provides consistent styling and behavior.
///
/// This widget automatically:
/// - Converts a Map to ShadOptions
/// - Applies maxLines and overflow to selected options
/// - Provides a consistent look across the application
class FoxyShadSelect<T> extends StatelessWidget {
  /// The controller for the select widget
  final ShadSelectController<T> controller;

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
  Widget build(BuildContext context) {
    final shadOptions = options.entries
        .map((e) => ShadOption(value: e.key, child: Text(e.value)))
        .toList();

    return ShadSelect<T>(
      controller: controller,
      options: shadOptions,
      selectedOptionBuilder: (context, value) => Text(
        options[value] ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      placeholder: placeholder,
      enabled: enabled,
      minWidth: minWidth,
      maxHeight: maxHeight,
    );
  }
}
