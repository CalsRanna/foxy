import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/model/loot_template.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 剥皮掉落Tab
class SkinningLootTemplateTab extends StatefulWidget {
  final int lootId;

  const SkinningLootTemplateTab({super.key, required this.lootId});

  @override
  State<SkinningLootTemplateTab> createState() => _SkinningLootTemplateTabState();
}

class _SkinningLootTemplateTabState extends State<SkinningLootTemplateTab> {
  final _repository = LootTemplateRepository(LootTableType.skinning);
  List<LootTemplate> _items = [];
  int? _selectedIndex;
  bool _loading = true;
  bool _editing = false;
  bool _creating = false;
  int? _editingItem;

  // 表单控制器
  final _itemController = TextEditingController();
  final _referenceController = TextEditingController();
  final _chanceController = TextEditingController();
  final _questRequiredController = ShadSelectController<int>();
  final _lootModeController = TextEditingController();
  final _groupIdController = TextEditingController();
  final _minCountController = TextEditingController();
  final _maxCountController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _itemController.dispose();
    _referenceController.dispose();
    _chanceController.dispose();
    _questRequiredController.dispose();
    _lootModeController.dispose();
    _groupIdController.dispose();
    _minCountController.dispose();
    _maxCountController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final items = await _repository.getByEntry(widget.lootId);
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
    _itemController.clear();
    _referenceController.text = '0';
    _chanceController.text = '0';
    _questRequiredController.value = {0};
    _lootModeController.text = '1';
    _groupIdController.text = '0';
    _minCountController.text = '1';
    _maxCountController.text = '1';
    _commentController.clear();
  }

  void _fillForm(LootTemplate loot) {
    _itemController.text = loot.item.toString();
    _referenceController.text = loot.reference.toString();
    _chanceController.text = loot.chance.toString();
    _questRequiredController.value = {loot.questRequired ? 1 : 0};
    _lootModeController.text = loot.lootMode.toString();
    _groupIdController.text = loot.groupId.toString();
    _minCountController.text = loot.minCount.toString();
    _maxCountController.text = loot.maxCount.toString();
    _commentController.text = loot.comment;
  }

  LootTemplate _collectFromForm() {
    final loot = LootTemplate();
    loot.entry = widget.lootId;
    loot.item = int.tryParse(_itemController.text) ?? 0;
    loot.reference = int.tryParse(_referenceController.text) ?? 0;
    loot.chance = double.tryParse(_chanceController.text) ?? 0;
    loot.questRequired = _questRequiredController.value.first == 1;
    loot.lootMode = int.tryParse(_lootModeController.text) ?? 1;
    loot.groupId = int.tryParse(_groupIdController.text) ?? 0;
    loot.minCount = int.tryParse(_minCountController.text) ?? 1;
    loot.maxCount = int.tryParse(_maxCountController.text) ?? 1;
    loot.comment = _commentController.text;
    return loot;
  }

  Future<void> _create() async {
    final nextItem = await _repository.getNextItemId(widget.lootId);
    _resetForm();
    _itemController.text = nextItem.toString();
    setState(() {
      _creating = true;
      _editing = false;
      _selectedIndex = null;
      _editingItem = null;
    });
  }

  void _edit() {
    if (_selectedIndex == null) return;
    final loot = _items[_selectedIndex!];
    _fillForm(loot);
    setState(() {
      _editing = true;
      _creating = false;
      _editingItem = loot.item;
    });
  }

  Future<void> _copy() async {
    if (_selectedIndex == null) return;
    final loot = _items[_selectedIndex!];
    try {
      await _repository.copy(widget.lootId, loot.item);
      await _load();
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast(title: Text('复制成功')),
        );
      }
    } catch (e) {
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast.destructive(title: Text('复制失败'), description: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _delete() async {
    if (_selectedIndex == null) return;
    final loot = _items[_selectedIndex!];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条掉落记录吗？'),
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
        await _repository.delete(widget.lootId, loot.item);
        await _load();
        if (mounted) {
          ShadToaster.of(context).show(
            ShadToast(title: Text('删除成功')),
          );
        }
      } catch (e) {
        if (mounted) {
          ShadToaster.of(context).show(
            ShadToast.destructive(title: Text('删除失败'), description: Text(e.toString())),
          );
        }
      }
    }
  }

  Future<void> _save() async {
    try {
      final loot = _collectFromForm();
      if (_creating) {
        await _repository.store(loot);
      } else if (_editing) {
        await _repository.update(loot, oldItem: _editingItem);
      }
      await _load();
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast(title: Text('保存成功')),
        );
      }
    } catch (e) {
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast.destructive(title: Text('保存失败'), description: Text(e.toString())),
        );
      }
    }
  }

  void _cancel() {
    setState(() {
      _editing = false;
      _creating = false;
      _editingItem = null;
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
              Flexible(
                fit: FlexFit.loose,
                child: _buildTable(),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        // 右侧表单
        if (_editing || _creating)
          Flexible(
            fit: FlexFit.loose,
            child: _buildForm(),
          ),
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
          columnCount: 6,
          rowCount: _items.length,
          pinnedRowCount: 1,
          header: (context, column) {
            final headers = ['物品ID', '物品名称', '几率', '数量', '任务', '组'];
            return ShadTableCell.header(child: Text(headers[column]));
          },
          columnBuilder: (column) {
            return switch (column) {
              0 => TableSpan(extent: FixedTableSpanExtent(80)),
              1 => TableSpan(extent: FixedTableSpanExtent(200)),
              2 => TableSpan(extent: FixedTableSpanExtent(80)),
              3 => TableSpan(extent: FixedTableSpanExtent(80)),
              4 => TableSpan(extent: FixedTableSpanExtent(60)),
              5 => TableSpan(extent: FixedTableSpanExtent(60)),
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
            final loot = _items[vicinity.row];
            final qualityColor =
                _getQualityColor(loot.itemQuality);

            return switch (vicinity.column) {
              0 => ShadTableCell(
                  child: Text(loot.reference != 0
                      ? '${loot.item} (R)'
                      : loot.item.toString()),
                ),
              1 => ShadTableCell(
                  child: loot.reference != 0
                      ? Text('关联掉落', style: TextStyle(color: Colors.grey))
                      : Text(
                          loot.displayName,
                          style: TextStyle(color: qualityColor),
                        ),
                ),
              2 => ShadTableCell(child: Text('${loot.chance}%')),
              3 => ShadTableCell(child: Text('${loot.minCount}-${loot.maxCount}')),
              4 => ShadTableCell(child: Text(loot.questRequired ? '是' : '否')),
              5 => ShadTableCell(child: Text(loot.groupId.toString())),
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
            Text(_creating ? '新增掉落' : '编辑掉落',
                style: TextStyle(fontWeight: FontWeight.bold)),
            FormItem(
              label: '物品ID',
              child: ItemTemplateSelector(
                controller: _itemController,
                placeholder: 'Item',
              ),
            ),
            FormItem(
              controller: _referenceController,
              label: '关联ID',
              placeholder: 'Reference (0=直接掉落)',
            ),
            FormItem(
              controller: _chanceController,
              label: '掉落几率',
              placeholder: 'Chance (%)',
            ),
            FormItem(
              label: '需要任务',
              child: FoxyShadSelect<int>(
                controller: _questRequiredController,
                options: kBooleanOptions,
                placeholder: Text('QuestRequired'),
              ),
            ),
            FormItem(
              controller: _lootModeController,
              label: '掉落模式',
              placeholder: 'LootMode',
            ),
            FormItem(
              controller: _groupIdController,
              label: '组ID',
              placeholder: 'GroupId',
            ),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: FormItem(
                    controller: _minCountController,
                    label: '最小数量',
                    placeholder: 'MinCount',
                  ),
                ),
                Expanded(
                  child: FormItem(
                    controller: _maxCountController,
                    label: '最大数量',
                    placeholder: 'MaxCount',
                  ),
                ),
              ],
            ),
            FormItem(
              controller: _commentController,
              label: '备注',
              placeholder: 'Comment',
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

  Color _getQualityColor(int quality) {
    const qualityColors = {
      0: Colors.white,
      1: Colors.grey,
      2: Colors.green,
      3: Colors.blue,
      4: Colors.purple,
      5: Colors.orange,
      6: Colors.red,
      7: Color(0xFFe6cc80),
    };
    return qualityColors[quality] ?? Colors.white;
  }
}
