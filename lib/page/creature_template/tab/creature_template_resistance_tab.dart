import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/model/creature_template_resistance.dart';
import 'package:foxy/repository/creature_template_resistance_repository.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 抗性Tab
class CreatureTemplateResistanceTab extends StatefulWidget {
  final int creatureID;

  const CreatureTemplateResistanceTab({super.key, required this.creatureID});

  @override
  State<CreatureTemplateResistanceTab> createState() => _CreatureTemplateResistanceTabState();
}

class _CreatureTemplateResistanceTabState extends State<CreatureTemplateResistanceTab> {
  final _repository = CreatureTemplateResistanceRepository();
  List<CreatureTemplateResistance> _items = [];
  int? _selectedIndex;
  bool _loading = true;
  bool _editing = false;
  bool _creating = false;
  int? _editingSchool;

  // 表单控制器
  final _schoolController = ShadSelectController<int>();
  final _resistanceController = TextEditingController();
  final _verifiedBuildController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _schoolController.dispose();
    _resistanceController.dispose();
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
    _schoolController.value = {0};
    _resistanceController.clear();
    _verifiedBuildController.text = '0';
  }

  void _fillForm(CreatureTemplateResistance resistance) {
    _schoolController.value = {resistance.school};
    _resistanceController.text = resistance.resistance.toString();
    _verifiedBuildController.text = resistance.verifiedBuild.toString();
  }

  CreatureTemplateResistance _collectFromForm() {
    final resistance = CreatureTemplateResistance();
    resistance.creatureID = widget.creatureID;
    resistance.school = _schoolController.value.first;
    resistance.resistance = int.tryParse(_resistanceController.text) ?? 0;
    resistance.verifiedBuild = int.tryParse(_verifiedBuildController.text) ?? 0;
    return resistance;
  }

  Future<void> _create() async {
    final nextSchool = await _repository.getNextSchool(widget.creatureID);
    _resetForm();
    _schoolController.value = {nextSchool};
    setState(() {
      _creating = true;
      _editing = false;
      _selectedIndex = null;
      _editingSchool = null;
    });
  }

  void _edit() {
    if (_selectedIndex == null) return;
    final resistance = _items[_selectedIndex!];
    _fillForm(resistance);
    setState(() {
      _editing = true;
      _creating = false;
      _editingSchool = resistance.school;
    });
  }

  Future<void> _copy() async {
    if (_selectedIndex == null) return;
    final resistance = _items[_selectedIndex!];
    try {
      await _repository.copy(widget.creatureID, resistance.school);
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
    final resistance = _items[_selectedIndex!];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条抗性记录吗？'),
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
        await _repository.delete(widget.creatureID, resistance.school);
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
      final resistance = _collectFromForm();
      if (_creating) {
        await _repository.store(resistance);
      } else if (_editing) {
        await _repository.update(resistance);
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
      _editingSchool = null;
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
          columnCount: 3,
          rowCount: _items.length,
          pinnedRowCount: 1,
          header: (context, column) {
            final headers = ['抗性类型', '抗性值', 'VerifiedBuild'];
            return ShadTableCell.header(child: Text(headers[column]));
          },
          columnBuilder: (column) {
            return switch (column) {
              0 => TableSpan(extent: FixedTableSpanExtent(200)),
              1 => TableSpan(extent: FixedTableSpanExtent(150)),
              2 => TableSpan(extent: FixedTableSpanExtent(150)),
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
            final resistance = _items[vicinity.row];

            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(kResistanceSchoolOptions[resistance.school] ?? '未知 (${resistance.school})')),
              1 => ShadTableCell(child: Text(resistance.resistance.toString())),
              2 => ShadTableCell(child: Text(resistance.verifiedBuild.toString())),
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
            Text(_creating ? '新增抗性' : '编辑抗性',
                style: TextStyle(fontWeight: FontWeight.bold)),
            FormItem(
              label: '抗性类型',
              child: FoxyShadSelect<int>(
                controller: _schoolController,
                options: kResistanceSchoolOptions,
                placeholder: Text('School'),
              ),
            ),
            FormItem(
              controller: _resistanceController,
              label: '抗性值',
              placeholder: 'Resistance',
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
