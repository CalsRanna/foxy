import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/constant/gossip_menu_option_constants.dart';
import 'package:foxy/page/creature_template/gossip_menu_selector.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_detail_view_model.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_option_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/flag_picker.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Tab 3：gossip_menu_option 双态（列表 / 表单）
class GossipMenuOptionView extends StatefulWidget {
  const GossipMenuOptionView({super.key});

  @override
  State<GossipMenuOptionView> createState() => _GossipMenuOptionViewState();
}

class _GossipMenuOptionViewState extends State<GossipMenuOptionView> {
  final viewModel = GetIt.instance.get<GossipMenuOptionViewModel>();
  final parentViewModel = GetIt.instance.get<GossipMenuDetailViewModel>();
  late final VoidCallback _disposer;

  @override
  void initState() {
    super.initState();
    final initialMenuId = parentViewModel.menuId.value;
    if (initialMenuId != 0) {
      viewModel.search(initialMenuId);
    }
    _disposer = effect(() {
      final menuId = parentViewModel.menuId.value;
      if (menuId != 0 && menuId != viewModel.currentMenuId.value) {
        viewModel.search(menuId);
      }
    });
  }

  @override
  void dispose() {
    _disposer();
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
      leading: Icon(LucideIcons.plus),
      onPressed: viewModel.onCreate,
      child: Text('新增'),
    );
    final toolbar = Row(children: [createBtn]);

    final options = viewModel.options.value;
    final headers = ['编号', '图标', '文本', '类型', 'NPC标识', '子选项'];
    final table = LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth - (80 + 120 + 120 + 120 + 120);
        return FoxyShadTable(
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
            viewModel.onEdit(o.menuId, o.optionId);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            final o = options[row];
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => viewModel.onEdit(o.menuId, o.optionId),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.onCopy(o.menuId, o.optionId),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.onDestroy(o.menuId, o.optionId),
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
        child: Column(
          spacing: 16,
          children: [
            toolbar,
            SizedBox(height: 400, child: table),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    final iconOptions = kGossipOptionIcons;
    final typeOptions = kGossipOptionTypes;

    final fields = <Widget>[
      Row(
        spacing: 16,
        children: [
          Expanded(child: _textField('编号', viewModel.optionIdController)),
          Expanded(child: _textField('对话编号', viewModel.menuIdController)),
        ],
      ),
      Row(
        spacing: 16,
        children: [
          Expanded(
            child: _labeled(
              '类型',
              FoxyShadSelect<int>(
                controller: viewModel.optionTypeController,
                options: typeOptions,
                placeholder: const Text('OptionType'),
              ),
            ),
          ),
          Expanded(
            child: _labeled(
              'NPC标识',
              FlagPicker(
                controller: viewModel.optionNpcFlagController,
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
                controller: viewModel.optionIconController,
                options: iconOptions,
                placeholder: const Text('OptionIcon'),
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 16,
        children: [
          Expanded(child: _textField('文本', viewModel.optionTextController)),
          Expanded(
            child: _labeled(
              '子选项编号',
              GossipMenuSelector(
                controller: viewModel.actionMenuIdController,
                placeholder: 'ActionMenuID',
              ),
            ),
          ),
          Expanded(
            child: _textField(
              '广播文本编号',
              viewModel.optionBroadcastTextIdController,
            ),
          ),
        ],
      ),
      Row(
        spacing: 16,
        children: [
          Expanded(child: _textField('BoxMoney', viewModel.boxMoneyController)),
          Expanded(child: _textField('BoxCoded', viewModel.boxCodedController)),
          Expanded(
            child: _textField(
              'BoxBroadcastTextID',
              viewModel.boxBroadcastTextIdController,
            ),
          ),
        ],
      ),
      Row(
        spacing: 16,
        children: [
          Expanded(child: _textField('BoxText', viewModel.boxTextController)),
          Expanded(
            child: _textField('ActionPoiID', viewModel.actionPoiIdController),
          ),
          Expanded(
            child: _textField(
              'VerifiedBuild',
              viewModel.verifiedBuildController,
            ),
          ),
        ],
      ),
    ];

    final form = ShadCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields,
      ),
    );

    final saveBtn = Watch((_) {
      return ShadButton(
        enabled: !viewModel.saving.value,
        onPressed: viewModel.onSave,
        child: Text(viewModel.saving.value ? '保存中...' : '保存'),
      );
    });
    final cancelBtn = ShadButton.outline(
      onPressed: viewModel.onCancel,
      child: Text('返回'),
    );
    final actions = ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 8, children: [saveBtn, cancelBtn]),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(spacing: 16, children: [form, actions]),
    );
  }

  Widget _textField(String label, TextEditingController c) {
    return _labeled(label, ShadInput(controller: c, placeholder: Text(label)));
  }

  Widget _labeled(String label, Widget child) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(label), child],
    );
  }
}
