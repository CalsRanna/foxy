import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/page_text/page_text_view.dart';
import 'package:foxy/view_model/page_text_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class PageTextDetailPage extends StatefulWidget {
  final int? pageTextKey;

  const PageTextDetailPage({super.key, this.pageTextKey});

  @override
  State<PageTextDetailPage> createState() => _PageTextDetailPageState();
}

class _PageTextDetailPageState extends State<PageTextDetailPage> {
  final viewModel = GetIt.instance.get<PageTextDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FoxyHeader('页面文本详情'),
        ),
        FoxyTab(
          tabs: const [Text('页面文本')],
          contents: [PageTextView(viewModel: viewModel)],
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
      await viewModel.initSignals(key: widget.pageTextKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }
}
