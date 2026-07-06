import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/emote_text/emote_text_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

@RoutePage()
class EmoteTextDetailPage extends StatefulWidget {
  final int? id;
  final String? name;

  const EmoteTextDetailPage({super.key, this.id, this.name});

  @override
  State<EmoteTextDetailPage> createState() => _EmoteTextDetailPageState();
}

class _EmoteTextDetailPageState extends State<EmoteTextDetailPage> {
  @override
  Widget build(BuildContext context) {
    var tabs = [Text('表情文本')];

    var tabContents = [EmoteTextView(entry: widget.id)];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.name?.isNotEmpty == true
        ? widget.name!
        : (widget.id != null ? '表情文本 #${widget.id}' : '新建表情文本');
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
