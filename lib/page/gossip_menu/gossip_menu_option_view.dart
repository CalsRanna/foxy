import 'package:flutter/material.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/constant/gossip_menu_option_constants.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_option_collection_editor_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
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
  final viewModel = GetIt.instance
      .get<GossipMenuOptionCollectionEditorViewModel>();

  @override
  void initState() {
    super.initState();
    if (widget.menuId != 0) {
      viewModel.initSignals(parentKey: widget.menuId);
    }
  }

  @override
  void didUpdateWidget(covariant GossipMenuOptionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.menuId != widget.menuId) {
      viewModel.setParentKey(widget.menuId);
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
      if (viewModel.formVisible.value) {
        return _buildForm();
      }
      return _buildList();
    });
  }

  Widget _buildList() {
    final createBtn = ShadButton(
      leading: Icon(LucideIcons.plus, size: 16),
      onPressed: _create,
      child: Text('新增'),
    );
    final toolbar = Row(
      children: [
        createBtn,
        const Spacer(),
        FoxyPagination(
          page: viewModel.page.value,
          pageSize: 50,
          total: viewModel.total.value,
          onChange: viewModel.paginate,
        ),
      ],
    );

    final options = viewModel.items.value;
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
            _edit(o.key);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            final o = options[row];
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => _edit(o.key),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => _copy(o.key),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => _destroy(o.key),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
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
                        controller: viewModel.optionIdController,
                        placeholder: 'OptionID',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '对话编号',
                      child: FoxyNumberInput<int>(
                        controller: viewModel.menuIdController,
                        placeholder: 'MenuID',
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      '类型',
                      FoxyShadSelect<int>(
                        controller: viewModel.optionTypeController,
                        options: kGossipOptionTypes,
                        placeholder: const Text('OptionType'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      '图标',
                      FoxyShadSelect<int>(
                        controller: viewModel.optionIconController,
                        options: kGossipOptionIcons,
                        placeholder: const Text('OptionIcon'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: _labeled(
                      'NPC标识',
                      FoxyFlagPicker(
                        controller: viewModel.optionNpcFlagController,
                        flags: kNpcFlagOptions,
                        title: 'Npc标识编辑器',
                        placeholder: 'OptionNpcFlag',
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      '子选项编号',
                      FoxyEntityPicker(
                        delegate: FoxyEntityPickerDelegates.gossipMenu,
                        controller: viewModel.actionMenuIdController,
                        placeholder: 'ActionMenuID',
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      '兴趣点',
                      FoxyEntityPicker(
                        delegate: FoxyEntityPickerDelegates.pointOfInterest,
                        controller: viewModel.actionPoiIdController,
                        placeholder: 'ActionPoiID',
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      '输入密码',
                      FoxyShadSelect<int>(
                        controller: viewModel.boxCodedController,
                        options: kGossipBooleanOptions,
                        placeholder: const Text('BoxCoded'),
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
                      label: '选项文本',
                      child: FoxyStringInput(
                        controller: viewModel.optionTextController,
                        placeholder: 'OptionText',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '选项文本（zhCN）',
                      child: FoxyStringInput(
                        controller: viewModel.localeOptionTextController,
                        placeholder: 'zhCN OptionText',
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      '选项广播文本',
                      FoxyEntityPicker(
                        delegate: FoxyEntityPickerDelegates.broadcastText,
                        controller: viewModel.optionBroadcastTextIdController,
                        placeholder: 'OptionBroadcastTextID',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: 'VerifiedBuild',
                      child: FoxyNumberInput<int>(
                        controller: viewModel.verifiedBuildController,
                        placeholder: 'VerifiedBuild',
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
                      label: '确认文本',
                      child: FoxyStringInput(
                        controller: viewModel.boxTextController,
                        placeholder: 'BoxText',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '确认文本（zhCN）',
                      child: FoxyStringInput(
                        controller: viewModel.localeBoxTextController,
                        placeholder: 'zhCN BoxText',
                      ),
                    ),
                  ),
                  Expanded(
                    child: _labeled(
                      '确认广播文本',
                      FoxyEntityPicker(
                        delegate: FoxyEntityPickerDelegates.broadcastText,
                        controller: viewModel.boxBroadcastTextIdController,
                        placeholder: 'BoxBroadcastTextID',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '所需铜币',
                      child: FoxyNumberInput<int>(
                        controller: viewModel.boxMoneyController,
                        placeholder: 'BoxMoney',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: _persist,
                  child: const Text('保存'),
                ),
              ),
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

  Future<void> _create() async {
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：$error');
    }
  }

  Future<void> _edit(GossipMenuOptionKey key) async {
    try {
      await viewModel.edit(key);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：$error');
    }
  }

  Future<void> _copy(GossipMenuOptionKey key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认复制',
      description: '确认复制该选项？',
      confirmText: '复制',
    );
    if (!confirmed) return;
    try {
      await viewModel.copy(key);
      if (!mounted) return;
      DialogUtil.instance.success('复制成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('复制失败：$error');
    }
  }

  Future<void> _destroy(GossipMenuOptionKey key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '将永久删除该选项，确认继续？',
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

  Future<void> _persist() async {
    try {
      await viewModel.persist();
      if (!mounted) return;
      DialogUtil.instance.success('保存成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('保存失败：$error');
    }
  }
}
