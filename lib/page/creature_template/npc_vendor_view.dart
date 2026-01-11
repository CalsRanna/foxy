import 'package:flutter/material.dart';
import 'package:foxy/model/npc_vendor.dart';
import 'package:foxy/page/creature_template/item_extended_cost_selector.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// NPC商人Tab
class NpcVendorView extends StatefulWidget {
  final int entry;

  const NpcVendorView({super.key, required this.entry});

  @override
  State<NpcVendorView> createState() => _NpcVendorViewState();
}

class _NpcVendorViewState extends State<NpcVendorView> {
  final _repository = NpcVendorRepository();
  List<NpcVendor> _items = [];
  int? _selectedIndex;
  bool _loading = true;
  bool _editing = false;
  bool _creating = false;
  int? _editingSlot;

  // 表单控制器
  final _slotController = TextEditingController();
  final _itemController = TextEditingController();
  final _maxcountController = TextEditingController();
  final _incrtimeController = TextEditingController();
  final _extendedCostController = TextEditingController();
  final _verifiedBuildController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _slotController.dispose();
    _itemController.dispose();
    _maxcountController.dispose();
    _incrtimeController.dispose();
    _extendedCostController.dispose();
    _verifiedBuildController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final items = await _repository.getByEntry(widget.entry);
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
    _slotController.clear();
    _itemController.clear();
    _maxcountController.text = '0';
    _incrtimeController.text = '0';
    _extendedCostController.text = '0';
    _verifiedBuildController.text = '0';
  }

  void _fillForm(NpcVendor vendor) {
    _slotController.text = vendor.slot.toString();
    _itemController.text = vendor.item.toString();
    _maxcountController.text = vendor.maxcount.toString();
    _incrtimeController.text = vendor.incrtime.toString();
    _extendedCostController.text = vendor.extendedCost.toString();
    _verifiedBuildController.text = vendor.verifiedBuild.toString();
  }

  NpcVendor _collectFromForm() {
    final vendor = NpcVendor();
    vendor.entry = widget.entry;
    vendor.slot = int.tryParse(_slotController.text) ?? 0;
    vendor.item = int.tryParse(_itemController.text) ?? 0;
    vendor.maxcount = int.tryParse(_maxcountController.text) ?? 0;
    vendor.incrtime = int.tryParse(_incrtimeController.text) ?? 0;
    vendor.extendedCost = int.tryParse(_extendedCostController.text) ?? 0;
    vendor.verifiedBuild = int.tryParse(_verifiedBuildController.text) ?? 0;
    return vendor;
  }

  Future<void> _create() async {
    final nextSlot = await _repository.getNextSlot(widget.entry);
    _resetForm();
    _slotController.text = nextSlot.toString();
    setState(() {
      _creating = true;
      _editing = false;
      _selectedIndex = null;
      _editingSlot = null;
    });
  }

  void _edit() {
    if (_selectedIndex == null) return;
    final vendor = _items[_selectedIndex!];
    _fillForm(vendor);
    setState(() {
      _editing = true;
      _creating = false;
      _editingSlot = vendor.slot;
    });
  }

  Future<void> _copy() async {
    if (_selectedIndex == null) return;
    final vendor = _items[_selectedIndex!];
    try {
      await _repository.copy(widget.entry, vendor.slot);
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
    final vendor = _items[_selectedIndex!];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条商品记录吗？'),
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
        await _repository.delete(widget.entry, vendor.slot);
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
      final vendor = _collectFromForm();
      if (_creating) {
        await _repository.store(vendor);
      } else if (_editing) {
        await _repository.update(vendor, oldSlot: _editingSlot);
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
      _editingSlot = null;
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
          columnCount: 5,
          rowCount: _items.length,
          pinnedRowCount: 1,
          header: (context, column) {
            final headers = ['插槽', '物品名称', '最大数量', '补货时间', '扩展价格'];
            return ShadTableCell.header(child: Text(headers[column]));
          },
          columnBuilder: (column) {
            return switch (column) {
              0 => TableSpan(extent: FixedTableSpanExtent(60)),
              1 => TableSpan(extent: FixedTableSpanExtent(250)),
              2 => TableSpan(extent: FixedTableSpanExtent(80)),
              3 => TableSpan(extent: FixedTableSpanExtent(80)),
              4 => TableSpan(extent: FixedTableSpanExtent(80)),
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
            final vendor = _items[vicinity.row];
            final qualityColor =
                kItemQualityColors[vendor.itemQuality] ?? Colors.white;

            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(vendor.slot.toString())),
              1 => ShadTableCell(
                child: Text(
                  vendor.displayName,
                  style: TextStyle(color: qualityColor),
                ),
              ),
              2 => ShadTableCell(
                child: Text(
                  vendor.maxcount == 0 ? '无限' : vendor.maxcount.toString(),
                ),
              ),
              3 => ShadTableCell(
                child: Text(vendor.incrtime == 0 ? '-' : '${vendor.incrtime}s'),
              ),
              4 => ShadTableCell(
                child: Text(
                  vendor.extendedCost == 0
                      ? '-'
                      : vendor.extendedCost.toString(),
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
              _creating ? '新增商品' : '编辑商品',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FormItem(
              controller: _slotController,
              label: '插槽',
              placeholder: 'slot',
            ),
            FormItem(
              label: '物品',
              child: ItemTemplateSelector(
                controller: _itemController,
                placeholder: 'item',
              ),
            ),
            FormItem(
              controller: _maxcountController,
              label: '最大数量',
              placeholder: 'maxcount (0=无限)',
            ),
            FormItem(
              controller: _incrtimeController,
              label: '补货时间',
              placeholder: 'incrtime (秒)',
            ),
            FormItem(
              label: '扩展价格',
              child: ItemExtendedCostSelector(
                controller: _extendedCostController,
                placeholder: 'ExtendedCost',
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
