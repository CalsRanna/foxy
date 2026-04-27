import 'package:flutter/material.dart';
import 'package:foxy/page/page_text/page_text_locale_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
  Widget build(BuildContext context) {
    return Watch((_) {
      final locales = viewModel.locales.value;
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            ...locales.asMap().entries.map((entry) {
              final idx = entry.key;
              final locale = entry.value;
              return ShadCard(
                padding: EdgeInsets.all(16),
                child: Column(
                  spacing: 8,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: FormItem(
                            controller: viewModel.localeController(idx),
                            label: locale.locale,
                            placeholder: locale.locale,
                          ),
                        ),
                        ShadButton.destructive(
                          size: ShadButtonSize.sm,
                          onPressed: () => viewModel.removeLocale(idx),
                          child: Icon(LucideIcons.trash, size: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            ShadButton.outline(
              leading: Icon(LucideIcons.plus, size: 14),
              onPressed: () => viewModel.addLocale(),
              child: Text('添加本地化'),
            ),
            ShadButton(
              onPressed: () => viewModel.save(context),
              child: Text('保存'),
            ),
          ],
        ),
      );
    });
  }
}
