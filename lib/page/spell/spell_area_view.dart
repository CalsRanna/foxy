import 'package:flutter/material.dart';
import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/item_flags.dart';
import 'package:foxy/constant/spell_enums.dart';
import 'package:foxy/constant/spell_flags.dart';
import 'package:foxy/page/spell/spell_area_collection_editor_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

class SpellAreaView extends StatefulWidget {
  final int spellId;

  const SpellAreaView({super.key, required this.spellId});

  @override
  State<SpellAreaView> createState() => _SpellAreaViewState();
}

class _SpellAreaViewState extends State<SpellAreaView> {
  final viewModel = GetIt.instance.get<SpellAreaCollectionEditorViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(parentKey: widget.spellId);
  }

  @override
  void didUpdateWidget(covariant SpellAreaView oldWidget) {
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
        title: Text('新增区域技能'),
        description: Text('新增一条区域技能记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑区域技能'),
        description: Text('编辑选中的区域技能记录'),
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
                  label: '法术ID',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.spellIdController,
                    placeholder: 'spell',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '区域',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.areaTable,
                    controller: viewModel.areaController,
                    placeholder: 'area',
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '开始任务',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.questTemplate,
                    controller: viewModel.questStartController,
                    placeholder: 'quest_start',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '结束任务',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.questTemplate,
                    controller: viewModel.questEndController,
                    placeholder: 'quest_end',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '开始任务掩码',
                  child: FoxyFlagPicker(
                    controller: viewModel.questStartStatusController,
                    flags: kSpellAreaQuestStatusOptions,
                    title: '开始任务状态',
                    placeholder: 'quest_start_status',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '结束任务掩码',
                  child: FoxyFlagPicker(
                    controller: viewModel.questEndStatusController,
                    flags: kSpellAreaQuestStatusOptions,
                    title: '结束任务状态',
                    placeholder: 'quest_end_status',
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
                child: FoxyFormItem(
                  label: '光环',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.auraSpellController,
                    placeholder: 'aura_spell',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '种族掩码',
                  child: FoxyFlagPicker(
                    controller: viewModel.racemaskController,
                    flags: kAllowableRaceOptions,
                    title: '种族掩码',
                    placeholder: 'racemask',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '性别',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.genderController,
                    options: kSpellAreaGenderOptions,
                    placeholder: Text('gender'),
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '自动施放',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.autocastController,
                    options: kBooleanOptions,
                    placeholder: Text('autocast'),
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

  Future<bool> _load(SpellAreaKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) DialogUtil.instance.error('加载失败：$error');
      return false;
    }
  }

  Future<void> _destroy(SpellAreaKey key) async {
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
}
