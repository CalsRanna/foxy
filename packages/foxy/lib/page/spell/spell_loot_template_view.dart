import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/spell_loot_template_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:foxy/widget/foxy_form_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class SpellLootTemplateView extends StatefulWidget {
  final int spellId;

  const SpellLootTemplateView({super.key, required this.spellId});

  @override
  State<SpellLootTemplateView> createState() => _SpellLootTemplateViewState();
}

class _SpellLootTemplateViewState extends State<SpellLootTemplateView> {
  final viewModel = GetIt.instance.get<SpellLootTemplateLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return _buildTable();
    });
  }

  @override
  void didUpdateWidget(covariant SpellLootTemplateView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spellId != widget.spellId) {
      viewModel.setLinkKey(widget.spellId);
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(linkKey: widget.spellId);
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editingKey.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: DialogUtil.width),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '编号',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.entryController,
                    placeholder: 'Entry',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '物品',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.itemTemplate,
                    controller: viewModel.itemController,
                    placeholder: 'Item',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '关联',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.referenceLoot,
                    controller: viewModel.referenceController,
                    placeholder: 'Reference',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '几率',
                  child: FoxyNumberInput<double>(
                    controller: viewModel.chanceController,
                    placeholder: 'Chance',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '需要任务',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.questRequiredController,
                    options: CreatureEnums.booleanOptions,
                    placeholder: 'QuestRequired',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '掉落模式',
                  child: FoxyFlagPicker(
                    controller: viewModel.lootModeController,
                    flags: CreatureFlags.lootModeFlagOptions,
                    title: '掉落模式',
                    placeholder: 'LootMode',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '组ID',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.groupIdController,
                    placeholder: 'GroupId',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '最小数量',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.minCountController,
                    placeholder: 'MinCount',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '最大数量',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.maxCountController,
                    placeholder: 'MaxCount',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '注解',
                  child: FoxyStringInput(
                    controller: viewModel.commentController,
                    placeholder: 'Comment',
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              const Expanded(child: SizedBox()),
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
                      DialogUtil.instance.error(
                        '保存失败：${FoxyExceptions.message(error)}',
                      );
                      return;
                    }
                    if (!dialogContext.mounted) return;
                    DialogUtil.instance.success('保存成功');
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

    final table = FoxyDataTable<BriefSpellLootTemplateEntity>(
      shrinkWrap: true,
      rows: items,
      columns: [
        FoxyTableColumn.fixed(
          label: '编号',
          width: 120,
          cell: (_, item) => Text(item.item.toString()),
        ),
        // Previously `flexWidth * 0.4` (a leftover approximation that left
        // the table under-full); now the name column fills the remaining
        // width like other loot tables.
        FoxyTableColumn.flex(
          label: '名称',
          cell: (_, item) {
            final displayName = item.localeName.isNotEmpty
                ? item.localeName
                : item.itemName;
            return Text(displayName);
          },
        ),
        FoxyTableColumn.fixed(
          label: '关联',
          width: 120,
          cell: (_, item) => Text(item.reference.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '几率',
          width: 120,
          cell: (_, item) => Text('${item.chance.toString()}%'),
        ),
        FoxyTableColumn.fixed(
          label: '需要任务',
          width: 120,
          cell: (_, item) => Text(item.questRequired == 1 ? '是' : '否'),
        ),
        FoxyTableColumn.fixed(
          label: '最小数量',
          width: 120,
          cell: (_, item) => Text(item.minCount.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '最大数量',
          width: 120,
          cell: (_, item) => Text(item.maxCount.toString()),
        ),
      ],
      onRowDoubleTap: (item) async {
        viewModel.selectedKey.value = item.key;
        if (!await _load(viewModel.selectedKey.value!)) return;
        if (!mounted) return;
        _showEditDialog(context);
      },
      onRowSecondaryTapDownWithDetails: (item, details) {
        viewModel.selectedKey.value = item.key;
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () async {
                if (!await _load(viewModel.selectedKey.value!)) return;
                if (!mounted) return;
                _showEditDialog(context);
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
    );

    var children = [
      if (viewModel.errorMessage.value != null)
        FoxyInlineError(message: viewModel.errorMessage.value),
      toolbar,
      table,
    ];
    final column = Column(spacing: 16, children: children);
    return Padding(padding: const EdgeInsets.only(top: 16), child: column);
  }

  Future<void> _destroy(SpellLootTemplateKey key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '确定要删除这条记录吗？此操作不可撤销。',
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
      DialogUtil.instance.error('删除失败：${FoxyExceptions.message(error)}');
    }
  }

  Future<bool> _load(SpellLootTemplateKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) {
        DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
      }
      return false;
    }
  }

  Future<void> _showCreateDialog() async {
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：${FoxyExceptions.message(error)}');
      return;
    }
    if (!mounted) return;
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => FoxyFormDialog(
        title: '新增技能掉落',
        description: '新增一条技能掉落记录',
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => FoxyFormDialog(
        title: '编辑技能掉落',
        description: '编辑选中的技能掉落记录',
        child: _buildDialogForm(dialogContext),
      ),
    );
  }
}
