import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/emote_text/emote_text_detail_view_model.dart';
import 'package:foxy/page/emote_text/emote_text_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class EmoteTextDetailPage extends StatefulWidget {
  final int? emoteTextKey;

  const EmoteTextDetailPage({super.key, this.emoteTextKey});

  @override
  State<EmoteTextDetailPage> createState() => _EmoteTextDetailPageState();
}

class _EmoteTextDetailPageState extends State<EmoteTextDetailPage> {
  final viewModel = GetIt.instance.get<EmoteTextDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.emoteTextKey);
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
      final entity = viewModel.emote.value;
      final name = key == null
          ? '新建表情文本'
          : entity.name.isNotEmpty
          ? entity.name
          : '表情文本 #$key';
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
            tabs: const [Text('表情文本')],
            contents: [EmoteTextView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
