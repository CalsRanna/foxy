import 'package:flutter/material.dart';
import 'package:foxy/model/npc_trainer.dart';
import 'package:foxy/page/creature_template/spell_selector.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 训练师Tab
class NpcTrainerView extends StatefulWidget {
  final int id;

  const NpcTrainerView({super.key, required this.id});

  @override
  State<NpcTrainerView> createState() => _NpcTrainerViewState();
}

class _NpcTrainerViewState extends State<NpcTrainerView> {
  final _repository = NpcTrainerRepository();
  List<NpcTrainer> _items = [];
  int? _selectedIndex;
  bool _loading = true;
  bool _editing = false;
  bool _creating = false;

  // 表单控制器
  final _spellIDController = TextEditingController();
  final _moneyCostController = TextEditingController();
  final _reqSkillLineController = TextEditingController();
  final _reqSkillRankController = TextEditingController();
  final _reqLevelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _spellIDController.dispose();
    _moneyCostController.dispose();
    _reqSkillLineController.dispose();
    _reqSkillRankController.dispose();
    _reqLevelController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final items = await _repository.getByEntry(widget.id);
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
    _spellIDController.clear();
    _moneyCostController.text = '0';
    _reqSkillLineController.text = '0';
    _reqSkillRankController.text = '0';
    _reqLevelController.text = '0';
  }

  void _fillForm(NpcTrainer trainer) {
    _spellIDController.text = trainer.spellID.toString();
    _moneyCostController.text = trainer.moneyCost.toString();
    _reqSkillLineController.text = trainer.reqSkillLine.toString();
    _reqSkillRankController.text = trainer.reqSkillRank.toString();
    _reqLevelController.text = trainer.reqLevel.toString();
  }

  NpcTrainer _collectFromForm() {
    final trainer = NpcTrainer();
    trainer.id = widget.id;
    trainer.spellID = int.tryParse(_spellIDController.text) ?? 0;
    trainer.moneyCost = int.tryParse(_moneyCostController.text) ?? 0;
    trainer.reqSkillLine = int.tryParse(_reqSkillLineController.text) ?? 0;
    trainer.reqSkillRank = int.tryParse(_reqSkillRankController.text) ?? 0;
    trainer.reqLevel = int.tryParse(_reqLevelController.text) ?? 0;
    return trainer;
  }

  void _create() {
    _resetForm();
    setState(() {
      _creating = true;
      _editing = false;
      _selectedIndex = null;
    });
  }

  void _edit() {
    if (_selectedIndex == null) return;
    final trainer = _items[_selectedIndex!];
    _fillForm(trainer);
    setState(() {
      _editing = true;
      _creating = false;
    });
  }

  Future<void> _copy() async {
    if (_selectedIndex == null) return;
    final trainer = _items[_selectedIndex!];
    try {
      await _repository.copy(widget.id, trainer.spellID);
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
    final trainer = _items[_selectedIndex!];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条训练师技能记录吗？'),
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
        await _repository.delete(widget.id, trainer.spellID);
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
      final trainer = _collectFromForm();
      if (_creating) {
        await _repository.store(trainer);
      } else if (_editing) {
        await _repository.update(trainer);
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
          columnCount: 5,
          rowCount: _items.length,
          pinnedRowCount: 1,
          header: (context, column) {
            final headers = ['技能ID', '技能名称', '金币花费', '技能线', '等级要求'];
            return ShadTableCell.header(child: Text(headers[column]));
          },
          columnBuilder: (column) {
            return switch (column) {
              0 => TableSpan(extent: FixedTableSpanExtent(80)),
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
            final trainer = _items[vicinity.row];
            final displayName = trainer.spellSubtext.isNotEmpty
                ? '${trainer.spellName} - ${trainer.spellSubtext}'
                : trainer.spellName;

            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(trainer.spellID.toString())),
              1 => ShadTableCell(child: Text(displayName)),
              2 => ShadTableCell(child: Text(trainer.moneyCost.toString())),
              3 => ShadTableCell(child: Text(trainer.reqSkillLine.toString())),
              4 => ShadTableCell(child: Text(trainer.reqLevel.toString())),
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
              _creating ? '新增训练师技能' : '编辑训练师技能',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FormItem(
              label: '技能',
              child: SpellSelector(
                controller: _spellIDController,
                placeholder: 'SpellID',
              ),
            ),
            FormItem(
              controller: _moneyCostController,
              label: '金币花费',
              placeholder: 'MoneyCost',
            ),
            FormItem(
              controller: _reqSkillLineController,
              label: '需要技能线',
              placeholder: 'ReqSkillLine',
            ),
            FormItem(
              controller: _reqSkillRankController,
              label: '需要技能等级',
              placeholder: 'ReqSkillRank',
            ),
            FormItem(
              controller: _reqLevelController,
              label: '需要等级',
              placeholder: 'ReqLevel',
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
