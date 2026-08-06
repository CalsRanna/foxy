import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/emote_text/emote_text_view.dart';
import 'package:foxy/view_model/emote_text_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';

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
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            '表情文本详情',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        FoxyTab(
          tabs: const [Text('表情文本')],
          contents: [EmoteTextView(viewModel: viewModel)],
        ),
      ],
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.emoteTextKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${foxyErrorMessage(error)}');
    }
  }
}
