import 'package:flutter/material.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Signed-route picker: single input + search button; the dialog routes by
/// the sign of the input value to the matching data source.
///
/// Encoding convention: positive → [positiveSource] (e.g. creatures),
/// negative → [negativeSource] (e.g. game objects). The dialog is a
/// standard paginated table with no type switching. The input shows the
/// encoded value itself (sign included).
class FoxySignedEntityPicker extends StatefulWidget {
  final IntFieldController controller;
  final SignedEntitySource positiveSource;
  final SignedEntitySource negativeSource;
  final String? placeholder;

  const FoxySignedEntityPicker({
    super.key,
    required this.controller,
    required this.positiveSource,
    required this.negativeSource,
    this.placeholder,
  });

  @override
  State<FoxySignedEntityPicker> createState() => _FoxySignedEntityPickerState();
}

class _FoxySignedEntityPickerState extends State<FoxySignedEntityPicker> {
  @override
  Widget build(BuildContext context) {
    final readonly = FoxyReadonlyInput.resolve(context, readOnly: false);
    return readonly.wrap(
      ShadInput(
        controller: widget.controller.controller,
        placeholder: Text(widget.placeholder ?? ''),
        trailing: ShadButton.ghost(
          height: 20,
          width: 20,
          padding: EdgeInsets.zero,
          onPressed: _openDialog,
          child: Icon(LucideIcons.search, size: 12),
        ),
      ),
    );
  }

  Future<void> _openDialog() async {
    // The input accepts free text; invalid text makes collect() throw
    // FormatException. Catch it and prompt the user instead of letting the
    // search button silently fail.
    final int currentValue;
    try {
      currentValue = widget.controller.collect();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error(foxyErrorMessage(error));
      return;
    }
    if (!mounted) return;
    final result = await showFoxyDialog<int>(
      context: context,
      builder: (context) => _SignedEntityDialog(
        positiveSource: widget.positiveSource,
        negativeSource: widget.negativeSource,
        initialValue: currentValue,
      ),
    );
    if (result != null) {
      widget.controller.init(result);
    }
  }
}

/// A paginated row record.
class SignedEntityBrief {
  final int id;
  final String name;

  const SignedEntityBrief({required this.id, required this.name});
}

/// One side's data source for the signed-route picker: pure data + query
/// closures, shareable by multiple pickers.
class SignedEntitySource {
  final String title;
  final String errorLabel;
  final Future<List<SignedEntityBrief>> Function(
    int page,
    String id,
    String name,
  )
  fetch;
  final Future<int> Function(String id, String name) count;

  const SignedEntitySource({
    required this.title,
    required this.errorLabel,
    required this.fetch,
    required this.count,
  });
}

/// Built-in data sources: creatures / game objects / quest sorts / quest
/// areas.
class SignedEntitySources {
  static final creature = SignedEntitySource(
    title: '生物模板',
    errorLabel: '搜索生物模板失败',
    fetch: (page, id, name) async {
      final repo = GetIt.instance.get<CreatureTemplateRepository>();
      final items = await repo.getBriefCreatureTemplates(
        page: page,
        filter: CreatureTemplateFilter(entry: id, name: name),
      );
      return items
          .map((e) => SignedEntityBrief(id: e.entry, name: e.displayName))
          .toList();
    },
    count: (id, name) =>
        GetIt.instance.get<CreatureTemplateRepository>().countCreatureTemplates(
          filter: CreatureTemplateFilter(entry: id, name: name),
        ),
  );

  static final gameObject = SignedEntitySource(
    title: '游戏对象模板',
    errorLabel: '搜索游戏对象模板失败',
    fetch: (page, id, name) async {
      final repo = GetIt.instance.get<GameObjectTemplateRepository>();
      final items = await repo.getBriefGameObjectTemplates(
        page: page,
        filter: GameObjectTemplateFilter(entry: id, name: name),
      );
      return items
          .map((e) => SignedEntityBrief(id: e.entry, name: e.displayName))
          .toList();
    },
    count: (id, name) => GetIt.instance
        .get<GameObjectTemplateRepository>()
        .countGameObjectTemplates(
          filter: GameObjectTemplateFilter(entry: id, name: name),
        ),
  );

  static final questSort = SignedEntitySource(
    title: '任务排序',
    errorLabel: '搜索任务排序失败',
    fetch: (page, id, name) async {
      final repo = GetIt.instance.get<QuestSortRepository>();
      final items = await repo.getBriefQuestSorts(
        filter: QuestSortFilter(id: id, name: name),
        page: page,
      );
      return items
          .map((e) => SignedEntityBrief(id: e.id, name: e.sortNameLangZhCN))
          .toList();
    },
    count: (id, name) =>
        GetIt.instance.get<QuestSortRepository>().countQuestSorts(
          filter: QuestSortFilter(id: id, name: name),
        ),
  );

  static final areaTable = SignedEntitySource(
    title: '区域',
    errorLabel: '搜索区域失败',
    fetch: (page, id, name) async {
      final repo = GetIt.instance.get<AreaTableRepository>();
      final items = await repo.getBriefAreaTables(
        filter: AreaTableFilter(id: id, name: name),
        page: page,
      );
      return items
          .map((e) => SignedEntityBrief(id: e.id, name: e.areaNameLangZhCN))
          .toList();
    },
    count: (id, name) =>
        GetIt.instance.get<AreaTableRepository>().countAreaTables(
          filter: AreaTableFilter(id: id, name: name),
        ),
  );
}

class _SignedEntityDialog extends StatefulWidget {
  final SignedEntitySource positiveSource;
  final SignedEntitySource negativeSource;
  final int initialValue;

  const _SignedEntityDialog({
    required this.positiveSource,
    required this.negativeSource,
    required this.initialValue,
  });

  @override
  State<_SignedEntityDialog> createState() => _SignedEntityDialogState();
}

class _SignedEntityDialogState extends State<_SignedEntityDialog> {
  late final TextEditingController _idController;
  late final TextEditingController _nameController;

  /// Current data source and its encoding direction; positive sources
  /// encode positive, negative sources negative.
  late SignedEntitySource _source;
  late bool _isPositive;
  int _page = 1;
  int _queryVersion = 0;
  List<SignedEntityBrief> _items = [];
  int _total = 0;
  int? _selectedId;

  /// Whether the user actively clicked a row. Preselected values (an ID
  /// already in the input on open) are not highlighted, consistent with
  /// FoxyEntityPicker and other tables; only user-clicked rows get the
  /// selected background.
  bool _userSelected = false;

  /// Request sequence: under concurrent searches only the latest result is
  /// accepted, so a slow request never overwrites a fast one.
  int _searchSeq = 0;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text(_source.title),
      scrollable: false,
      actions: [
        FoxyPagination(
          page: _page,
          pageSize: 50,
          total: _total,
          onChange: _paginate,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            ShadButton.outline(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            ShadButton(
              onPressed: () => Navigator.of(context).pop(_confirmValue()),
              child: const Text('确定'),
            ),
          ],
        ),
      ],
      actionsMainAxisAlignment: MainAxisAlignment.spaceBetween,
      actionsMainAxisSize: MainAxisSize.max,
      constraints: foxyDialogConstraints(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          FoxyInlineError(message: _errorMessage),
          _buildFilter(),
          Flexible(child: _buildTable()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _isPositive = widget.initialValue >= 0;
    _source = _isPositive ? widget.positiveSource : widget.negativeSource;
    if (widget.initialValue != 0) {
      _idController.text = widget.initialValue.abs().toString();
      _selectedId = widget.initialValue.abs();
    }
    _search();
  }

  /// Encoded value on confirm: positive sources backfill a positive ID,
  /// negative sources a negative ID.
  int? _confirmValue() {
    final id = _selectedId;
    if (id == null) return null;
    return _isPositive ? id : -id;
  }

  Widget _buildFilter() {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: ShadInput(
              controller: _idController,
              placeholder: const Text('编号'),
            ),
          ),
          Expanded(
            child: ShadInput(
              controller: _nameController,
              placeholder: const Text('名称'),
            ),
          ),
          Expanded(
            child: Row(
              spacing: 8,
              children: [
                ShadButton(
                  onPressed: _doSearch,
                  size: ShadButtonSize.sm,
                  child: const Text('查询'),
                ),
                ShadButton.ghost(
                  onPressed: _reset,
                  size: ShadButtonSize.sm,
                  child: const Text('重置'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    final theme = ShadTheme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final tableMaxHeight = screenHeight * 0.5;
    if (_items.isEmpty) {
      return Center(
        child: SizedBox(
          height: tableMaxHeight,
          child: const Center(child: Text('无匹配数据')),
        ),
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: tableMaxHeight),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final nameWidth = constraints.maxWidth - 120;
          return FoxyShadTable(
            queryVersion: _queryVersion,
            columnCount: 2,
            rowCount: _items.length,
            pinnedRowCount: 1,
            header: (context, column) =>
                ShadTableCell.header(child: Text(column == 0 ? '编号' : '名称')),
            columnSpanExtent: (column) => column == 0
                ? FixedTableSpanExtent(120)
                : FixedTableSpanExtent(nameWidth),
            rowSpanBackgroundDecoration: (row) {
              final dataRow = row - 1;
              if (dataRow < 0 || dataRow >= _items.length) return null;
              if (_userSelected && _items[dataRow].id == _selectedId) {
                return TableSpanDecoration(color: theme.colorScheme.accent);
              }
              return null;
            },
            onRowTap: (row) {
              if (row >= 0 && row < _items.length) {
                setState(() {
                  _selectedId = _items[row].id;
                  _userSelected = true;
                });
              }
            },
            onRowDoubleTap: (row) {
              if (row >= 0 && row < _items.length) {
                Navigator.of(
                  context,
                ).pop(_isPositive ? _items[row].id : -_items[row].id);
              }
            },
            builder: (context, vicinity) {
              if (vicinity.row < 0 || vicinity.row >= _items.length) {
                return ShadTableCell(child: SizedBox());
              }
              final item = _items[vicinity.row];
              return ShadTableCell(
                child: vicinity.column == 0
                    ? Text(item.id.toString())
                    : Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              );
            },
          );
        },
      ),
    );
  }

  void _doSearch() {
    _page = 1;
    _queryVersion++;
    _search();
  }

  void _paginate(int page) {
    _page = page;
    _queryVersion++;
    _search();
  }

  void _reset() {
    _idController.clear();
    _nameController.clear();
    _page = 1;
    _queryVersion++;
    _search();
  }

  Future<void> _search() async {
    final seq = ++_searchSeq;
    try {
      final result = await _source.fetch(
        _page,
        _idController.text,
        _nameController.text,
      );
      final count = await _source.count(
        _idController.text,
        _nameController.text,
      );
      if (!mounted || seq != _searchSeq) return;
      setState(() {
        _items = result;
        _total = count;
        _errorMessage = null;
      });
    } catch (e) {
      LoggerUtil.instance.e('${_source.errorLabel}: $e');
      if (!mounted || seq != _searchSeq) return;
      setState(
        () => _errorMessage = '${_source.errorLabel}: ${foxyErrorMessage(e)}',
      );
    }
  }
}
