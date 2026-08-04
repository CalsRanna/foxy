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

/// 符号路由选择器：单输入框 + 搜索按钮，弹窗按输入框值正负路由到对应数据源。
///
/// 编码约定：正数 → [positiveSource]（如生物），负数 → [negativeSource]
/// （如游戏对象）。弹窗为标准分页表格，无类型切换。输入框显示编码值本身
/// （含符号）。
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
    // 输入框可自由输入,非法文本会让 collect() 抛 FormatException;
    // 捕获后提示用户而不是让搜索按钮静默失效。
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

/// 分页行记录。
class SignedEntityBrief {
  final int id;
  final String name;

  const SignedEntityBrief({required this.id, required this.name});
}

/// 符号路由选择器的一侧数据源：纯数据 + 查询闭包，可被多个 picker 共享。
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

/// 内置数据源：生物 / 游戏对象 / 任务分类 / 任务区域。
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

  /// 当前数据源与其编码方向；正数源编码正、负数源编码负。
  late SignedEntitySource _source;
  late bool _isPositive;
  int _page = 1;
  int _queryVersion = 0;
  List<SignedEntityBrief> _items = [];
  int _total = 0;
  int? _selectedId;

  /// 是否用户主动点击过行。预选值(打开时输入框已有 ID)不染色,
  /// 与 FoxyEntityPicker 及其他表格一致;只有用户点击过的行才有选中底色。
  bool _userSelected = false;

  /// 请求序号:并发搜索时只接受最新一次的结果,防止慢请求覆盖快请求。
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

  /// 确认时的编码值：正数源回填正 ID，负数源回填负 ID。
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
