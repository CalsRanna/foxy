import 'package:flutter/material.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/model/creature_questitem.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/repository/creature_quest_item_repository.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 任务物品Tab
class CreatureQuestItemView extends StatefulWidget {
  final int creatureEntry;

  const CreatureQuestItemView({super.key, required this.creatureEntry});

  @override
  State<CreatureQuestItemView> createState() => _CreatureQuestItemViewState();
}

class _CreatureQuestItemViewState extends State<CreatureQuestItemView> {
  final _repository = CreatureQuestItemRepository();
  List<CreatureQuestItem> _items = [];
  int? _selectedIndex;
  bool _loading = true;
  bool _editing = false;
  bool _creating = false;

  // 表单控制器
  final _idxController = TextEditingController();
  final _itemIdController = TextEditingController();
  final _verifiedBuildController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _idxController.dispose();
    _itemIdController.dispose();
    _verifiedBuildController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final items = await _repository.getByEntry(widget.creatureEntry);
      if (mounted) {
        setState(() {
          _items = items;
          _selectedIndex = null;
          _editing = false;
          _creating = false;
        });
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _resetForm() {
    _idxController.clear();
    _itemIdController.clear();
    _verifiedBuildController.text = '0';
  }

  void _fillForm(CreatureQuestItem questItem) {
    _idxController.text = questItem.idx.toString();
    _itemIdController.text = questItem.itemId.toString();
    _verifiedBuildController.text = questItem.verifiedBuild.toString();
  }

  CreatureQuestItem _collectFromForm() {
    final questItem = CreatureQuestItem();
    questItem.creatureEntry = widget.creatureEntry;
    questItem.idx = int.tryParse(_idxController.text) ?? 0;
    questItem.itemId = int.tryParse(_itemIdController.text) ?? 0;
    questItem.verifiedBuild = int.tryParse(_verifiedBuildController.text) ?? 0;
    return questItem;
  }

  Future<void> _create() async {
    final nextIdx = await _repository.getNextIdx(widget.creatureEntry);
    _resetForm();
    _idxController.text = nextIdx.toString();
    setState(() {
      _creating = true;
      _editing = false;
      _selectedIndex = null;
    });
  }

  void _edit() {
    if (_selectedIndex == null) return;
    final questItem = _items[_selectedIndex!];
    _fillForm(questItem);
    setState(() {
      _editing = true;
      _creating = false;
    });
  }

  Future<void> _copy() async {
    if (_selectedIndex == null) return;
    final questItem = _items[_selectedIndex!];
    try {
      await _repository.copy(widget.creatureEntry, questItem.idx);
      await _load();
      if (mounted) {
        ShadToaster.of(context).show(ShadToast(title: Text('复制成功')));
      }
    } catch (e) {
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: Text('复制失败'),
            description: Text(e.toString()),
          ),
        );
      }
    }
  }

  Future<void> _delete() async {
    if (_selectedIndex == null) return;
    final questItem = _items[_selectedIndex!];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条任务物品记录吗？'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('取消'),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        await _repository.delete(widget.creatureEntry, questItem.idx);
        await _load();
        if (mounted) {
          ShadToaster.of(context).show(ShadToast(title: Text('删除成功')));
        }
      } catch (e) {
        if (mounted) {
          ShadToaster.of(context).show(
            ShadToast.destructive(
              title: Text('删除失败'),
              description: Text(e.toString()),
            ),
          );
        }
      }
    }
  }

  Future<void> _save() async {
    try {
      final questItem = _collectFromForm();
      if (_creating) {
        await _repository.store(questItem);
      } else if (_editing) {
        await _repository.update(questItem);
      }
      await _load();
      if (mounted) {
        ShadToaster.of(context).show(ShadToast(title: Text('保存成功')));
      }
    } catch (e) {
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: Text('保存失败'),
            description: Text(e.toString()),
          ),
        );
      }
    }
  }

  void _cancel() {
    setState(() {
      _editing = false;
      _creating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 左侧列表
        Flexible(
          fit: FlexFit.loose,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToolbar(),
              SizedBox(height: 8),
              Flexible(fit: FlexFit.loose, child: _buildTable()),
            ],
          ),
        ),
        SizedBox(width: 16),
        // 右侧表单
        if (_editing || _creating)
          Flexible(fit: FlexFit.loose, child: _buildForm()),
      ],
    );
  }

  Widget _buildToolbar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ShadButton(
            size: ShadButtonSize.sm,
            onPressed: _create,
            child: Text('新增'),
          ),
          SizedBox(width: 8),
          ShadButton.outline(
            size: ShadButtonSize.sm,
            onPressed: _selectedIndex != null ? _edit : null,
            child: Text('编辑'),
          ),
          SizedBox(width: 8),
          ShadButton.outline(
            size: ShadButtonSize.sm,
            onPressed: _selectedIndex != null ? _copy : null,
            child: Text('复制'),
          ),
          SizedBox(width: 8),
          ShadButton.destructive(
            size: ShadButtonSize.sm,
            onPressed: _selectedIndex != null ? _delete : null,
            child: Text('删除'),
          ),
          Spacer(),
          Text('共 ${_items.length} 条记录'),
        ],
      ),
    );
  }

  Widget _buildTable() {
    if (_items.isEmpty) {
      return Center(child: Text('暂无数据'));
    }

    final theme = ShadTheme.of(context);

    return SizedBox(
      height: 400, // 给表格固定高度
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: FoxyShadTable(
          columnCount: 4,
          rowCount: _items.length,
          pinnedRowCount: 1,
          header: (context, column) {
            final headers = ['索引', '物品名称', '物品ID', 'VerifiedBuild'];
            return ShadTableCell.header(child: Text(headers[column]));
          },
          columnBuilder: (column) {
            return switch (column) {
              0 => TableSpan(extent: FixedTableSpanExtent(60)),
              1 => TableSpan(extent: FixedTableSpanExtent(350)),
              2 => TableSpan(extent: FixedTableSpanExtent(100)),
              3 => TableSpan(extent: FixedTableSpanExtent(150)),
              _ => TableSpan(extent: FixedTableSpanExtent(100)),
            };
          },
          rowSpanBackgroundDecoration: (row) {
            final dataRow = row - 1;
            if (dataRow < 0 || dataRow >= _items.length) return null;
            if (dataRow == _selectedIndex) {
              return TableSpanDecoration(color: theme.colorScheme.accent);
            }
            return null;
          },
          onRowTap: (row) {
            if (row >= 0 && row < _items.length) {
              setState(() => _selectedIndex = row);
            }
          },
          onRowDoubleTap: (row) {
            if (row >= 0 && row < _items.length) {
              setState(() => _selectedIndex = row);
              _edit();
            }
          },
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= _items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final questItem = _items[vicinity.row];
            final qualityColor = getItemQualityColor(questItem.itemQuality);

            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(questItem.idx.toString())),
              1 => ShadTableCell(
                child: Text(
                  questItem.displayName,
                  style: TextStyle(color: qualityColor),
                ),
              ),
              2 => ShadTableCell(child: Text(questItem.itemId.toString())),
              3 => ShadTableCell(
                child: Text(questItem.verifiedBuild.toString()),
              ),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              _creating ? '新增任务物品' : '编辑任务物品',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FormItem(
              controller: _idxController,
              label: '索引',
              placeholder: 'Idx',
            ),
            FormItem(
              label: '物品',
              child: ItemTemplateSelector(
                controller: _itemIdController,
                placeholder: 'ItemId',
              ),
            ),
            FormItem(
              controller: _verifiedBuildController,
              label: 'VerifiedBuild',
              placeholder: 'VerifiedBuild',
            ),
            SizedBox(height: 8),
            Row(
              spacing: 8,
              children: [
                ShadButton(onPressed: _save, child: Text('保存')),
                ShadButton.outline(onPressed: _cancel, child: Text('取消')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
