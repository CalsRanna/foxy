import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/game_object/game_object_template_detail_view_model.dart';
import 'package:foxy/page/game_object/game_object_template_view.dart';
import 'package:foxy/page/game_object/game_object_template_addon_view.dart';
import 'package:foxy/page/game_object/game_object_quest_item_view.dart';
import 'package:foxy/page/game_object/game_object_loot_template_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class GameObjectTemplateDetailPage extends StatefulWidget {
  final int? entry;
  final String? name;

  const GameObjectTemplateDetailPage({super.key, this.entry, this.name});

  @override
  State<GameObjectTemplateDetailPage> createState() =>
      _GameObjectTemplateDetailPageState();
}

class _GameObjectTemplateDetailPageState
    extends State<GameObjectTemplateDetailPage> {
  final viewModel = GetIt.instance.get<GameObjectTemplateDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [Text('游戏对象模板'), Text('模版补充'), Text('任务物品'), Text('物品掉落')];

    var tabContents = [
      GameObjectTemplateView(entry: widget.entry ?? 0),
      GameObjectTemplateAddonView(gameObjectId: widget.entry ?? 0),
      GameObjectQuestItemView(gameObjectId: widget.entry ?? 0),
      GameObjectLootTemplateView(gameObjectId: widget.entry ?? 0),
    ];

    var tabBar = Watch((_) {
      return FoxyTab(tabs: tabs, contents: tabContents);
    });

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.name?.isNotEmpty == true ? widget.name! : '新建游戏对象';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
