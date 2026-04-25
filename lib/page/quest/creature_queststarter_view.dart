import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_selector.dart';
import 'package:foxy/page/quest/creature_queststarter_view_model.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class CreatureQueststarterView extends StatefulWidget {
  final QuestTemplateDetailViewModel parentViewModel;
  const CreatureQueststarterView({super.key, required this.parentViewModel});

  @override
  State<CreatureQueststarterView> createState() =>
      _CreatureQueststarterViewState();
}

class _CreatureQueststarterViewState extends State<CreatureQueststarterView> {
  final viewModel = GetIt.instance.get<CreatureQueststarterViewModel>();
  late final VoidCallback _disposer;

  @override
  void initState() {
    super.initState();
    final initialId = widget.parentViewModel.id.value;
    if (initialId != 0) {
      viewModel.search(initialId);
    }
    _disposer = effect(() {
      final questId = widget.parentViewModel.id.value;
      if (questId != 0 && questId != viewModel.currentQuestId.value) {
        viewModel.search(questId);
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

    final items = viewModel.items.value;
    final headers = ['编号', '名称'];

    final table = LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth - 120;
        return FoxyShadTable(
          columnCount: headers.length,
          rowCount: items.length,
          pinnedRowCount: 1,
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(width),
              _ => null,
            };
          },
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = items[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.id.toString())),
              1 => ShadTableCell(
                child: Text(
                  item.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          onRowDoubleTap: (row) {
            final item = items[row];
            viewModel.onEdit(item.id, item.quest);
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            final item = items[row];
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () => viewModel.onEdit(item.id, item.quest),
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.onCopy(item.id, item.quest),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.onDestroy(item.id, item.quest),
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
          children: [toolbar, SizedBox(height: 400, child: table)],
        ),
      ),
    );
  }

  Widget _buildForm() {
    final fields = <Widget>[
      Row(
        spacing: 16,
        children: [
          Expanded(
            child: FormItem(
              label: '生物编号',
              child: CreatureTemplateSelector(
                controller: viewModel.idController,
                placeholder: 'CreatureId',
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              controller: viewModel.questController,
              label: '任务编号',
              readOnly: true,
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
}