import 'package:flutter/material.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/page/player_create_info/player_create_info_action_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PlayerCreateInfoActionView extends StatefulWidget {
  final int? race;
  final int? playerClass;
  const PlayerCreateInfoActionView({super.key, this.race, this.playerClass});

  @override
  State<PlayerCreateInfoActionView> createState() =>
      _PlayerCreateInfoActionViewState();
}

class _PlayerCreateInfoActionViewState
    extends State<PlayerCreateInfoActionView> {
  final viewModel = GetIt.instance.get<PlayerCreateInfoActionViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(race: widget.race, class_: widget.playerClass);
  }

  @override
  void didUpdateWidget(covariant PlayerCreateInfoActionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.race != widget.race ||
        oldWidget.playerClass != widget.playerClass) {
      viewModel.setParent(race: widget.race, class_: widget.playerClass);
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch(
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
                  child: Text('新增'),
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
  }

  Widget _buildTable() {
    final actions = viewModel.actions.value;
    final headers = ['按钮', '动作', '类型'];

    return LayoutBuilder(
      builder: (context, constraints) {
        var flexWidth = constraints.maxWidth - 240;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final item = actions[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.button.toString())),
              1 => ShadTableCell(child: Text(item.action.toString())),
              2 => ShadTableCell(child: Text(item.type.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) => switch (index) {
            0 => FixedTableSpanExtent(120),
            1 => FixedTableSpanExtent(120),
            _ => FixedTableSpanExtent(flexWidth > 120 ? flexWidth : 120),
          },
          header: (context, index) =>
              ShadTableCell.header(child: Text(headers[index])),
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () async {
                    if (await viewModel.edit(actions[row]) && context.mounted) {
                      _showDialog(isEditing: true);
                    }
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.delete(context, actions[row]),
                  child: Text('删除'),
                ),
              ],
            );
          },
          rowCount: actions.length,
          shrinkWrap: true,
        );
      },
    );
  }

  Future<void> _showCreateDialog() async {
    if (!await viewModel.create() || !mounted) return;
    _showDialog(isEditing: false);
  }

  void _showDialog({required bool isEditing}) {
    showFoxyDialog(
      context: context,
      builder: (c) => _buildDialog(c, isEditing: isEditing),
    );
  }

  Widget _buildDialog(BuildContext dialogContext, {required bool isEditing}) {
    return ShadDialog(
      title: Text(isEditing ? '编辑动作' : '新增动作'),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 960),
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
                    label: '按钮',
                    child: FoxyNumberInput<int>(
                      placeholder: 'button (0..143)',
                      controller: viewModel.buttonController,
                    ),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '动作',
                    child: Watch((_) => _buildActionInput()),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: FoxyFormItem(
                    label: '类型',
                    child: FoxyIntShadSelect(
                      controller: viewModel.typeController,
                      options: kPlayerActionButtonTypeOptions,
                      placeholder: const Text('type'),
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
      ),
    );
  }

  Widget _buildActionInput() {
    return switch (viewModel.actionType.value) {
      0 => FoxyEntityPicker(
        controller: viewModel.actionController,
        delegate: FoxyEntityPickerDelegates.spell,
        placeholder: 'action (Spell.dbc)',
      ),
      128 => FoxyEntityPicker(
        controller: viewModel.actionController,
        delegate: FoxyEntityPickerDelegates.itemTemplate,
        placeholder: 'action (item_template)',
      ),
      _ => FoxyNumberInput<int>(
        placeholder: 'action (0..16777215)',
        controller: viewModel.actionController,
      ),
    };
  }
}
