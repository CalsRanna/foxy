import 'package:flutter/material.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// A wrapper around [ShadSelect.withSearch] that provides consistent
/// styling, behavior, and option search.
///
/// This widget automatically:
/// - Converts a Map to ShadOptions
/// - Applies maxLines and overflow to selected options
/// - Provides a search input that filters options by display text or value
/// - Provides a consistent look across the application
///
/// The [ShadOption] list is built once and cached; it is only rebuilt when the
/// [options] map identity changes. Call sites pass compile-time `const` maps
/// (e.g. `ItemEnums.itemStatTypeOptions`), so without this cache every rebuild would
/// re-allocate the entire option widget list — wasteful on detail forms that
/// hold dozens of selects. The filtered list is likewise cached and only
/// recomputed when the search query changes.
class FoxyShadSelect<T> extends StatefulWidget {
  final SelectFieldController<T> controller;

  /// The options map where key is the value and value is the display text
  final Map<T, String> options;

  /// The placeholder text to show when no option is selected
  final String? placeholder;

  /// Optional minimum width for the select dropdown
  final double? minWidth;

  /// Optional maximum height for the select dropdown
  final double? maxHeight;

  /// Optional placeholder for the search input inside the dropdown
  final Widget? searchPlaceholder;

  const FoxyShadSelect({
    super.key,
    required this.controller,
    required this.options,
    this.placeholder,
    this.minWidth,
    this.maxHeight,
    this.searchPlaceholder,
  });

  @override
  State<FoxyShadSelect<T>> createState() => _FoxyShadSelectState<T>();
}

class _FoxyShadSelectState<T> extends State<FoxyShadSelect<T>> {
  late List<ShadOption<T>> _allOptions;
  late List<ShadOption<T>> _filteredOptions;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return ShadSelect<T>.withSearch(
      controller: widget.controller.controller,
      options: _filteredOptions,
      selectedOptionBuilder: (context, value) => Text(
        widget.options[value] ?? value.toString(),
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
      placeholder: Text(widget.placeholder ?? ''),
      minWidth: widget.minWidth,
      maxHeight: widget.maxHeight,
      onSearchChanged: _onSearchChanged,
      searchPlaceholder: widget.searchPlaceholder ?? const Text('搜索名称或值'),
      footer: _filteredOptions.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                '无匹配选项',
                textAlign: TextAlign.center,
                style: ShadTheme.of(context).textTheme.muted,
              ),
            )
          : null,
    );
  }

  @override
  void didUpdateWidget(FoxyShadSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(widget.options, oldWidget.options)) {
      _allOptions = _buildOptions(widget.options);
      _filteredOptions = _filterOptions(_query);
    }
  }

  @override
  void initState() {
    super.initState();
    _allOptions = _buildOptions(widget.options);
    _filteredOptions = _allOptions;
  }

  List<ShadOption<T>> _buildOptions(Map<T, String> options) => options.entries
      .map((entry) => ShadOption(value: entry.key, child: Text(entry.value)))
      .toList();

  /// Filters options by substring match against the display text or the
  /// value's string form, case-insensitively.
  List<ShadOption<T>> _filterOptions(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return _allOptions;
    return [
      for (final entry in widget.options.entries)
        if (entry.value.toLowerCase().contains(q) ||
            entry.key.toString().toLowerCase().contains(q))
          ShadOption(value: entry.key, child: Text(entry.value)),
    ];
  }

  void _onSearchChanged(String query) {
    setState(() {
      _query = query;
      _filteredOptions = _filterOptions(query);
    });
  }
}
