import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_rank_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SpellRankView extends StatefulWidget {
  final int spellId;

  const SpellRankView({super.key, required this.spellId});

  @override
  State<SpellRankView> createState() => _SpellRankViewState();
}

class _SpellRankViewState extends State<SpellRankView> {
  final viewModel = GetIt.instance.get<SpellRankViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(spellId: widget.spellId);
  }

  @override
  void didUpdateWidget(covariant SpellRankView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spellId != widget.spellId) {
      viewModel.setParentSpellId(widget.spellId);
    }
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

    final toolbar = Row(
      children: [
        createButton,
        Spacer(),
        FoxyPagination(
          page: viewModel.page.value,
          pageSize: 50,
          total: viewModel.total.value,
          onChange: viewModel.paginate,
        ),
      ],
    );

    final items = viewModel.items.value;
    final headers = ['起始技能', '技能', '排行'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var flexWidth = maxWidth - 120;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = items[vicinity.row];
            final firstDisplay = item.firstSpellSubtext.isNotEmpty
                ? '${item.firstSpellName} - ${item.firstSpellSubtext}'
                : item.firstSpellName;
            final spellDisplay = item.spellSubtext.isNotEmpty
                ? '${item.spellName} - ${item.spellSubtext}'
                : item.spellName;
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(firstDisplay)),
              1 => ShadTableCell(child: Text(spellDisplay)),
              2 => ShadTableCell(child: Text(item.rank.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(flexWidth * 0.5),
              1 => FixedTableSpanExtent(flexWidth * 0.5),
              2 => FixedTableSpanExtent(120),
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
                  onPressed: () async {
                    if (await viewModel.edit() && context.mounted) {
                      _showEditDialog(context);
                    }
                  },
                  child: Text('编辑'),
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

  Future<void> _showCreateDialog() async {
    if (!await viewModel.create() || !mounted) return;
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增技能排行'),
        description: Text('新增一条技能排行记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑技能排行'),
        description: Text('编辑选中的技能排行记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editingKey.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 960),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '起始技能',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.spell,
                    controller: viewModel.firstSpellIdController,
                    placeholder: 'first_spell_id',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '技能',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.spell,
                    controller: viewModel.rankSpellIdController,
                    placeholder: 'spell_id',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '排行',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.rankController,
                    placeholder: 'rank',
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
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
                  final saved = await viewModel.save(dialogContext);
                  if (!saved || !dialogContext.mounted) return;
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
