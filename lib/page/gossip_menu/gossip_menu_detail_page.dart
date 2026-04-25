import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_detail_view_model.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_option_view.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_view.dart';
import 'package:foxy/page/gossip_menu/npc_text_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class GossipMenuDetailPage extends StatefulWidget {
  final int? menuId;
  final int? textId;

  const GossipMenuDetailPage({super.key, this.menuId, this.textId});

  @override
  State<GossipMenuDetailPage> createState() => _GossipMenuDetailPageState();
}

class _GossipMenuDetailPageState extends State<GossipMenuDetailPage> {
  final viewModel = GetIt.instance.get<GossipMenuDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(menuId: widget.menuId, textId: widget.textId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), _buildTabs()],
    );
  }

  Widget _buildHeader() {
    return Watch((_) {
      final label = viewModel.creating.value
          ? '新建对话'
          : '对话 ${viewModel.menuId.value} / 文本 ${viewModel.textId.value}';
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
    });
  }

  Widget _buildTabs() {
    final tabs = [Text('对话'), Text('文本'), Text('选项')];
    final contents = [
      GossipMenuView(viewModel: viewModel),
      NpcTextView(parentViewModel: viewModel),
      GossipMenuOptionView(parentViewModel: viewModel),
    ];
    return FoxyTab(tabs: tabs, contents: contents);
  }
}
