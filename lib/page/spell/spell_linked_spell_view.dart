import 'package:flutter/material.dart';
import 'package:foxy/entity/spell_linked_spell_key.dart';
import 'package:foxy/constant/spell_enums.dart';
import 'package:foxy/page/spell/spell_linked_spell_collection_editor_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

class SpellLinkedSpellView extends StatefulWidget {
  final int spellId;

  const SpellLinkedSpellView({super.key, required this.spellId});

  @override
  State<SpellLinkedSpellView> createState() => _SpellLinkedSpellViewState();
}

class _SpellLinkedSpellViewState extends State<SpellLinkedSpellView> {
  final viewModel = GetIt.instance
      .get<SpellLinkedSpellCollectionEditorViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(parentKey: widget.spellId);
  }

  @override
  void didUpdateWidget(covariant SpellLinkedSpellView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spellId != widget.spellId) {
      viewModel.setParentKey(widget.spellId);
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
    final headers = ['链接技能', '类型', '注解'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var flexWidth = maxWidth - 200;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = items[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.spellEffect.toString())),
              1 => ShadTableCell(child: Text(item.type.toString())),
              2 => ShadTableCell(child: Text(item.comment)),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(100),
              1 => FixedTableSpanExtent(100),
              2 => FixedTableSpanExtent(flexWidth),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            viewModel.selectedKey.value = items[row].key;
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () async {
                    if (!await _load(viewModel.selectedKey.value!)) return;
                    if (context.mounted) {
                      _showEditDialog(context);
                    }
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => _copy(viewModel.selectedKey.value!),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => _destroy(viewModel.selectedKey.value!),
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
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：$error');
      return;
    }
    if (!mounted) return;
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增链接技能'),
        description: Text('新增一条链接技能记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑链接技能'),
        description: Text('编辑选中的链接技能记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.selectedKey.value != null;

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
                  label: '触发法术（可为负值）',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.spellTriggerController,
                    placeholder: 'spell_trigger',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '效果法术（可为负值）',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.spellEffectController,
                    placeholder: 'spell_effect',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '类型',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.typeController,
                    options: kSpellLinkedTypeOptions,
                    placeholder: Text('type'),
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '注解',
                  child: FoxyStringInput(
                    controller: viewModel.commentController,
                    placeholder: 'comment',
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
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () async {
                    try {
                      await viewModel.persist();
                    } catch (error) {
                      if (!mounted) return;
                      DialogUtil.instance.error('保存失败：$error');
                      return;
                    }
                    if (!dialogContext.mounted) return;
                    ShadSonner.of(
                      dialogContext,
                    ).show(const ShadToast(description: Text('保存成功')));
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(isEditing ? '更新' : '保存'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> _load(SpellLinkedSpellKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) DialogUtil.instance.error('加载失败：$error');
      return false;
    }
  }

  Future<void> _destroy(SpellLinkedSpellKey key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '将永久删除该记录，确认继续？',
      confirmText: '删除',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await viewModel.destroy(key);
      if (!mounted) return;
      DialogUtil.instance.success('删除成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('删除失败：$error');
    }
  }

  Future<void> _copy(SpellLinkedSpellKey key) async {
    try {
      await viewModel.copy(key);
      if (!mounted) return;
      DialogUtil.instance.success('复制成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('复制失败：$error');
    }
  }
}
