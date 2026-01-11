import 'package:flutter/material.dart';
import 'package:foxy/model/creature_equip_template.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/repository/creature_equip_template_repository.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 装备模板Tab
class CreatureEquipTemplateView extends StatefulWidget {
  final int creatureID;

  const CreatureEquipTemplateView({super.key, required this.creatureID});

  @override
  State<CreatureEquipTemplateView> createState() =>
      _CreatureEquipTemplateViewState();
}

class _CreatureEquipTemplateViewState extends State<CreatureEquipTemplateView> {
  final _repository = CreatureEquipTemplateRepository();
  List<CreatureEquipTemplate> _items = [];
  int? _selectedIndex;
  bool _loading = true;
  bool _editing = false;
  bool _creating = false;

  // 表单控制器
  final _idController = TextEditingController();
  final _itemID1Controller = TextEditingController();
  final _itemID2Controller = TextEditingController();
  final _itemID3Controller = TextEditingController();
  final _verifiedBuildController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _idController.dispose();
    _itemID1Controller.dispose();
    _itemID2Controller.dispose();
    _itemID3Controller.dispose();
    _verifiedBuildController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final items = await _repository.getByEntry(widget.creatureID);
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
    _idController.clear();
    _itemID1Controller.clear();
    _itemID2Controller.clear();
    _itemID3Controller.clear();
    _verifiedBuildController.text = '0';
  }

  void _fillForm(CreatureEquipTemplate equip) {
    _idController.text = equip.id.toString();
    _itemID1Controller.text = equip.itemID1.toString();
    _itemID2Controller.text = equip.itemID2.toString();
    _itemID3Controller.text = equip.itemID3.toString();
    _verifiedBuildController.text = equip.verifiedBuild.toString();
  }

  CreatureEquipTemplate _collectFromForm() {
    final equip = CreatureEquipTemplate();
    equip.creatureID = widget.creatureID;
    equip.id = int.tryParse(_idController.text) ?? 0;
    equip.itemID1 = int.tryParse(_itemID1Controller.text) ?? 0;
    equip.itemID2 = int.tryParse(_itemID2Controller.text) ?? 0;
    equip.itemID3 = int.tryParse(_itemID3Controller.text) ?? 0;
    equip.verifiedBuild = int.tryParse(_verifiedBuildController.text) ?? 0;
    return equip;
  }

  Future<void> _create() async {
    final nextId = await _repository.getNextId(widget.creatureID);
    _resetForm();
    _idController.text = nextId.toString();
    setState(() {
      _creating = true;
      _editing = false;
      _selectedIndex = null;
    });
  }

  void _edit() {
    if (_selectedIndex == null) return;
    final equip = _items[_selectedIndex!];
    _fillForm(equip);
    setState(() {
      _editing = true;
      _creating = false;
    });
  }

  Future<void> _copy() async {
    if (_selectedIndex == null) return;
    final equip = _items[_selectedIndex!];
    try {
      await _repository.copy(widget.creatureID, equip.id);
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
    final equip = _items[_selectedIndex!];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条装备模板记录吗？'),
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
        await _repository.delete(widget.creatureID, equip.id);
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
      final equip = _collectFromForm();
      if (_creating) {
        await _repository.store(equip);
      } else if (_editing) {
        await _repository.update(equip);
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
            final headers = ['ID', '主手武器', '副手武器', '远程武器'];
            return ShadTableCell.header(child: Text(headers[column]));
          },
          columnBuilder: (column) {
            return switch (column) {
              0 => TableSpan(extent: FixedTableSpanExtent(60)),
              1 => TableSpan(extent: FixedTableSpanExtent(200)),
              2 => TableSpan(extent: FixedTableSpanExtent(200)),
              3 => TableSpan(extent: FixedTableSpanExtent(200)),
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
            final equip = _items[vicinity.row];
            final qualityColor1 = _getQualityColor(equip.quality1);
            final qualityColor2 = _getQualityColor(equip.quality2);
            final qualityColor3 = _getQualityColor(equip.quality3);

            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(equip.id.toString())),
              1 => ShadTableCell(
                child: Text(
                  equip.displayName1,
                  style: TextStyle(color: qualityColor1),
                ),
              ),
              2 => ShadTableCell(
                child: Text(
                  equip.displayName2,
                  style: TextStyle(color: qualityColor2),
                ),
              ),
              3 => ShadTableCell(
                child: Text(
                  equip.displayName3,
                  style: TextStyle(color: qualityColor3),
                ),
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
              _creating ? '新增装备模板' : '编辑装备模板',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FormItem(
              controller: _idController,
              label: '模板ID',
              placeholder: 'ID',
            ),
            FormItem(
              label: '主手武器',
              child: ItemTemplateSelector(
                controller: _itemID1Controller,
                placeholder: 'ItemID1',
              ),
            ),
            FormItem(
              label: '副手武器',
              child: ItemTemplateSelector(
                controller: _itemID2Controller,
                placeholder: 'ItemID2',
              ),
            ),
            FormItem(
              label: '远程武器',
              child: ItemTemplateSelector(
                controller: _itemID3Controller,
                placeholder: 'ItemID3',
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
