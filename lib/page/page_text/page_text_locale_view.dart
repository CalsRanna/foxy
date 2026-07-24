import 'package:flutter/material.dart';
import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/page/page_text/page_text_locale_collection_editor_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
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

class PageTextLocaleView extends StatefulWidget {
  final int? id;

  const PageTextLocaleView({super.key, this.id});

  @override
  State<PageTextLocaleView> createState() => _PageTextLocaleViewState();
}

class _PageTextLocaleViewState extends State<PageTextLocaleView> {
  final viewModel = GetIt.instance
      .get<PageTextLocaleCollectionEditorViewModel>();

  @override
  void initState() {
    super.initState();
    final id = widget.id;
    if (id != null) viewModel.initSignals(parentKey: id);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PageTextLocaleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final id = widget.id;
    if (id != null && oldWidget.id != id) {
      viewModel.setParentKey(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final items = viewModel.items.value;
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          spacing: 16,
          children: [
            Row(
              children: [
                ShadButton(
                  leading: const Icon(LucideIcons.plus, size: 14),
                  onPressed: _create,
                  child: const Text('新增本地化'),
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
            FoxyShadTable(
              shrinkWrap: true,
              pinnedRowCount: 1,
              columnCount: 4,
              rowCount: items.length,
              header: (context, index) => ShadTableCell.header(
                child: Text(['编号', '语言', '文本', 'VerifiedBuild'][index]),
              ),
              columnSpanExtent: (index) => switch (index) {
                0 => const FixedTableSpanExtent(120),
                1 => const FixedTableSpanExtent(120),
                2 => const FixedTableSpanExtent(360),
                3 => const FixedTableSpanExtent(140),
                _ => null,
              },
              builder: (context, vicinity) {
                if (vicinity.row < 0 || vicinity.row >= items.length) {
                  return const ShadTableCell(child: SizedBox());
                }
                final item = items[vicinity.row];
                return switch (vicinity.column) {
                  0 => ShadTableCell(child: Text(item.id.toString())),
                  1 => ShadTableCell(
                    child: Text(
                      kPageTextLocaleOptions[item.locale] ?? item.locale,
                    ),
                  ),
                  2 => ShadTableCell(
                    child: Text(
                      item.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  3 => ShadTableCell(
                    child: Text(item.verifiedBuild.toString()),
                  ),
                  _ => const ShadTableCell(child: SizedBox()),
                };
              },
              onRowDoubleTap: (row) => _edit(items[row].key),
              onRowSecondaryTapDownWithDetails: (row, details) {
                final key = items[row].key;
                showFoxyContextMenu(
                  context: context,
                  position: details.globalPosition,
                  items: [
                    ShadContextMenuItem(
                      leading: const Icon(LucideIcons.squarePen, size: 16),
                      onPressed: () => _edit(key),
                      child: const Text('编辑'),
                    ),
                    ShadContextMenuItem(
                      leading: const Icon(LucideIcons.trash, size: 16),
                      onPressed: () => _destroy(key),
                      child: const Text('删除'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Future<void> _create() async {
    try {
      await viewModel.create();
      if (!mounted) return;
      _showEditor();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：$error');
    }
  }

  Future<void> _edit(PageTextLocaleKey key) async {
    try {
      await viewModel.edit(key);
      if (!mounted) return;
      _showEditor();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：$error');
    }
  }

  Future<void> _destroy(PageTextLocaleKey key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '将永久删除该本地化记录，确认继续？',
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

  void _showEditor() {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text(viewModel.editingKey.value == null ? '新增本地化' : '编辑本地化'),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: '编号',
                      child: FoxyNumberInput<int>(
                        controller: viewModel.idController,
                        placeholder: 'ID',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '语言',
                      child: FoxyShadSelect<String>(
                        controller: viewModel.localeController,
                        options: kPageTextLocaleOptions,
                        placeholder: const Text('locale'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '文本',
                      child: FoxyStringInput(
                        controller: viewModel.textController,
                        placeholder: 'Text',
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
              const SizedBox(height: 24),
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
                      onPressed: () => _persist(dialogContext),
                      child: const Text('保存'),
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

  Future<void> _persist(BuildContext dialogContext) async {
    try {
      await viewModel.persist();
      if (!dialogContext.mounted) return;
      Navigator.of(dialogContext).pop();
      DialogUtil.instance.success('保存成功');
    } catch (error) {
      if (!dialogContext.mounted) return;
      DialogUtil.instance.error('保存失败：$error');
    }
  }
}
