import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/constant/gossip_menu_option_constants.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_option_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Tab 3：gossip_menu_option 双态（列表 / 表单）
class GossipMenuOptionView extends StatefulWidget {
  final int menuId;

  const GossipMenuOptionView({super.key, required this.menuId});

  @override
  State<GossipMenuOptionView> createState() => _GossipMenuOptionViewState();
}

class _GossipMenuOptionViewState extends State<GossipMenuOptionView> {
  final viewModel = GetIt.instance.get<GossipMenuOptionViewModel>();

  @override
  void initState() {
    super.initState();
    if (widget.menuId != 0) {
      viewModel.search(widget.menuId);
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      if (viewModel.editing.value || viewModel.creating.value) {
        return _buildForm();
      }
      return _buildList();
    });
  }

  Widget _buildList() {
    final createBtn = ShadButton(
      leading: Icon(LucideIcons.plus, size: 16),
      onPressed: viewModel.create,
      child: Text('新增'),
    );
    final toolbar = Row(children: [createBtn]);

    final options = viewModel.options.value;
    final headers = ['编号', '图标', '文本', '类型', 'NPC标识', '子选项'];
    final table = LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth - (80 + 120 + 120 + 120 + 120);
        return FoxyShadTable(
          shrinkWrap: true,
          columnCount: headers.length,
          rowCount: options.length,
          pinnedRowCount: 1,
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(80),
              1 => FixedTableSpanExtent(120),
              2 => FixedTableSpanExtent(width),
              3 => FixedTableSpanExtent(120),
              4 => FixedTableSpanExtent(120),
              5 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= options.length) {
              return ShadTableCell(child: SizedBox());
            }
            final o = options[vicinity.row];
            final iconName =
                kGossipOptionIcons[o.optionIcon] ?? o.optionIcon.toString();
            final typeName =
                kGossipOptionTypes[o.optionType] ?? o.optionType.toString();
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(o.optionId.toString())),
              1 => ShadTableCell(child: Text(iconName)),
              2 => ShadTableCell(
                child: Text(
                  o.displayText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              3 => ShadTableCell(child: Text(typeName)),
              4 => ShadTableCell(child: Text(o.optionNpcFlag.toString())),
              5 => ShadTableCell(child: Text(o.actionMenuId.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          onRowDoubleTap: (row) {
            final o = options[row];
            viewModel.edit(o.menuId, o.optionId);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            final o = options[row];
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => viewModel.edit(o.menuId, o.optionId),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.copy(o.menuId, o.optionId),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.delete(o.menuId, o.optionId),
                  child: Text('删除'),
                ),
              ],
            );
          },
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ShadCard(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(spacing: 16, children: [toolbar, table]),
      ),
    );
  }

  Widget _buildForm() {
    final iconOptions = kGossipOptionIcons;
    final typeOptions = kGossipOptionTypes;

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '选项信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: '编号',
                      child: FoxyNumberInput<int>(
                        fieldController: viewModel.optionIdController,
                        placeholder: 'OptionID',
                        readOnly: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '对话编号',
                      child: FoxyNumberInput<int>(
                        fieldController: viewModel.menuIdController,
                        placeholder: 'MenuID',
                        readOnly: true,
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: _labeled(
                      '类型',
                      FoxyShadSelect<int>(
                        fieldController: viewModel.optionTypeController,
                        options: typeOptions,
                        placeholder: const Text('OptionType'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      'NPC标识',
                      FoxyFlagPicker(
                        fieldController: viewModel.optionNpcFlagController,
                        flags: kNpcFlagOptions,
                        title: 'Npc标识编辑器',
                        placeholder: 'OptionNpcFlag',
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      '图标',
                      FoxyShadSelect<int>(
                        fieldController: viewModel.optionIconController,
                        options: iconOptions,
                        placeholder: const Text('OptionIcon'),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: '文本',
                      child: FoxyStringInput(
                        controller: viewModel.optionTextController,
                        placeholder: 'OptionText',
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      '子选项编号',
                      FoxyEntityPicker(
                        delegate: FoxyEntityPickerDelegates.gossipMenu,
                        fieldController: viewModel.actionMenuIdController,
                        placeholder: 'ActionMenuID',
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      '广播文本编号',
                      FoxyEntityPicker(
                        delegate: FoxyEntityPickerDelegates.broadcastText,
                        fieldController:
                            viewModel.optionBroadcastTextIdController,
                        placeholder: 'broadcast_text_id',
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: 'BoxMoney',
                      child: FoxyNumberInput<int>(
                        fieldController: viewModel.boxMoneyController,
                        placeholder: 'BoxMoney',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: 'BoxCoded',
                      child: FoxyNumberInput<int>(
                        fieldController: viewModel.boxCodedController,
                        placeholder: 'BoxCoded',
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      'BoxBroadcastTextID',
                      FoxyEntityPicker(
                        delegate: FoxyEntityPickerDelegates.broadcastText,
                        fieldController: viewModel.boxBroadcastTextIdController,
                        placeholder: 'box_broadcast_text_id',
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: 'BoxText',
                      child: FoxyStringInput(
                        controller: viewModel.boxTextController,
                        placeholder: 'BoxText',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: 'ActionPoiID',
                      child: FoxyNumberInput<int>(
                        fieldController: viewModel.actionPoiIdController,
                        placeholder: 'ActionPoiID',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: 'VerifiedBuild',
                      child: FoxyNumberInput<int>(
                        fieldController: viewModel.verifiedBuildController,
                        placeholder: 'VerifiedBuild',
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ShadButton(onPressed: viewModel.save, child: const Text('保存')),
              const SizedBox(width: 8),
              ShadButton.ghost(onPressed: viewModel.cancel, child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _labeled(String label, Widget child) {
    return FoxyFormItem(label: label, child: child);
  }
}
