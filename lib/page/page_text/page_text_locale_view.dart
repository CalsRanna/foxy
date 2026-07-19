import 'package:flutter/material.dart';
import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/page/page_text/page_text_locale_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PageTextLocaleView extends StatefulWidget {
  final int? id;

  const PageTextLocaleView({super.key, this.id});

  @override
  State<PageTextLocaleView> createState() => _PageTextLocaleViewState();
}

class _PageTextLocaleViewState extends State<PageTextLocaleView> {
  final viewModel = GetIt.instance.get<PageTextLocaleViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(id: widget.id);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PageTextLocaleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      viewModel.initSignals(id: widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final rows = viewModel.rows.value;
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            for (final row in rows)
              ShadCard(
                key: ObjectKey(row),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: FoxyFormItem(
                            label: '编号',
                            child: FoxyNumberInput<int>(
                              controller: row.idController,
                              placeholder: 'ID',
                            ),
                          ),
                        ),
                        Expanded(
                          child: FoxyFormItem(
                            label: '语言',
                            child: FoxyShadSelect<String>(
                              controller: row.localeController,
                              options: kPageTextLocaleOptions,
                              placeholder: const Text('locale'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FoxyFormItem(
                            label: '文本',
                            child: FoxyStringInput(
                              controller: row.textController,
                              placeholder: 'Text',
                            ),
                          ),
                        ),
                        Expanded(
                          child: FoxyFormItem(
                            label: 'VerifiedBuild',
                            child: FoxyNumberInput<int>(
                              controller: row.verifiedBuildController,
                              placeholder: 'VerifiedBuild',
                            ),
                          ),
                        ),
                      ],
                    ),
                    ShadButton.destructive(
                      size: ShadButtonSize.sm,
                      onPressed: () => viewModel.removeLocale(row),
                      child: const Icon(LucideIcons.trash, size: 14),
                    ),
                  ],
                ),
              ),
            Row(
              spacing: 8,
              children: [
                ShadButton.outline(
                  leading: const Icon(LucideIcons.plus, size: 14),
                  onPressed: viewModel.addLocale,
                  child: const Text('添加本地化'),
                ),
                ShadButton(
                  onPressed: () => viewModel.save(context),
                  child: const Text('保存'),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
