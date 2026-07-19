import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/page_text_key.dart';
import 'package:foxy/page/page_text/page_text_detail_view_model.dart';
import 'package:foxy/page/page_text/page_text_view.dart';
import 'package:foxy/page/page_text/page_text_locale_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class TextContentDetailPage extends StatefulWidget {
  final PageTextKey? pageTextKey;

  const TextContentDetailPage({super.key, this.pageTextKey});

  @override
  State<TextContentDetailPage> createState() => _TextContentDetailPageState();
}

class _TextContentDetailPageState extends State<TextContentDetailPage> {
  final viewModel = GetIt.instance.get<PageTextDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.pageTextKey);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final key = viewModel.persistedKey.value;
      final name = key == null ? '新建页面文本' : '页面文本 ${key.id}';
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          FoxyTab(
            tabs: const [Text('页面文本'), Text('本地化')],
            disabledIndexes: key == null ? const {1} : const {},
            contents: [
              PageTextView(viewModel: viewModel),
              PageTextLocaleView(id: key?.id),
            ],
          ),
        ],
      );
    });
  }
}
