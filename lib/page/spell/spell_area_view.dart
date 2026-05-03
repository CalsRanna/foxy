import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_area_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SpellAreaView extends StatefulWidget {
  final int spellId;

  const SpellAreaView({super.key, required this.spellId});

  @override
  State<SpellAreaView> createState() => _SpellAreaViewState();
}

class _SpellAreaViewState extends State<SpellAreaView> {
  final viewModel = GetIt.instance.get<SpellAreaViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(spellId: widget.spellId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return _buildTable();
    });
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      onPressed: _showCreateDialog,
      child: Text('新增'),
    );

    final toolbar = Row(children: [createButton, Spacer()]);

    final items = viewModel.items.value;
    final headers = ['区域', '开始任务', '结束任务', '光环', '开始任务掩码', '结束任务掩码'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var flexWidth = maxWidth - 600;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = items[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.area.toString())),
              1 => ShadTableCell(child: Text(item.questStart.toString())),
              2 => ShadTableCell(child: Text(item.questEnd.toString())),
              3 => ShadTableCell(child: Text(item.auraSpell.toString())),
              4 => ShadTableCell(child: Text(item.questStartStatus.toString())),
              5 => ShadTableCell(child: Text(item.questEndStatus.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(100),
              1 => FixedTableSpanExtent(100),
              2 => FixedTableSpanExtent(100),
              3 => FixedTableSpanExtent(100),
              4 => FixedTableSpanExtent(100),
              5 => FixedTableSpanExtent(flexWidth),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            viewModel.selectRow(row);
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    viewModel.edit();
                    _showEditDialog(context);
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.copy(context),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.delete(context),
                  child: Text('删除'),
                ),
              ],
            );
          },
          rowCount: items.length,
          shrinkWrap: true,
        );
      },
    );

    var children = [toolbar, layoutBuilder];
    final column = Column(spacing: 16, children: children);
    return Padding(padding: const EdgeInsets.only(top: 16), child: column);
  }

  void _showCreateDialog() {
    viewModel.create();
    showShadDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增区域技能'),
        description: Text('新增一条区域技能记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showShadDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑区域技能'),
        description: Text('编辑选中的区域技能记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.selectedIndex.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FormItem(
                  controller: TextEditingController(
                    text: widget.spellId.toString(),
                  ),
                  label: '法术ID',
                  placeholder: 'spell',
                  readOnly: true,
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '区域',
                  placeholder: 'area',
                  child: FoxyNumberInput<int>(
                    value: viewModel.area.value,
                    onChanged: (v) => viewModel.area.value = v,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FormItem(
                  label: '开始任务',
                  placeholder: 'quest_start',
                  child: FoxyNumberInput<int>(
                    value: viewModel.questStart.value,
                    onChanged: (v) => viewModel.questStart.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '结束任务',
                  placeholder: 'quest_end',
                  child: FoxyNumberInput<int>(
                    value: viewModel.questEnd.value,
                    onChanged: (v) => viewModel.questEnd.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '开始任务掩码',
                  placeholder: 'quest_start_status',
                  child: FoxyNumberInput<int>(
                    value: viewModel.questStartStatus.value,
                    onChanged: (v) => viewModel.questStartStatus.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '结束任务掩码',
                  placeholder: 'quest_end_status',
                  child: FoxyNumberInput<int>(
                    value: viewModel.questEndStatus.value,
                    onChanged: (v) => viewModel.questEndStatus.value = v,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FormItem(
                  label: '光环',
                  placeholder: 'aura_spell',
                  child: FoxyNumberInput<int>(
                    value: viewModel.auraSpell.value,
                    onChanged: (v) => viewModel.auraSpell.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '种族掩码',
                  placeholder: 'racemask',
                  child: FoxyNumberInput<int>(
                    value: viewModel.racemask.value,
                    onChanged: (v) => viewModel.racemask.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '性别',
                  placeholder: 'gender',
                  child: FoxyNumberInput<int>(
                    value: viewModel.gender.value,
                    onChanged: (v) => viewModel.gender.value = v,
                  ),
                ),
              ),
              Expanded(
                child: FormItem(
                  label: '自动施放',
                  placeholder: 'autocast',
                  child: FoxyNumberInput<int>(
                    value: viewModel.autocast.value,
                    onChanged: (v) => viewModel.autocast.value = v,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShadButton.outline(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text('取消'),
              ),
              SizedBox(width: 8),
              ShadButton(
                onPressed: () async {
                  if (isEditing) {
                    await viewModel.update(dialogContext);
                  } else {
                    await viewModel.save(dialogContext);
                  }
                  if (!dialogContext.mounted) return;
                  Navigator.of(dialogContext).pop();
                },
                child: Text(isEditing ? '更新' : '保存'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
