import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/page_text/page_text_detail_view_model.dart';
import 'package:foxy/page/page_text/page_text_view.dart';
import 'package:foxy/page/page_text/page_text_locale_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class TextContentDetailPage extends StatefulWidget {
  final int? id;
  final String? label;

  const TextContentDetailPage({super.key, this.id, this.label});

  @override
  State<TextContentDetailPage> createState() => _TextContentDetailPageState();
}

class _TextContentDetailPageState extends State<TextContentDetailPage> {
  final viewModel = GetIt.instance.get<PageTextDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var name = widget.label?.isNotEmpty == true ? widget.label! : '新建页面文本';
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        FoxyTab(
          tabs: [Text('页面文本'), Text('本地化')],
          contents: [
            PageTextView(id: widget.id),
            PageTextLocaleView(id: widget.id),
          ],
        ),
      ],
    );
  }
}
