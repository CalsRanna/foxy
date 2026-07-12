import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_option_view.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_view.dart';
import 'package:foxy/page/gossip_menu/npc_text_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

@RoutePage()
class GossipMenuDetailPage extends StatefulWidget {
  final int? menuId;
  final int? textId;

  const GossipMenuDetailPage({super.key, this.menuId, this.textId});

  @override
  State<GossipMenuDetailPage> createState() => _GossipMenuDetailPageState();
}

class _GossipMenuDetailPageState extends State<GossipMenuDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), _buildTabs()],
    );
  }

  Widget _buildHeader() {
    final label = widget.menuId != null
        ? '对话 ${widget.menuId} / 文本 ${widget.textId ?? 0}'
        : '新建对话';
    var textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(label, style: textStyle);
    var edgeInsets = const EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }

  Widget _buildTabs() {
    final tabs = const [Text('对话'), Text('文本'), Text('选项')];
    final contents = [
      GossipMenuView(menuId: widget.menuId, textId: widget.textId),
      NpcTextView(textId: widget.textId ?? 0),
      GossipMenuOptionView(menuId: widget.menuId ?? 0),
    ];
    return FoxyTab(tabs: tabs, contents: contents);
  }
}
