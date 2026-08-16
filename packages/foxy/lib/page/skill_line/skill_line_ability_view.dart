import 'package:flutter/material.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/constant/skill_line_constants.dart';
import 'package:foxy/entity/skill_line_ability_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/skill_line_ability_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_icon_text.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class SkillLineAbilityView extends StatefulWidget {
  final int skillLineId;

  const SkillLineAbilityView({super.key, required this.skillLineId});

  @override
  State<SkillLineAbilityView> createState() => _SkillLineAbilityViewState();
}

class _SkillLineAbilityViewState extends State<SkillLineAbilityView> {
  final viewModel = GetIt.instance.get<SkillLineAbilityLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return _buildTable();
    });
  }

  @override
  void didUpdateWidget(covariant SkillLineAbilityView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.skillLineId != widget.skillLineId) {
      viewModel.setLinkKey(widget.skillLineId);
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
    viewModel.initSignals(linkKey: widget.skillLineId);
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.selectedKey.value != null;

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
                  label: '专业技能',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.skillLineController,
                    placeholder: 'SkillLine',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '法术',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.spell,
                    controller: viewModel.spellController,
                    placeholder: 'Spell',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '获得方式',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.acquireMethodController,
                    options: SkillLineConstants.skillAcquireMethodOptions,
                    placeholder: const Text('AcquireMethod'),
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
                  label: '最低技能等级',
                  child: FoxyNumberInput<int>(
                    placeholder: 'MinSkillLineRank',
                    controller: viewModel.minSkillLineRankController,
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '种族掩码',
                  child: FoxyFlagPicker(
                    controller: viewModel.raceMaskController,
                    flags: PlayerCreateInfoConstants.playerCreateRaceMaskFlags,
                    title: '种族掩码',
                    placeholder: 'RaceMask',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '职业掩码',
                  child: FoxyFlagPicker(
                    controller: viewModel.classMaskController,
                    flags: PlayerCreateInfoConstants.playerCreateClassMaskFlags,
                    title: '职业掩码',
                    placeholder: 'ClassMask',
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
                  label: '排除种族',
                  child: FoxyFlagPicker(
                    controller: viewModel.excludeRaceController,
                    flags: PlayerCreateInfoConstants.playerCreateRaceMaskFlags,
                    title: '排除种族',
                    placeholder: 'ExcludeRace',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '排除职业',
                  child: FoxyFlagPicker(
                    controller: viewModel.excludeClassController,
                    flags: PlayerCreateInfoConstants.playerCreateClassMaskFlags,
                    title: '排除职业',
                    placeholder: 'ExcludeClass',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '取代法术',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.spell,
                    controller: viewModel.supercededBySpellController,
                    placeholder: 'SupercededBySpell',
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
                  label: '高等级上限',
                  child: FoxyNumberInput<int>(
                    placeholder: 'TrivialSkillLineRankHigh',
                    controller: viewModel.trivialSkillLineRankHighController,
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '低等级上限',
                  child: FoxyNumberInput<int>(
                    placeholder: 'TrivialSkillLineRankLow',
                    controller: viewModel.trivialSkillLineRankLowController,
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '角色点数1',
                  child: FoxyNumberInput<int>(
                    placeholder: 'CharacterPoints0',
                    controller: viewModel.characterPoints0Controller,
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
                  label: '角色点数2',
                  child: FoxyNumberInput<int>(
                    placeholder: 'CharacterPoints1',
                    controller: viewModel.characterPoints1Controller,
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

    final table = FoxyDataTable<BriefSkillLineAbilityEntity>(
      shrinkWrap: true,
      rows: items,
      columns: [
        FoxyTableColumn.fixed(
          label: '编号',
          width: 120,
          cell: (_, item) => Text(item.id.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '获得方式',
          width: 120,
          cell: (_, item) => Text(
            SkillLineConstants.skillAcquireMethodOptions[item.acquireMethod] ??
                item.acquireMethod.toString(),
          ),
        ),
        FoxyTableColumn.fixed(
          label: '最低技能等级',
          width: 140,
          cell: (_, item) => Text(item.minSkillLineRank.toString()),
        ),
        FoxyTableColumn.flex(
          label: '法术',
          cell: (_, item) => FoxyIconText(
            iconPath: item.textureFilename,
            name: item.displaySpellName,
          ),
        ),
        FoxyTableColumn.flex(
          label: '描述',
          cell: (_, item) => Text(
            item.displaySpellDescription,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
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

  Future<void> _copy(SkillLineAbilityKey key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认复制',
      description: '确定要复制这条记录吗？',
      confirmText: '复制',
    );
    if (!confirmed) return;
    try {
      await viewModel.copy(key);
      if (!mounted) return;
      DialogUtil.instance.success('复制成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('复制失败：${FoxyExceptions.message(error)}');
    }
  }

  Future<void> _destroy(SkillLineAbilityKey key) async {
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

  Future<bool> _load(SkillLineAbilityKey key) async {
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
      builder: (dialogContext) => ShadDialog(
        title: Text('新增技能能力'),
        description: Text('新增一条技能能力记录'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: DialogUtil.constraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑技能能力'),
        description: Text('编辑选中的技能能力记录'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: DialogUtil.constraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }
}
