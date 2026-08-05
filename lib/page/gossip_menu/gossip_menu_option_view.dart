import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/constant/gossip_menu_option_constants.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/gossip_menu_option_linked_list_view_model.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Tab 3: gossip_menu_option dual-mode (list / form)
class GossipMenuOptionView extends StatefulWidget {
  final int menuId;

  const GossipMenuOptionView({super.key, required this.menuId});

  @override
  State<GossipMenuOptionView> createState() => _GossipMenuOptionViewState();
}

class _GossipMenuOptionViewState extends State<GossipMenuOptionView> {
  final viewModel = GetIt.instance.get<GossipMenuOptionLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      if (viewModel.formVisible.value) {
        return _buildForm();
      }
      return _buildList();
    });
  }

  @override
  void didUpdateWidget(covariant GossipMenuOptionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.menuId != widget.menuId) {
      viewModel.setLinkKey(widget.menuId);
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
    if (widget.menuId != 0) {
      viewModel.initSignals(linkKey: widget.menuId);
    }
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
                      label: '选项中文',
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
                      label: '验证版本',
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
                      label: '确认中文',
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

    final table = FoxyDataTable<BriefGossipMenuOptionEntity>(
      shrinkWrap: true,
      pinnedRowCount: 1,
      rows: options,
      columns: [
        FoxyTableColumn.fixed(
          label: '编号',
          width: 120,
          cell: (_, o) => Text(o.optionId.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '图标',
          width: 120,
          cell: (_, o) =>
              Text(kGossipOptionIcons[o.optionIcon] ?? o.optionIcon.toString()),
        ),
        FoxyTableColumn.flex(
          label: '文本',
          cell: (_, o) => Text(
            o.displayText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        FoxyTableColumn.fixed(
          label: '类型',
          width: 120,
          cell: (_, o) =>
              Text(kGossipOptionTypes[o.optionType] ?? o.optionType.toString()),
        ),
        FoxyTableColumn.fixed(
          label: 'NPC标识',
          width: 120,
          cell: (_, o) => Text(o.optionNpcFlag.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '子选项',
          width: 120,
          cell: (_, o) => Text(o.actionMenuId.toString()),
        ),
      ],
      onRowDoubleTap: (o) => _edit(o.key),
      onRowSecondaryTapDownWithDetails: (o, details) {
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

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ShadCard(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          spacing: 16,
          children: [
            if (viewModel.errorMessage.value != null)
              FoxyInlineError(message: viewModel.errorMessage.value),
            toolbar,
            table,
          ],
        ),
      ),
    );
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
      DialogUtil.instance.error('复制失败：${foxyErrorMessage(error)}');
    }
  }

  Future<void> _create() async {
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：${foxyErrorMessage(error)}');
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
      DialogUtil.instance.error('删除失败：${foxyErrorMessage(error)}');
    }
  }

  Future<void> _edit(GossipMenuOptionKey key) async {
    try {
      await viewModel.edit(key);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${foxyErrorMessage(error)}');
    }
  }

  Widget _labeled(String label, Widget child) {
    return FoxyFormItem(label: label, child: child);
  }

  Future<void> _persist() async {
    try {
      await viewModel.persist();
      if (!mounted) return;
      DialogUtil.instance.success('保存成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('保存失败：${foxyErrorMessage(error)}');
    }
  }
}
