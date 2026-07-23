import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/page/game_object/game_object_loot_template_view.dart';
import 'package:foxy/page/game_object/game_object_quest_item_view.dart';
import 'package:foxy/page/game_object/game_object_template_addon_view.dart';
import 'package:foxy/page/game_object/game_object_template_detail_view_model.dart';
import 'package:foxy/page/game_object/game_object_template_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class GameObjectTemplateDetailPage extends StatefulWidget {
  final int? gameObjectTemplateKey;

  const GameObjectTemplateDetailPage({super.key, this.gameObjectTemplateKey});

  @override
  State<GameObjectTemplateDetailPage> createState() =>
      _GameObjectTemplateDetailPageState();
}

class _GameObjectTemplateDetailPageState
    extends State<GameObjectTemplateDetailPage> {
  final viewModel = GetIt.instance.get<GameObjectTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.gameObjectTemplateKey);
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
      final template = viewModel.entity.value;
      final entry = key;
      final name = key == null
          ? '新建游戏对象'
          : template?.name.isNotEmpty == true
          ? template?.name ?? ''
          : '游戏对象 #$key';
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          FoxyTab(
            tabs: const [
              Text('游戏对象模板'),
              Text('模版补充'),
              Text('任务物品'),
              Text('物品掉落'),
            ],
            contents: [
              GameObjectTemplateView(viewModel: viewModel),
              GameObjectTemplateAddonView(
                key: ValueKey('addon-$entry'),
                gameObjectId: entry ?? 0,
              ),
              GameObjectQuestItemView(
                key: ValueKey('quest-item-$entry'),
                gameObjectId: entry ?? 0,
              ),
              GameObjectLootTemplateView(
                key: ValueKey('loot-$entry'),
                parentKey: entry ?? 0,
              ),
            ],
            disabledIndexes: key == null ? const {1, 2, 3} : const {},
          ),
        ],
      );
    });
  }
}
