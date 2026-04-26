import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/constant/smart_script_constants.dart';
import 'package:foxy/page/smart_script/smart_script_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class SmartScriptListPage extends StatefulWidget {
  const SmartScriptListPage({super.key});

  @override
  State<SmartScriptListPage> createState() => _SmartScriptListPageState();
}

class _SmartScriptListPageState extends State<SmartScriptListPage> {
  final viewModel = GetIt.instance.get<SmartScriptListViewModel>();

  @override
  Widget build(BuildContext context) {
    final children = [
      FoxyHeader('脚本列表'),
      _buildFilter(),
      Expanded(child: Watch((_) => _buildTable())),
    ];
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: children,
    );
    return Padding(padding: const EdgeInsets.all(16.0), child: column);
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  Widget _buildFilter() {
    var entryInput = ShadInput(
      controller: viewModel.entryOrGuidController,
      placeholder: Text('实体编号（entryorguid）'),
    );
    var commentInput = ShadInput(
      controller: viewModel.commentController,
      placeholder: Text('备注（comment）'),
    );
    var searchButton = ShadButton(
      onPressed: viewModel.search,
      size: ShadButtonSize.sm,
      child: Text('查询'),
    );
    var resetButton = ShadButton.ghost(
      onPressed: viewModel.reset,
      size: ShadButtonSize.sm,
      child: Text('重置'),
    );
    var row = Row(spacing: 16, children: [searchButton, resetButton]);
    final credentialChildren = [
      Expanded(child: entryInput),
      Expanded(child: commentInput),
      Expanded(flex: 2, child: row),
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 16, children: credentialChildren),
    );
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      leading: Icon(LucideIcons.plus),
      onPressed: () => viewModel.navigateToDetail(),
      child: Text('新增'),
    );
    final templates = viewModel.templates.value;
    final page = viewModel.page.value;
    final total = viewModel.total.value;
    var pagination = FoxyPagination(
      page: page,
      pageSize: 50,
      total: total,
      onChange: viewModel.paginate,
    );
    final toolbarChildren = [createButton, const Spacer(), pagination];
    final toolbar = Row(children: toolbarChildren);

    final headers = ['编号', '源类型', 'ID', '链接', '事件类型', '动作类型', '目标类型', '备注'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var commentWidth = constraints.maxWidth - 960;
        return FoxyShadTable(
          builder: (context, vicinity) {
            final script = templates[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(script.entryOrGuid.toString())),
              1 => ShadTableCell(
                child: Text(
                  kSourceTypes[script.sourceType] ??
                      script.sourceType.toString(),
                ),
              ),
              2 => ShadTableCell(child: Text(script.id.toString())),
              3 => ShadTableCell(child: Text(script.link.toString())),
              4 => ShadTableCell(
                child: Text(
                  kEventTypes[script.eventType] ?? script.eventType.toString(),
                ),
              ),
              5 => ShadTableCell(
                child: Text(
                  kActionTypes[script.actionType] ??
                      script.actionType.toString(),
                ),
              ),
              6 => ShadTableCell(
                child: Text(
                  kTargetTypes[script.targetType] ??
                      script.targetType.toString(),
                ),
              ),
              7 => ShadTableCell(
                child: Text(
                  script.comment,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(240),
              2 => FixedTableSpanExtent(120),
              3 => FixedTableSpanExtent(120),
              4 => FixedTableSpanExtent(120),
              5 => FixedTableSpanExtent(120),
              6 => FixedTableSpanExtent(120),
              7 => FixedTableSpanExtent(commentWidth),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowDoubleTap: (row) {
            final s = templates[row];
            viewModel.navigateToDetail(
              entryOrGuid: s.entryOrGuid,
              sourceType: s.sourceType,
              id: s.id,
              link: s.link,
            );
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            final s = templates[row];
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    viewModel.navigateToDetail(
                      entryOrGuid: s.entryOrGuid,
                      sourceType: s.sourceType,
                      id: s.id,
                      link: s.link,
                    );
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () {
                    viewModel.copySmartScript(
                      s.entryOrGuid,
                      s.sourceType,
                      s.id,
                      s.link,
                    );
                  },
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () {
                    viewModel.deleteSmartScript(
                      s.entryOrGuid,
                      s.sourceType,
                      s.id,
                      s.link,
                    );
                  },
                  child: Text('删除'),
                ),
              ],
            );
          },
          pinnedRowCount: 1,
          rowCount: templates.length,
        );
      },
    );

    var children = [toolbar, Expanded(child: layoutBuilder)];
    final column = Column(spacing: 16, children: children);
    return ShadCard(padding: EdgeInsets.fromLTRB(16, 16, 16, 0), child: column);
  }
}
