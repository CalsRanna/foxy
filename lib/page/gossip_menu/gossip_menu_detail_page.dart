import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/entity/gossip_menu_key.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_detail_view_model.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_option_view.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_view.dart';
import 'package:foxy/page/gossip_menu/npc_text_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class GossipMenuDetailPage extends StatefulWidget {
  final GossipMenuKey? gossipMenuKey;

  const GossipMenuDetailPage({super.key, this.gossipMenuKey});

  @override
  State<GossipMenuDetailPage> createState() => _GossipMenuDetailPageState();
}

class _GossipMenuDetailPageState extends State<GossipMenuDetailPage> {
  final viewModel = GetIt.instance.get<GossipMenuDetailViewModel>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.gossipMenuKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：$error');
    }
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
      final label = key == null
          ? '新建对话'
          : '对话 ${key.menuId} / 文本 ${key.textId}';
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          FoxyTab(
            tabs: const [Text('对话'), Text('文本'), Text('选项')],
            contents: [
              GossipMenuView(viewModel: viewModel),
              NpcTextView(key: ValueKey(key?.textId), textId: key?.textId ?? 0),
              GossipMenuOptionView(
                key: ValueKey(key?.menuId),
                menuId: key?.menuId ?? 0,
              ),
            ],
            disabledIndexes: key == null ? const {1, 2} : const {},
          ),
        ],
      );
    });
  }
}
