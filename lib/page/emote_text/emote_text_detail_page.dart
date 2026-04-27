import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/emote_text/emote_text_detail_view_model.dart';
import 'package:foxy/page/emote_text/emote_text_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class EmoteTextDetailPage extends StatefulWidget {
  final int? id;

  const EmoteTextDetailPage({super.key, this.id});

  @override
  State<EmoteTextDetailPage> createState() => _EmoteTextDetailPageState();
}

class _EmoteTextDetailPageState extends State<EmoteTextDetailPage> {
  final viewModel = GetIt.instance.get<EmoteTextDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('表情文本'),
    ];

    var tabContents = [
      EmoteTextView(entry: widget.id),
    ];

    var tabBar = Watch((_) {
      return FoxyTab(
        tabs: tabs,
        contents: tabContents,
      );
    });

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.id != null ? '表情文本 #${widget.id}' : '新建表情文本';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
