import 'package:flutter/material.dart';
import 'package:foxy/entity/player_create_info_item_key.dart';
import 'package:foxy/entity/player_create_info_key.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/brief_player_create_info_item_entity.dart';
import 'package:foxy/page/player_create_info/player_create_info_item_collection_editor_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

class PlayerCreateInfoItemView extends StatefulWidget {
  final int? race;
  final int? playerClass;

  const PlayerCreateInfoItemView({super.key, this.race, this.playerClass});

  @override
  State<PlayerCreateInfoItemView> createState() =>
      _PlayerCreateInfoItemViewState();
}

class _PlayerCreateInfoItemViewState extends State<PlayerCreateInfoItemView> {
  final viewModel = GetIt.instance
      .get<PlayerCreateInfoItemCollectionEditorViewModel>();

  @override
  void initState() {
    super.initState();
    final race = widget.race;
    final playerClass = widget.playerClass;
    if (race == null || playerClass == null) return;
    viewModel.initSignals(
      parentKey: PlayerCreateInfoKey(race: race, class_: playerClass),
    );
  }

  @override
  void didUpdateWidget(covariant PlayerCreateInfoItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.race != widget.race ||
        oldWidget.playerClass != widget.playerClass) {
      final race = widget.race;
      final playerClass = widget.playerClass;
      if (race == null || playerClass == null) return;
      viewModel.setParentKey(
        PlayerCreateInfoKey(race: race, class_: playerClass),
      );
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Watch(
    (_) => Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        spacing: 16,
        children: [
          Row(
            children: [
              ShadButton(
                onPressed: widget.race == null || widget.playerClass == null
                    ? null
                    : _showCreateDialog,
                child: const Text('新增'),
              ),
              const Spacer(),
              FoxyPagination(
                page: viewModel.page.value,
                pageSize: 50,
                total: viewModel.total.value,
                onChange: viewModel.paginate,
              ),
            ],
          ),
          _buildTable(),
        ],
      ),
    ),
  );

  Widget _buildTable() {
    final items = viewModel.items.value;
    return LayoutBuilder(
      builder: (context, constraints) {
        final flexWidth = constraints.maxWidth - 480;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final item = items[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.race.toString())),
              1 => ShadTableCell(child: Text(item.class_.toString())),
              2 => ShadTableCell(child: Text(item.itemId.toString())),
              3 => ShadTableCell(child: Text(item.amount.toString())),
              4 => ShadTableCell(child: Text(item.note)),
              _ => const ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: 5,
          columnSpanExtent: (index) => switch (index) {
            0 => const FixedTableSpanExtent(120),
            1 => const FixedTableSpanExtent(120),
            2 => const FixedTableSpanExtent(120),
            3 => const FixedTableSpanExtent(120),
            _ => FixedTableSpanExtent(flexWidth > 120 ? flexWidth : 120),
          },
          header: (context, index) => ShadTableCell.header(
            child: Text(['种族', '职业', '物品ID', '数量', '备注'][index]),
          ),
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: const Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => _showEditDialog(items[row]),
                  child: const Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: const Icon(LucideIcons.trash, size: 16),
                  onPressed: () => _destroy(items[row].key),
                  child: const Text('删除'),
                ),
              ],
            );
          },
          rowCount: items.length,
          shrinkWrap: true,
        );
      },
    );
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
    _showDialog(isEditing: false);
  }

  Future<void> _showEditDialog(BriefPlayerCreateInfoItemEntity item) async {
    if (!await _load(item.key)) return;
    if (!mounted) return;
    _showDialog(isEditing: true);
  }

  void _showDialog({required bool isEditing}) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text(isEditing ? '编辑起始物品' : '新增起始物品'),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: '种族',
                      child: FoxyIntShadSelect(
                        controller: viewModel.raceController,
                        options: kPlayerRaceOptions,
                        placeholder: const Text('race'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '职业',
                      child: FoxyIntShadSelect(
                        controller: viewModel.classController,
                        options: kPlayerClassOptions,
                        placeholder: const Text('class'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '物品ID',
                      child: FoxyEntityPicker(
                        placeholder: 'itemid',
                        controller: viewModel.itemIdController,
                        delegate: FoxyEntityPickerDelegates.itemTemplate,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '数量',
                      child: FoxyNumberInput<int>(
                        placeholder: 'amount',
                        controller: viewModel.amountController,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: '备注',
                      child: FoxyStringInput(
                        controller: viewModel.noteController,
                        placeholder: 'Note',
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const Expanded(child: SizedBox()),
                  const Expanded(child: SizedBox()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShadButton.outline(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: const Text('取消'),
                  ),
                  const SizedBox(width: 8),
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
        ),
      ),
    );
  }

  Future<bool> _load(PlayerCreateInfoItemKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) DialogUtil.instance.error('加载失败：$error');
      return false;
    }
  }

  Future<void> _destroy(PlayerCreateInfoItemKey key) async {
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
