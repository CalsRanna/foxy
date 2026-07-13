import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/game_object/game_object_template_view.dart';
import 'package:foxy/page/game_object/game_object_template_addon_view.dart';
import 'package:foxy/page/game_object/game_object_quest_item_view.dart';
import 'package:foxy/page/game_object/game_object_loot_template_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

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
  late int? gameObjectEntry = widget.entry;

  @override
  Widget build(BuildContext context) {
    var tabs = [Text('游戏对象模板'), Text('模版补充'), Text('任务物品'), Text('物品掉落')];

    var tabContents = [
      GameObjectTemplateView(
        entry: gameObjectEntry,
        onSaved: (entry) => setState(() => gameObjectEntry = entry),
      ),
      GameObjectTemplateAddonView(
        key: ValueKey('addon-$gameObjectEntry'),
        gameObjectId: gameObjectEntry ?? 0,
      ),
      GameObjectQuestItemView(
        key: ValueKey('quest-item-$gameObjectEntry'),
        gameObjectId: gameObjectEntry ?? 0,
      ),
      GameObjectLootTemplateView(
        key: ValueKey('loot-$gameObjectEntry'),
        gameObjectId: gameObjectEntry ?? 0,
      ),
    ];

    var tabBar = FoxyTab(
      tabs: tabs,
      contents: tabContents,
      disabledIndexes: gameObjectEntry == null || gameObjectEntry! <= 0
          ? const {1, 2, 3}
          : const {},
    );

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
