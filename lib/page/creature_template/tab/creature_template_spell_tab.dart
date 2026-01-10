import 'package:flutter/material.dart';
import 'package:foxy/model/creature_template_spell.dart';
import 'package:foxy/page/creature_template/spell_selector.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 技能Tab
class CreatureTemplateSpellTab extends StatefulWidget {
  final int creatureID;

  const CreatureTemplateSpellTab({super.key, required this.creatureID});

  @override
  State<CreatureTemplateSpellTab> createState() => _CreatureTemplateSpellTabState();
}

class _CreatureTemplateSpellTabState extends State<CreatureTemplateSpellTab> {
  final _repository = CreatureTemplateSpellRepository();
  List<CreatureTemplateSpell> _items = [];
  int? _selectedIndex;
  bool _loading = true;
  bool _editing = false;
  bool _creating = false;
  int? _editingIndex;

  // 表单控制器
  final _indexController = TextEditingController();
  final _spellController = TextEditingController();
  final _verifiedBuildController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _indexController.dispose();
    _spellController.dispose();
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
    _indexController.clear();
    _spellController.clear();
    _verifiedBuildController.text = '0';
  }

  void _fillForm(CreatureTemplateSpell spell) {
    _indexController.text = spell.index.toString();
    _spellController.text = spell.spell.toString();
    _verifiedBuildController.text = spell.verifiedBuild.toString();
  }

  CreatureTemplateSpell _collectFromForm() {
    final spell = CreatureTemplateSpell();
    spell.creatureID = widget.creatureID;
    spell.index = int.tryParse(_indexController.text) ?? 0;
    spell.spell = int.tryParse(_spellController.text) ?? 0;
    spell.verifiedBuild = int.tryParse(_verifiedBuildController.text) ?? 0;
    return spell;
  }

  Future<void> _create() async {
    final nextIndex = await _repository.getNextIndex(widget.creatureID);
    _resetForm();
    _indexController.text = nextIndex.toString();
    setState(() {
      _creating = true;
      _editing = false;
      _selectedIndex = null;
      _editingIndex = null;
    });
  }

  void _edit() {
    if (_selectedIndex == null) return;
    final spell = _items[_selectedIndex!];
    _fillForm(spell);
    setState(() {
      _editing = true;
      _creating = false;
      _editingIndex = spell.index;
    });
  }

  Future<void> _copy() async {
    if (_selectedIndex == null) return;
    final spell = _items[_selectedIndex!];
    try {
      await _repository.copy(widget.creatureID, spell.index);
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
    final spell = _items[_selectedIndex!];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条技能记录吗？'),
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
        await _repository.delete(widget.creatureID, spell.index);
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
      final spell = _collectFromForm();
      if (_creating) {
        await _repository.store(spell);
      } else if (_editing) {
        await _repository.update(spell);
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
      _editingIndex = null;
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
            final headers = ['索引', '技能名称', 'VerifiedBuild'];
            return ShadTableCell.header(child: Text(headers[column]));
          },
          columnBuilder: (column) {
            return switch (column) {
              0 => TableSpan(extent: FixedTableSpanExtent(80)),
              1 => TableSpan(extent: FixedTableSpanExtent(350)),
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
            final spell = _items[vicinity.row];
            final displayName = spell.spellSubtext.isNotEmpty
                ? '${spell.spellName} - ${spell.spellSubtext}'
                : spell.spellName;

            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(spell.index.toString())),
              1 => ShadTableCell(child: Text(displayName)),
              2 => ShadTableCell(child: Text(spell.verifiedBuild.toString())),
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
            Text(_creating ? '新增技能' : '编辑技能',
                style: TextStyle(fontWeight: FontWeight.bold)),
            FormItem(
              controller: _indexController,
              label: '索引',
              placeholder: 'Index',
            ),
            FormItem(
              label: '技能',
              child: SpellSelector(
                controller: _spellController,
                placeholder: 'Spell',
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
